// Actors for the CT abdomen/pelvis storyline. Directory-sourced resources
// (Organization, HealthcareService, Location) would normally come from HCPD.

Alias: $PGN-SYSTEM = http://ns.electronichealth.net.au/id/hpio-scoped/order/1.0/8003621566684455

Instance:    patient-jayson-humphries
InstanceOf:  $AUeRequestingPatient
Title:       "Patient – Jayson Humphries"
Description: "Example: Jayson Humphries (CT abdomen/pelvis storyline). Demographics from the HL7 AU test data set (Patient humphries-jayson)."
Usage:       #example
* identifier[ihi].type = $v2-0203#NI "National unique individual identifier"
* identifier[ihi].type.text = "IHI"
* identifier[ihi].system = $IHI
* identifier[ihi].value = "8003608333647253"
* name.use = #official
* name.family = "HUMPHRIES"
* name.given = "Jayson"
* telecom.system = #phone
* telecom.value = "0491572665"
* telecom.use = #mobile
* gender = #other
* birthDate = "1968-05-14"
* address.line = "41 Queen St"
* address.city = "Areyonga"
* address.state = "NT"
* address.postalCode = "0872"
* address.country = "AU"

Instance:    practitioner-alex-chen
InstanceOf:  $AUeRequestingPractitioner
Title:       "Practitioner – Dr Alex Chen (GP)"
Description: "Example: Dr Alex Chen (GP) (CT abdomen/pelvis storyline)."
Usage:       #example
* identifier[hpii].type = $v2-0203#NPI "National provider identifier"
* identifier[hpii].type.text = "HPI-I"
* identifier[hpii].system = $HPI-I
* identifier[hpii].value = "8003619900015717"
* name.family = "Chen"
* name.given = "Alex"
* name.prefix = "Dr"

Instance:    practitionerrole-gp-alex-chen
InstanceOf:  $AUeRequestingPractitionerRole
Title:       "PractitionerRole – GP at Riverside Family Practice"
Description: "Example: GP at Riverside Family Practice (CT abdomen/pelvis storyline)."
Usage:       #example
* identifier[medicareProvider].type = $au-v2-0203#UPIN "Medicare Provider Number"
* identifier[medicareProvider].system = $MEDICARE-PROVIDER
* identifier[medicareProvider].value = "2426621B"
* practitioner = Reference(practitioner-alex-chen)
* organization = Reference(organization-riverside-family-practice)
* code = $SCT#62247001 "General practitioner"
* telecom.system = #phone
* telecom.value = "0755501234"

Instance:    organization-riverside-family-practice
InstanceOf:  $AUeRequestingOrganization
Title:       "Organization – Riverside Family Practice (referrer)"
Description: "Example: Riverside Family Practice (referrer) (CT abdomen/pelvis storyline)."
Usage:       #example
* identifier[hpio].type = $au-v2-0203#NOI "National Organisation Identifier"
* identifier[hpio].type.text = "HPI-O"
* identifier[hpio].system = $HPI-O
* identifier[hpio].value = "8003621566684455"
* name = "Riverside Family Practice"
* telecom.system = #phone
* telecom.value = "0755501234"
* address.city = "Brisbane"
* address.state = "QLD"
* address.country = "AU"

Instance:    organization-northside-imaging
InstanceOf:  $AUeRequestingOrganization
Title:       "Organization – Northside Imaging (filler)"
Description: "Example: Northside Imaging (filler) (CT abdomen/pelvis storyline)."
Usage:       #example
* identifier[hpio].type = $au-v2-0203#NOI "National Organisation Identifier"
* identifier[hpio].type.text = "HPI-O"
* identifier[hpio].system = $HPI-O
* identifier[hpio].value = "8003623233370062"
* name = "Northside Imaging"
* telecom.system = #phone
* telecom.value = "0755509876"
* address.city = "Chermside"
* address.state = "QLD"
* address.country = "AU"

Instance:    location-northside-imaging-chermside
InstanceOf:  $AUBaseLocation
Title:       "Location – Northside Imaging, Chermside"
Description: "Example: Northside Imaging, Chermside (CT abdomen/pelvis storyline)."
Usage:       #example
* status = #active
* name = "Northside Imaging – Chermside"
* address.line = "1 Imaging Way"
* address.city = "Chermside"
* address.state = "QLD"
* address.postalCode = "4032"
* address.country = "AU"
* managingOrganization = Reference(organization-northside-imaging)

Instance:    healthcareservice-northside-ct
InstanceOf:  $AUBaseHealthcareService
Title:       "HealthcareService – CT at Northside Imaging"
Description: "Example: CT at Northside Imaging (CT abdomen/pelvis storyline)."
Usage:       #example
* active = true
* providedBy = Reference(organization-northside-imaging)
* type = $SCT#310128004 "Computed tomography service"
* name = "Computed Tomography – Chermside"
* location = Reference(location-northside-imaging-chermside)
