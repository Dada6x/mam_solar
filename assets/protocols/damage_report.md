---
protocol: damage_report
title: Damage Report
title_de: Schadensbericht
title_ar: تقرير الضرر
version: 1.1
---

## Damage Declaration
section_id: damage_declaration

- damageType       | dropdown | required | Damage Type | Schadensart | نوع الضرر
  options: at_customer, at_third_party, material_damage
- causedByPartner  | checkbox |          | Caused by Partner Company | Durch Partnerfirma verursacht | بسبب شركة شريكة
- companyLiability | checkbox |          | Company Liability | Firmenhaftung | مسؤولية الشركة

+ ## Injured Party
section_id: injured_party

- injuredName | text  | required | Injured Party Name | Name des Geschädigten | اسم الطرف المتضرر
- street      | text  |          | Street | Straße | الشارع
- zipCode     | text  |          | ZIP Code | PLZ | الرمز البريدي
- city        | text  |          | City | Stadt | المدينة
- phone       | text  |          | Phone | Telefon | الهاتف
- email       | email |          | Email | E-Mail | البريد الإلكتروني

## Incident Details
section_id: incident_details

- incidentDate         | date     | required | Incident Date | Vorfallsdatum | تاريخ الحادث
- incidentTime         | time     |          | Incident Time | Vorfallszeit | وقت الحادث
- secondPersonInvolved | checkbox |          | Second Person Involved | Zweite Person beteiligt | شخص ثانٍ متورط

## Damage Description
section_id: damage_description

- initialSituation | textarea | required | Initial Situation | Ausgangssituation | الوضع الأولي
- incidentSequence | textarea | required | Incident Sequence | Vorfallshergang | تسلسل الحادث

## Affected Devices
section_id: affected_devices
repeatable: true
min: 1
max: 10

- deviceName        | text     |          | Device Name | Gerätename | اسم الجهاز
- deviceBrand       | text     |          | Device Brand | Gerätemarke | العلامة التجارية للجهاز
- damageDescription | textarea |          | Damage Description | Schadensbeschreibung | وصف الضرر
---
- devicePhoto | photo |          | Device Photo | Gerätefoto | صورة الجهاز

## Damage Minimization
section_id: damage_minimization

- minimizationPossible | checkbox |          | Minimization Possible | Minimierung möglich | التقليل ممكن
- minimizationNotes    | textarea |          | Minimization Notes | Minimierungsnotizen | ملاحظات التقليل
  show_if: minimizationPossible == true

+ ## Insurance
section_id: insurance

- insuranceNotes | textarea |          | Insurance Notes | Versicherungsnotizen | ملاحظات التأمين

## Employee Info
section_id: employee_info

- employeeName | text | required | Employee Name | Mitarbeitername | اسم الموظف

+ ## Remarks
section_id: remarks

- remarks | textarea |          | Remarks | Bemerkungen | ملاحظات

## Signatures
section_id: signatures

- damagedPartySignature | signature | required | Damaged Party Signature | Unterschrift Geschädigter | توقيع الطرف المتضرر
- employeeSignature     | signature | required | Employee Signature | Mitarbeiterunterschrift | توقيع الموظف