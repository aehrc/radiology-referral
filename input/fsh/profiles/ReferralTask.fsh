Profile:        ReferralTask
Parent:         $AUeRequestingTask
Id:             referral-task
Title:          "Referral Task"
Description:    "Fulfilment Task for a Referral ServiceRequest. Mirrors the AU eRequesting Task Diagnostic Request pattern (a fulfilment Task that is partOf an AU eRequesting Group Task) but allows a Referral ServiceRequest as the focus. The filler updates status and businessStatus to communicate triage and booking progress."
* ^status = #draft
* ^experimental = true

* meta.tag[eRequestingFulfilmentTask] = $resource-tag#fulfilment-task
* partOf 1..1 MS
* partOf only Reference($AUeRequestingTaskGroup)
* focus 1..1 MS
* focus only Reference(ReferralServiceRequest)
* owner MS
* owner ^short = "Receiving (filler) organisation"
* statusReason ^short = "Reason for rejected / on-hold (e.g. contrast allergy – please confirm)"
