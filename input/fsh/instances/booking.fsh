// Scheduling: filler publishes a Schedule and Slots; referrer books one.

Instance:    schedule-northside-ct
InstanceOf:  BookingSchedule
Title:       "Schedule – CT at Northside Imaging, Chermside"
Description: "Example: CT at Northside Imaging, Chermside (CT abdomen/pelvis storyline)."
Usage:       #example
* active = true
* serviceType = $SCT#310128004 "Computed tomography service"
* actor[+] = Reference(healthcareservice-northside-ct)
* actor[+] = Reference(location-northside-imaging-chermside)
* planningHorizon.start = "2026-09-29T00:00:00+10:00"
* planningHorizon.end = "2026-12-31T23:59:59+10:00"

Instance:    slot-ct-20261006-0900
InstanceOf:  BookingSlot
Title:       "Slot – CT 6 Oct 2026 09:00 (busy)"
Description: "Example: CT 6 Oct 2026 09:00 (busy) (CT abdomen/pelvis storyline)."
Usage:       #example
* serviceType = $SCT#310128004 "Computed tomography service"
* schedule = Reference(schedule-northside-ct)
* status = #busy
* start = "2026-10-06T09:00:00+10:00"
* end = "2026-10-06T09:30:00+10:00"

Instance:    slot-ct-20261006-0930
InstanceOf:  BookingSlot
Title:       "Slot – CT 6 Oct 2026 09:30 (free)"
Description: "Example: CT 6 Oct 2026 09:30 (free) (CT abdomen/pelvis storyline)."
Usage:       #example
* serviceType = $SCT#310128004 "Computed tomography service"
* schedule = Reference(schedule-northside-ct)
* status = #free
* start = "2026-10-06T09:30:00+10:00"
* end = "2026-10-06T10:00:00+10:00"

Instance:    appointment-ct-booked
InstanceOf:  ReferralAppointment
Title:       "Appointment – CT abdomen and pelvis (booked)"
Description: "Example: CT abdomen and pelvis (booked) (CT abdomen/pelvis storyline)."
Usage:       #example
* status = #booked
* serviceType = $SCT#310128004 "Computed tomography service"
* reasonReference = Reference(condition-ruq-pain)
* start = "2026-10-06T09:00:00+10:00"
* end = "2026-10-06T09:30:00+10:00"
* slot = Reference(slot-ct-20261006-0900)
* created = "2026-09-30"
* basedOn = Reference(referral-ct-abdo-pelvis)
* patientInstruction = "Fast for 4 hours before your scan. Arrive 30 minutes early."
* participant[+].actor = Reference(patient-jayson-humphries)
* participant[=].status = #accepted
* participant[+].actor = Reference(location-northside-imaging-chermside)
* participant[=].status = #accepted
* participant[+].actor = Reference(healthcareservice-northside-ct)
* participant[=].status = #accepted
