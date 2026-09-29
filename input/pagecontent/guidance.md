### Profiling approach

This guide is deliberately **light touch**:

- Reuse AU eRequesting and AU Core profiles wherever they fit, rather than creating new ones.
- Mark elements **Must Support** where the workflow needs them. Add few cardinality constraints and no new terminology.
- Leave local flavour (for example jurisdiction-specific extensions, identifiers, value sets and business rules).

### Relationship to AU eRequesting

| Function | AU eRequesting 1.0.1 | This guide |
|---|---|---|
| Diagnostic imaging request | Imaging ServiceRequest | Used as-is where it fits |
| Referral | Not covered | **Referral ServiceRequest** (from AU Base ServiceRequest, with eRequesting conventions) |
| Group Task | Group Task | Used as-is |
| Fulfilment Task | Task Diagnostic Request (focus limited to pathology/imaging requests) | **Referral Task** (focus → Referral ServiceRequest) |
| Patient, PractitionerRole, Organization | eRequesting profiles | Used as-is |
| Scheduling | Not covered | **Booking Schedule**, **Booking Slot**, **Referral Appointment** |

Conventions carried over from AU eRequesting:

- The placer group number (`PGN`) links the ServiceRequest `requisition` to the Task `groupIdentifier`.
- Task `status` and `businessStatus` use the AU eRequesting value sets.
- Fulfilment Tasks are tagged with `fulfilment-task` and are `partOf` a Group Task tagged `fulfilment-task-group`.

### Referencing directory resources

The receiving service (`ServiceRequest.performer`) and scheduling actors (`Schedule.actor`, `Appointment.participant.actor`) usually come from a provider directory. The suggested approach is a **logical reference by identifier** (e.g. HPI-O) **with a display**, plus a literal reference where the directory resource is available on the referral server. This avoids coupling to directory resource ids. See [Open Issues](open-issues.html).

### Must Support

Must Support has the meaning defined in [AU Core](https://hl7.org.au/fhir/core/2.0.0/general-requirements.html#must-support-and-obligation). The FHIR For Services group can refine this per actor (for example with obligations).
