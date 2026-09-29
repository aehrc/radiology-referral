Profile:        BookingSlot
Parent:         Slot
Id:             booking-slot
Title:          "Booking Slot"
Description:    "A bookable time interval on a Booking Schedule. Referrers (or patient apps) search for free Slots and book them by creating a Referral Appointment."
* ^status = #draft
* ^experimental = true

* identifier MS
* serviceType MS
* specialty MS
* appointmentType MS
* schedule MS
* schedule only Reference(BookingSchedule)
* status MS
* status ^short = "free | busy | busy-unavailable | busy-tentative | entered-in-error"
* start MS
* end MS
* comment MS
