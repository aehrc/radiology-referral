Profile:        ReferralAppointment
Parent:         Appointment
Id:             referral-appointment
Title:          "Referral Appointment"
Description:    "A booking made against a Booking Slot to fulfil a referral. The requester creates it as proposed (or pending); the receiving service confirms it as booked."
* ^status = #draft
* ^experimental = true

* identifier MS
* status MS
* status ^short = "proposed | pending | booked | arrived | fulfilled | cancelled | noshow | entered-in-error | checked-in | waitlist"
* cancelationReason MS
* serviceType MS
* appointmentType MS
* reasonReference MS
* start MS
* end MS
* slot MS
* slot only Reference(BookingSlot)
* basedOn 1..* MS
* basedOn only Reference(ReferralServiceRequest or $AUeRequestingServiceRequestImag)
* basedOn ^short = "The referral (or eRequesting imaging request) this booking fulfils"
* patientInstruction MS
* participant MS
* participant.actor MS
* participant.actor ^short = "Patient, plus Location / HealthcareService / PractitionerRole where known"
* participant.status MS
