This page describes the end-to-end radiology referral workflow. It is a strawman: the steps follow the scenario draft and are expected to be refined by the FHIR For Services group.

### Actors

| Actor | Role | Main resources |
|---|---|---|
| **Referrer** (Placer) | GP or hospital clinician system. Searches the directory, raises the referral, books (or lets the filler book), tracks status. | ServiceRequest, Task (create), Appointment (create) |
| **Provider Directory** | Source of truth for organisations, services, locations, practitioner roles and endpoints (e.g. HCPD). | HealthcareService, Location, Organization, PractitionerRole, Endpoint |
| **Referral Server** | FHIR server holding referrals, Tasks and scheduling resources. | All of the above |
| **Imaging Provider** (Filler) | RIS / booking system. Triages referrals, publishes availability, confirms bookings. | Task (update), Schedule, Slot, Appointment (update) |
| *Patient app (stretch)* | Lets the patient view the referral and self-book. | Slot (search), Appointment (create) |

### Sequence

{% include workflow-sequence.svg %}

### Steps

#### 0. Publish availability (ongoing)

The filler maintains a [Booking Schedule](StructureDefinition-booking-schedule.html) (`actor` → HealthcareService / Location) and [Booking Slots](StructureDefinition-booking-slot.html) (`status=free`), usually by syncing them from the RIS.

This is not a step in any one referral. Slots are the service's capacity for every referrer, and they exist before a referral is raised and whatever its triage outcome. Triage controls whether and what to book (step 4), not whether Slots are published.

#### 1. Discover an imaging service

The referrer searches the provider directory for a suitable service and resolves the **Endpoint** of the receiving referral server.

```
GET [directory]/HealthcareService?service-type=<CT>&location.address-state=QLD
      &_include=HealthcareService:location&_include=HealthcareService:organization
GET [directory]/Endpoint?organization=<id>
```

Search parameters depend on the directory's published API and are to be confirmed.

Optionally, the referrer can check free Slots at this point to choose a provider that can meet the required timeframe (see step 4 for the query).

#### 2. Create the referral

The referrer POSTs a transaction Bundle containing:

- a [Referral ServiceRequest](StructureDefinition-referral-servicerequest.html) (`status=active`, `intent=order`, `performer` → the chosen HealthcareService or Organization, `requisition` = placer group number),
- an [AU eRequesting Group Task](https://hl7.org.au/fhir/ereq/1.0.1/StructureDefinition-au-erequesting-task-group.html) (`status=requested`, `groupIdentifier` = placer group number, `owner` → filler Organization),
- a [Referral Task](StructureDefinition-referral-task.html) (`partOf` → Group Task, `focus` → ServiceRequest),
- supporting resources: Patient, PractitionerRole, Condition, Observation (e.g. eGFR), AllergyIntolerance, DocumentReference, Coverage.

For an imaging order that fits AU eRequesting exactly, the [AU eRequesting Imaging ServiceRequest](https://hl7.org.au/fhir/ereq/1.0.1/StructureDefinition-au-erequesting-servicerequest-imag.html) and [Task Diagnostic Request](https://hl7.org.au/fhir/ereq/1.0.1/StructureDefinition-au-erequesting-task-diagnosticrequest.html) can be used instead. See [Open Issues](open-issues.html).

#### 3. Triage

The filler retrieves new work:

```
GET [ref]/Task?owner=Organization/<id>&status=requested&_include=Task:focus
```

It updates the Referral Task (and Group Task) to `accepted`, `rejected` or `on-hold`, with a `statusReason` where needed (e.g. "contrast allergy – please confirm").

Triage can narrow the service to book (for example, contrast versus non-contrast, a different protocol or modality, or urgency). Where it does, the filler records the triaged service on the ServiceRequest or in `Task.output` so that the booking step can use it.

#### 4. Book

Booking follows triage. Two variants are supported (see [Open Issues](open-issues.html), #4).

**Referrer books.** The referrer books only when the Referral Task is `accepted`. While the Task is `requested` or `on-hold`, it must not create an Appointment. It searches free Slots for the triaged service:

```
GET [ref]/Slot?schedule.actor=HealthcareService/<id>&status=free&start=ge2026-10-01&service-type=<CT>
```

It then creates a [Referral Appointment](StructureDefinition-referral-appointment.html) with `status=proposed`, `basedOn` → ServiceRequest, `slot` → Slot and the patient as a participant. The filler then confirms or declines it:

| Outcome | Appointment | Slot | Referral Task / Group Task |
|---|---|---|---|
| Confirmed | `booked` | `busy` | `status=in-progress`, `businessStatus=service-booked` |
| Declined (e.g. Slot does not suit the triaged service) | `cancelled` (with `cancelationReason`) | `free` | unchanged (`accepted`) |

The filler should update the Appointment and Slot together so that two referrers cannot book the same Slot. It may also mark the Slot `busy-tentative` when the proposed Appointment arrives.

**Filler books.** After accepting, the filler creates the Appointment directly (`status=booked`), sets the Slot to `busy` and updates the Task as above. The referrer learns of the booking through tracking. In this variant, Slots do not need to be published to the shared server.

**Cancel and rebook:** Appointment → `cancelled` (with `cancelationReason`), Slot → `free`, then a new Appointment is created against another Slot.

#### 5. Track

The referrer polls (or subscribes to) the Task and Appointment and displays `status` and `businessStatus`.

*Stretch:* the filler returns a DiagnosticReport / ImagingStudy and sets the Task to `completed`.

### Task state transitions

{% include workflow-task-states.svg %}

`status` values are from the [AU eRequesting Task Status](https://hl7.org.au/fhir/ereq/1.0.1/ValueSet-au-erequesting-task-status.html) value set. `businessStatus` values are from the [AU eRequesting Task Business Status](https://hl7.org.au/fhir/ereq/1.0.1/ValueSet-au-erequesting-task-businessstatus.html) value set.

### Appointment and Slot states

| Event | Appointment.status | Slot.status |
|---|---|---|
| Slot published | – | `free` |
| Booking requested | `proposed` / `pending` | `busy-tentative` (optional) |
| Booking confirmed | `booked` | `busy` |
| Booking declined by filler | `cancelled` | `free` |
| Booking cancelled | `cancelled` | `free` |
| Patient attended | `arrived` → `fulfilled` | `busy` |
| Patient did not attend | `noshow` | `busy` |

### Example walk-through

The examples in this guide follow the storyline: a 58-year-old patient with right upper quadrant pain and abnormal LFTs is referred by their GP for a **CT abdomen and pelvis with contrast** within 2 weeks.

| Step | Example |
|---|---|
| Referral | [Referral – CT abdomen and pelvis](ServiceRequest-referral-ct-abdo-pelvis.html) |
| Supporting info | [Condition – RUQ pain](Condition-condition-ruq-pain.html), [Observation – eGFR](Observation-observation-egfr.html) |
| Tasks | [Group Task](Task-task-group-referral.html), [Referral Task](Task-task-referral-ct.html) |
| Availability | [Schedule](Schedule-schedule-northside-ct.html), [Slot (busy)](Slot-slot-ct-20261006-0900.html), [Slot (free)](Slot-slot-ct-20261006-0930.html) |
| Booking | [Appointment (booked)](Appointment-appointment-ct-booked.html) |
