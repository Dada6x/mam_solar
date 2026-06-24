---
protocol: work_order
title: Work Order
title_de: Regie-/Arbeitsauftrag
title_ar: أمر العمل
version: 4.0
company: MAM Solarbau
note: Rebuilt 1:1 from the BSH Regie-/Arbeitsauftrag PDF, adapted for MAM Solarbau. MAM improvements (materials, vehicle, working hours) kept as optional Ja/Nein-gated blocks so installers only see them when needed.
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- customerName | text | required | First and last name (company, if any) | Vor- und Nachname (Firma, falls vorhanden) | الاسم الكامل (الشركة إن وجدت)
- street | text | required | Street | Straße | الشارع
- zipCity | text | required | ZIP, City | PLZ, Ort | الرمز البريدي، المدينة
- email | email | required | Customer email address | E-Mail-Adresse des Kunden | البريد الإلكتروني للعميل

## Work Performed (Description) | Ausgeführte Arbeiten (Beschreibung) | الأعمال المنفذة (الوصف)

section_id: work_description

- arbeitsbeschreibung | textarea | required | Work performed (work description) | Ausgeführte Arbeiten (Arbeitsbeschreibung) | الأعمال المنفذة (وصف العمل)

## Materials | Materialverbrauch | استهلاك المواد

section_id: materials
repeatable: true
min: 0
max: 30

- quantity | number | | Quantity | Menge | الكمية
- unit | dropdown | | Unit | Einheit | الوحدة
  options: Stück, Meter, kg, Liter, Satz
- material | text | | Material / Article | Material / Artikel | المادة / الصنف

## Vehicle / Travel | Fahrzeug / Anreise | المركبة / السفر

section_id: travel

- vehicleUsed | radio | required | Was a vehicle used? | Fahrzeug eingesetzt? | هل تم استخدام مركبة؟
  options: Ja, Nein
- licensePlate | text | | License plate | Kennzeichen | لوحة الترخيص
  show_if: vehicleUsed == Ja
- departure | text | | Departure (city / address) | Abfahrt (Ort/Adresse) | المغادرة (المدينة/العنوان)
  show_if: vehicleUsed == Ja
- destination | text | | Destination (city / address) | Zielort (Ort/Adresse) | الوجهة (المدينة/العنوان)
  show_if: vehicleUsed == Ja
- kilometers | number | | Kilometers driven | Gefahrene Kilometer | الكيلومترات المقطوعة
  show_if: vehicleUsed == Ja

## Working Hours | Arbeitszeit | ساعات العمل

section_id: working_hours

- hoursLogged | radio | required | Record working hours? | Arbeitszeit erfassen? | هل تسجيل ساعات العمل؟
  options: Ja, Nein
- date | date | | Date | Datum | التاريخ
  show_if: hoursLogged == Ja
- techName | text | | Technician name | Name des Monteurs | اسم الفني
  show_if: hoursLogged == Ja
- startTime | time | | Start time | Startzeit | وقت البدء
  show_if: hoursLogged == Ja
- endTime | time | | End time | Endzeit | وقت الانتهاء
  show_if: hoursLogged == Ja
- duration | text | | Duration | Arbeitsdauer | المدة
  show_if: hoursLogged == Ja

## Section | Abschnitt | القسم

section_id: completion

- arbeitAbgeschlossen | radio | required | Is the work completed? | Ist die Arbeit abgeschlossen? | هل اكتمل العمل؟
  options: Ja, Nein
- reason | textarea | required | Reason (why not completed) | Begründung (warum nicht abgeschlossen) | السبب (لماذا لم يكتمل)
  show_if: arbeitAbgeschlossen == Nein
- whatIsMissing | textarea | | What is still missing | Was fehlt noch | ما الذي لا يزال مفقودًا
  show_if: arbeitAbgeschlossen == Nein
- nextAppointment | date | | Next appointment | Folgetermin | الموعد التالي
  show_if: arbeitAbgeschlossen == Nein
- datumUhrzeit | datetime | required | Date and time | Datum und Uhrzeit | التاريخ والوقت

## Work Photos | Bilder der erbrachten Arbeit | صور العمل المنجز

section_id: work_photos

- fotos | multiphoto | | Photos | Fotos | الصور

## Remarks | Sonstige Bemerkungen | ملاحظات أخرى

section_id: remarks

- remarks | textarea | | Remarks | Bemerkungen | ملاحظات

---

## Signatures | Unterschriften | التوقيعات

section_id: signatures

- customerFullName | text | required | First and last name (customer) | Vor- und Nachname (Kunde) | الاسم الكامل (العميل)
- customerSignature | signature | required | Customer / representative signature | Unterschrift des Kunden/Bevollmächtigten | توقيع العميل/الممثل
- signerName | text | required | Name of signing installer | Name unterzeichnender Monteur | اسم الفني الموقّع
- companySignature | signature | required | MAM Solarbau signature | Unterschrift - MAM Solarbau | توقيع MAM Solarbau
- versendeteEmail | email | | Sent email | Versendete E-Mail | البريد الإلكتروني المُرسل
