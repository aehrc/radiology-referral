Decisions the FHIR For Services group should make.

| # | Topic | Question |  Proposed Disposition |
|---|---|---|---|
| 1 | Referral vs eRequesting imaging request | Should a radiology referral use the AU eRequesting Imaging ServiceRequest, the Referral ServiceRequest, or a profile derived from the eRequesting imaging request? | Referral ServiceRequest for referrals in general. eRequesting Imaging ServiceRequest remains valid for diagnostic imaging orders. |
| 2 | Jurisdictional referrals IG | Which jurisdictional referrals IG (e.g. Queensland Health) and version applies? Does it profile Schedule/Slot/Appointment? | Not included. Add as a dependency once confirmed. |
| 3 | Directory linkage | Reference directory resources literally (absolute URLs) or logically (HPI-O / HPI-I identifiers)? | Identifier plus display, with a literal reference where available. |
| 4 | Who books? | Does the referrer book directly against open Slots, or does the filler book after triage? | Support both as variants. |
| 5 | Transport | FHIR REST on a shared referral server, or push to the filler's own endpoint found via the directory? | Shared referral server for the connectathon. |
| 6 | Notifications | Polling vs FHIR Subscriptions (R4 backport) for new Tasks and status changes. | Polling; Subscriptions as a stretch. |
| 7 | Security | Open server vs SMART Backend Services. | Open server for the connectathon. |
| 8 | Terminology | Imaging procedure value set (RANZCR / AU eRequesting vs local RIS catalogue); directory service-type codes for imaging; referral category codes. | No bindings added. The FHIR For Services group should choose. |
| 9 | Business status | Are the AU eRequesting Task business status codes enough for referral triage and booking (e.g. "triaged", "awaiting booking")? | Use AU eRequesting codes. Extend only if gaps are found. |
| 10 | Canonical and ownership | Canonical URL, package id, publisher. | Placeholders. |
| 11 | Report return | Should the IG cover DiagnosticReport / ImagingStudy return and Task completion? | Out of scope (stretch). |
