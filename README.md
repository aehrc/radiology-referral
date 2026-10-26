# Radiology Referral and Booking IG

FHIR R4 Implementation Guide for **Connected Test Scenario 2A**: radiology referral with directory discovery, triage, booking and status tracking. Builds on **AU eRequesting 1.0.1**, AU Core 2.0.0 and AU Base 6.0.0.

It adds:

| Profile | Parent |
|---|---|
| Referral ServiceRequest | AU Base ServiceRequest |
| Referral Task | AU eRequesting Task |
| Booking Schedule | Schedule |
| Booking Slot | Slot |
| Referral Appointment | Appointment |

The guide is deliberately light touch, so the FHIR For Services group can add its own constraints, terminology and local extensions. See `input/pagecontent/open-issues.md` for the decisions still to make.

## Build

Needs Java 17+ and SUSHI (`npm install -g fsh-sushi`).

```bash
bash _updatePublisher.sh   # one-time: downloads publisher.jar into input-cache/
bash _genonce.sh           # runs SUSHI + IG Publisher, output in output/
```

Open `output/index.html` for the guide and `output/qa.html` for validation results.

## Layout

```
input/fsh/profiles/       profiles (FSH)
input/fsh/instances/      examples for the CT abdomen/pelvis storyline
input/pagecontent/        narrative pages (index, workflow, guidance, open-issues)
input/images-source/      PlantUML diagrams, rendered by the IG Publisher
aehrc-template/           IG template (copied from aehrc-quokka-ig)
```
