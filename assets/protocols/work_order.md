---
protocol: work_order
title: Work Order
title_de: Regie-/Arbeitsauftrag
title_ar: أمر العمل
version: 2.0
company: MAM Solarbau
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- fullName | text | required | Full Name (or Company) | Vollständiger Name (oder Firma) | الاسم الكامل (أو الشركة)
- street | text |required | Street | Straße | الشارع
- city | text | required | City | Stadt | المدينة
- zipCity | text | required | ZIP / City | PLZ / Ort | الرمز البريدي / المدينة
- email | email | required | Email | E-Mail | البريد الإلكتروني
- phone | text | required | Phone | Telefon | الهاتف

## Work Description | Arbeitsbeschreibung | وصف العمل

section_id: work_description

- description | textarea | required | Description | Beschreibung | الوصف
- workDetail | textarea | | Work Detail | Arbeitsdetail | تفاصيل العمل

## Materials | Materialverbrauch | استهلاك المواد

section_id: materials
repeatable: true
min: 0
max: 30

- quantity | number | | Quantity | Menge | الكمية
- unit | dropdown | | Unit | Einheit | الوحدة
  options: piece, meter, kg, liter, set
- material | text | | Material / Article | Material / Artikel | المادة / الصنف

## Vehicle / Travel | Fahrzeug / Anreise | المركبة / السفر

section_id: travel
repeatable: true
min: 0
max: 10

- licensePlate | text | | License Plate | Kennzeichen | لوحة الترخيص
- departure | text | | Departure (City/Address) | Abfahrt (Ort/Adresse) | المغادرة (المدينة/العنوان)
- destination | text | | Destination (City/Address) | Zielort (Ort/Adresse) | الوجهة (المدينة/العنوان)
- kilometers | number | | Kilometers driven | Gefahrene Kilometer | الكيلومترات المقطوعة

## Working Hours | Arbeitszeit | ساعات العمل

section_id: working_hours

repeatable: true
min: 1
max: 14

- date | date | | Date | Datum | التاريخ
- techName | text | | Technician Name | Technikername | اسم الفني
- startTime | time | | Start Time | Startzeit | وقت البدء
- endTime | time | | End Time | Endzeit | وقت الانتهاء
- duration | text | | Duration | Arbeitsdauer | المدة
  formula: endTime - startTime

## Meter Readings | Zählerstand | قراءة العداد

section_id: meter_readings
optional_section: true
repeatable: true
min: 0
max: 5

- meterNumber | text | | Meter Number | Zählernummer | رقم العداد
- reading | number | | Reading (kWh) | Zählerstand (kWh) | القراءة (كيلوواط ساعة)

---

- photoMeter | photo | | Photo - Meter | Foto - Zähler | صورة - العداد

## Work Photos | Bilder der erbrachten Arbeit | صور العمل المنجز

section_id: work_photos

repeatable: true
min: 1
max: 20

- category | dropdown | | Category | Kategorie | الفئة
  options: before, during, after, other
- photo | photo | | Photo | Foto | الصورة
- description | text | | Description | Beschreibung | الوصف

## Completion | Abschluss | الإكمال

section_id: completion

- workCompleted | radio | required | Work Completed? | Arbeit abgeschlossen? | العمل مكتمل؟
  options: yes, no
- reason | textarea | | Reason (why not completed) | Begründung (warum nicht abgeschlossen) | السبب (لماذا لم يكتمل)
  show_if: workCompleted == no
- nextAppointment | date | | Next Appointment | Folgetermin | الموعد التالي
  show_if: workCompleted == no
- whatIsMissing | textarea | | What is missing | Was fehlt noch | ما الذي لا يزال مفقودًا
  show_if: workCompleted == no
- completionDate | date | | Date of Completion | Datum der Fertigstellung | تاريخ الإكمال
  show_if: workCompleted == yes
- completionTime | time | | Time of Completion | Uhrzeit der Fertigstellung | وقت الإكمال
  show_if: workCompleted == yes

## Remarks | Sonstige Bemerkungen | ملاحظات أخرى

section_id: remarks
optional_section: true

- remarks | textarea | | Remarks | Bemerkungen | ملاحظات

## Additional info | additional | معلومات اضافية

section_id: additional_info
repeatable: true
min: 1
max: 10

- note | textarea | | Remarks | Bemerkungen | ملاحظة
- image | photo| | | image| image | صورة

---

## Signatures | Unterschriften | التوقيعات

section_id: signatures

- customerFullName | text | required | Customer Full Name | Kundenvollname | الاسم الكامل للعميل
- customerSignature | signature | required | Customer Signature | Unterschrift des Kunden/Bevollmächtigten | توقيع العميل
- signerName | text | required | Name of Signing Technician | Name unterzeichnender Monteur | اسم الفني الموقع
- companySignature | signature | required | MAM Solarbau Signature | Unterschrift MAM Solarbau | توقيع MAM Solarbau
<!-- - emailSentTo | email | calculated | Email sent to | E-Mail versendet an | البريد الإلكتروني المرسل إلى
  source: customer_data.email -->
