---
protocol: work_order
title: Work Order
title_de: Arbeitsauftrag
title_ar: أمر العمل
version: 1.1
---

## Customer Data
section_id: customer_data

- fullName | text | required | Full Name | Vollständiger Name | الاسم الكامل
- street   | text |          | Street | Straße | الشارع
- zipCity  | text |          | ZIP / City | PLZ / Ort | الرمز البريدي / المدينة
- email    | email |         | Email | E-Mail | البريد الإلكتروني
<!-- - gender    | gender |         | Gender | GENDER | الجنس  -->

## Work Description
section_id: work_description

- description | textarea | required | Description | Beschreibung | الوصف
- workDetail  | textarea |          | Work Detail | Arbeitsdetail | تفاصيل العمل

## Materials
section_id: materials
repeatable: true
min: 0
max: 20

- quantity | text |          | Quantity | Menge | الكمية
- material | text |          | Material | Material | المادة

## Travel
section_id: travel
repeatable: true
min: 0
max: 10

- departure   | text |          | Departure | Abfahrt | المغادرة
- destination | text |          | Destination | Zielort | الوجهة

## Working Hours
section_id: working_hours
repeatable: true
min: 1
max: 14

- date      | date | required | Date | Datum | التاريخ
- techName  | text | required | Technician Name | Technikername | اسم الفني
- startTime | time | required | Start Time | Startzeit | وقت البدء
- endTime   | time | required | End Time | Endzeit | وقت الانتهاء

## Completion
section_id: completion

- workCompleted  | checkbox | required | Work Completed | Arbeit abgeschlossen | العمل مكتمل
- completionDate | date     |          | Completion Date | Abschlussdatum | تاريخ الإكمال
- photoWork1     | photo    |          | Photo - Work 1 | Foto - Arbeit 1 | صورة - العمل 1
- photoWork2     | photo    |          | Photo - Work 2 | Foto - Arbeit 2 | صورة - العمل 2

## Remarks
section_id: remarks

- remarks | textarea |          | Remarks | Bemerkungen | ملاحظات

## Signatures
section_id: signatures

- customerSignature   | signature | required | Customer Signature | Kundenunterschrift | توقيع العميل
- technicianSignature | signature | required | Technician Signature | Technikerunterschrift | توقيع الفني
