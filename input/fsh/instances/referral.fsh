// Referral: CT abdomen and pelvis with contrast, RUQ pain + abnormal LFTs.

Instance:    condition-ruq-pain
InstanceOf:  $AUCoreCondition
Title:       "Condition – Right upper quadrant pain"
Description: "Example: Right upper quadrant pain (CT abdomen/pelvis storyline)."
Usage:       #example
* clinicalStatus = $condition-clinical#active
* category = $condition-category#problem-list-item
* code = $SCT#301717006 "Right upper quadrant pain"
* subject = Reference(patient-jayson-humphries)
* onsetDateTime = "2026-09-20"

Instance:    observation-egfr
InstanceOf:  Observation
Title:       "Observation – eGFR (pre-contrast screening)"
Description: "Example: eGFR (pre-contrast screening) (CT abdomen/pelvis storyline)."
Usage:       #example
* status = #final
* category = $observation-category#laboratory
* code = $LNC#98979-8 "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M"
* subject = Reference(patient-jayson-humphries)
* effectiveDateTime = "2026-09-28"
* valueQuantity = 78 'mL/min/{1.73_m2}' "mL/min/{1.73_m2}"

Instance:    referral-ct-abdo-pelvis
InstanceOf:  ReferralServiceRequest
Title:       "Referral – CT abdomen and pelvis with contrast"
Description: "Example: CT abdomen and pelvis with contrast (CT abdomen/pelvis storyline)."
Usage:       #example
* identifier.system = $PGN-SYSTEM
* identifier.value = "RFP-000123-1"
* requisition.system = $PGN-SYSTEM
* requisition.value = "RFP-000123"
* status = #active
* intent = #order
* category[referral] = $SCT#3457005 "Patient referral"
* category[1] = $SCT#363679005 "Imaging"
* priority = #routine
* code = $SCT#432370003 "CT of abdomen and pelvis with contrast"
* code.text = "CT abdomen and pelvis with contrast"
* subject = Reference(patient-jayson-humphries)
* occurrencePeriod.start = "2026-09-29"
* occurrencePeriod.end = "2026-10-13"
* authoredOn = "2026-09-29T10:15:00+10:00"
* requester = Reference(practitionerrole-gp-alex-chen)
* performerType = $SCT#310128004 "Computed tomography service"
* performer = Reference(healthcareservice-northside-ct)
* reasonCode = $SCT#166603001 "Liver function tests abnormal"
* reasonReference = Reference(condition-ruq-pain)
* supportingInfo = Reference(observation-egfr)
* note.text = "No known allergy to iodinated contrast. Please book within 2 weeks."

Instance:    task-group-referral
InstanceOf:  $AUeRequestingTaskGroup
Title:       "Task – Group Task for the referral"
Description: "Example: Group Task for the referral (CT abdomen/pelvis storyline)."
Usage:       #example
* meta.tag[eRequestingFulfilmentTask] = $resource-tag#fulfilment-task-group
* groupIdentifier.type = $v2-0203#PGN
* groupIdentifier.system = $PGN-SYSTEM
* groupIdentifier.value = "RFP-000123"
* status = #in-progress
* businessStatus = $task-business-status#service-booked
* intent = #order
* priority = #routine
* code = $task-code#fulfill
* for = Reference(patient-jayson-humphries)
* authoredOn = "2026-09-29T10:15:00+10:00"
* lastModified = "2026-09-30T09:00:00+10:00"
* requester = Reference(practitionerrole-gp-alex-chen)
* owner = Reference(organization-northside-imaging)

Instance:    task-referral-ct
InstanceOf:  ReferralTask
Title:       "Task – Referral Task (booked)"
Description: "Example: Referral Task (booked) (CT abdomen/pelvis storyline)."
Usage:       #example
* meta.tag[eRequestingFulfilmentTask] = $resource-tag#fulfilment-task
* identifier.system = $PGN-SYSTEM
* identifier.value = "RFP-000123-1"
* groupIdentifier.type = $v2-0203#PGN
* groupIdentifier.system = $PGN-SYSTEM
* groupIdentifier.value = "RFP-000123"
* partOf = Reference(task-group-referral)
* status = #in-progress
* businessStatus = $task-business-status#service-booked
* intent = #order
* priority = #routine
* code = $task-code#fulfill
* focus = Reference(referral-ct-abdo-pelvis)
* for = Reference(patient-jayson-humphries)
* authoredOn = "2026-09-29T10:15:00+10:00"
* lastModified = "2026-09-30T09:00:00+10:00"
* requester = Reference(practitionerrole-gp-alex-chen)
* owner = Reference(organization-northside-imaging)
