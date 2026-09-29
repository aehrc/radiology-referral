Profile:        BookingSchedule
Parent:         Schedule
Id:             booking-schedule
Title:          "Booking Schedule"
Description:    "A container for bookable Slots published by the receiving service, for example a CT service at an imaging site."
* ^status = #draft
* ^experimental = true

* identifier MS
* active MS
* serviceType MS
* serviceType ^short = "Type of service (e.g. Computed tomography service)"
* specialty MS
* actor MS
* actor only Reference($AUBaseHealthcareService or $AUBaseLocation or $AUCorePractitionerRole)
* actor ^short = "HealthcareService, Location and/or PractitionerRole the Schedule belongs to"
* planningHorizon MS
