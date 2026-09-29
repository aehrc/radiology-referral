<div class="dragon" role="alert" markdown="1">
This guide is a starting point for the 2026 Queensland Health Connectathon - FHIR For Services group. Scope, identifiers, canonical URL, profiles and terminology are all expected to change.
</div>

### Introduction

This Implementation Guide supports a radiology referral workflow. A referrer:

1. **discovers** a suitable imaging service in a provider directory (e.g. the Health Connect Provider Directory, HCPD),
2. **creates** a referral (ServiceRequest plus supporting information) on a referral server,
3. has the referral **triaged** by the imaging provider,
4. **books** an appointment against Slots the imaging provider publishes, and
5. **tracks** the referral's status through a Task until the appointment is confirmed and the service is complete.

The guide builds on [AU eRequesting 1.0.1](https://hl7.org.au/fhir/ereq/1.0.1/), [AU Core 2.0.0](https://hl7.org.au/fhir/core/2.0.0/) and [AU Base 6.0.0](https://hl7.org.au/fhir/6.0.0/). It adds the parts that AU eRequesting does not cover:

- a **Referral ServiceRequest** profile,
- a **Referral Task** profile, so a referral can use the eRequesting Group Task / fulfilment Task pattern,
- **Booking Schedule**, **Booking Slot** and **Referral Appointment** profiles for scheduling.

### Where to start

| Page | Content |
|---|---|
| [Workflow](workflow.html) | Actors, steps, interactions and state transitions |
| [Guidance](guidance.html) | Profiling approach and how this guide relates to AU eRequesting |
| [Artefacts](artifacts.html) | Profiles and examples |
| [Open Issues](open-issues.html) | Decisions for the FHIR For Services group |

### Profiles

| Profile | Based on | Purpose |
|---|---|---|
| [Referral ServiceRequest](StructureDefinition-referral-servicerequest.html) | AU Base ServiceRequest | The referral |
| [Referral Task](StructureDefinition-referral-task.html) | AU eRequesting Task | Fulfilment Task for a referral, `partOf` an AU eRequesting Group Task |
| [Booking Schedule](StructureDefinition-booking-schedule.html) | Schedule | Container for a service's bookable Slots |
| [Booking Slot](StructureDefinition-booking-slot.html) | Slot | A bookable time interval |
| [Referral Appointment](StructureDefinition-referral-appointment.html) | Appointment | A booking that fulfils a referral |

AU eRequesting profiles (Patient, PractitionerRole, Organization, Group Task, imaging ServiceRequest) are used as-is.

### Dependencies

{% include dependency-table.xhtml %}
