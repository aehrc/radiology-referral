Profile:        ReferralServiceRequest
Parent:         $AUBaseServiceRequest
Id:             referral-servicerequest
Title:          "Referral ServiceRequest"
Description:    "A referral from a referrer (placer) to a receiving service (filler), for example a radiology referral. Follows the AU eRequesting conventions (placer group number, request status, eRequesting actor profiles) but is not restricted to diagnostic requests."
* ^status = #draft
* ^experimental = true

* identifier MS
* identifier ^short = "Placer referral identifier"

* requisition 1..1 MS
* requisition.type = $v2-0203#PGN
* requisition ^short = "Placer group number – shared with the eRequesting Group Task"

* status MS
* status from $AUeRequestingRequestStatus (required)
* intent = #order
* intent MS

* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains referral 1..1 MS
* category[referral] = $SCT#3457005
* category ^short = "Referral, plus optional discipline (e.g. imaging 363679005)"

* priority MS
* code 1..1 MS
* code ^short = "Service being referred for e.g. interventional imaging"
* subject only Reference($AUeRequestingPatient)
* subject MS
* encounter MS
* occurrence[x] MS
* occurrence[x] ^short = "Requested timeframe (e.g. within 2 weeks)"
* authoredOn 1..1 MS
* requester 1..1 MS
* requester only Reference($AUeRequestingPractitionerRole)

* performerType MS
* performer MS
* performer only Reference($AUBaseHealthcareService or $AUeRequestingOrganization or $AUeRequestingPractitionerRole)
* performer ^short = "Receiving service, as found in the provider directory"
* performer ^comment = "May be a literal reference to a directory resource and/or a logical reference by identifier (e.g. HPI-O) with display. See the Open Issues page."

* reasonCode MS
* reasonReference MS
* insurance MS
* supportingInfo MS
* supportingInfo ^short = "Clinical information supporting the referral (e.g. eGFR, allergies, prior reports)"
* note MS
