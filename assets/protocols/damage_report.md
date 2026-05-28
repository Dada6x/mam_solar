---
protocol: damage_report
title: Damage Report
title_de: Schadensprotokoll
title_ar: تقرير الضرر
version: 2.0
company: MAM Solarbau
---

## Damage Declaration | Schadenserklärung | إعلان الضرر

section_id: damage_declaration

- damageType | dropdown | required | What type of damage occurred? | Was für ein Schaden ist entstanden? | ما نوع الضرر الذي حدث؟
  options: at_customer, at_third_party, material_damage_own, personal_injury, vehicle_accident, other
- damageTypeOther | text | | Other (please specify) | Sonstiges (bitte angeben) | أخرى (يرجى التحديد)
  show_if: damageType == other
- causedByPartner | radio | required | Was the damage caused by a partner company? | Wurde der Schaden durch Partner verursacht? | هل سببه شركة شريكة؟
  options: yes, no
- partnerCompanyName | text | | Name of partner company | Name des Partnerunternehmens | اسم الشركة الشريكة
  show_if: causedByPartner == yes
- companyLiability | radio | required | Will damage be regulated through own business liability insurance? | Wird der Schaden über die eigene Betriebshaftpflichtversicherung reguliert? | هل سيتم تنظيم الضرر عبر التأمين الخاص؟
  options: yes, no
- insurancePolicyNumber | text | | Insurance policy number | Versicherungsnummer | رقم بوليصة التأمين
  show_if: companyLiability == yes
- claimNumber | text | | Claim number (if already assigned) | Schadensnummer (falls bereits vergeben) | رقم المطالبة (إذا تم تعيينه)
  show_if: companyLiability == yes

## Injured Party | Daten des Geschädigten | بيانات الطرف المتضرر

section_id: injured_party

- injuredName | text | required | Injured Party Name | Vor- und Nachname | اسم الطرف المتضرر
- street | text | required | Street | Straße | الشارع
- houseNumber | text | required | House Number | Nr. | رقم المنزل
- zipCode | text | required | ZIP Code | PLZ | الرمز البريدي
- city | text | required | City | Ort | المدينة
- phone | text | required | Phone | Telefon | الهاتف
- email | email | required | Email | E-Mail | البريد الإلكتروني

## Second Injured Party | 2. Geschädigte Person | الشخص المتضرر الثاني

section_id: second_party

optional_section: true

- secondPersonInvolved | radio | | Was there a second injured person? | Gab es eine 2. Geschädigte Person? | هل كان هناك شخص متضرر ثانٍ؟
  options: yes, no
- secondName | text | | Second Party Name | Name | الاسم
  show_if: secondPersonInvolved == yes
- secondStreet | text | | Street | Straße | الشارع
  show_if: secondPersonInvolved == yes
- secondZipCity | text | | ZIP / City | PLZ / Ort | الرمز البريدي / المدينة
  show_if: secondPersonInvolved == yes
- secondPhone | text | | Phone | Telefon | الهاتف
  show_if: secondPersonInvolved == yes
- secondEmail | email | | Email | E-Mail | البريد الإلكتروني
  show_if: secondPersonInvolved == yes

## Incident Details | Vorfallsdetails | تفاصيل الحادث

section_id: incident_details

- incidentDate | date | required | Date of Incident | Datum des Unfalls | تاريخ الحادث
- incidentTime | time | required | Time of Incident | Uhrzeit des Unfalls | وقت الحادث

---

- initialSituation | textarea | | Initial Situation (what was the situation before?) | Ausgangssituation (Was war die Situation vorher?) | الوضع الأولي (ماذا كان الوضع قبل ذلك؟)
  placeholder_de: z.B. Vorschäden bekannt, Zustand vor Arbeitsbeginn
- incidentSequence | textarea | | Incident Sequence (step by step what happened) | Ablauf des Vorfalls (Schritt für Schritt was passiert ist) | تسلسل الحادث (ما الذي حدث خطوة بخطوة)
- affectedSummary | textarea | | Summary of affected items/people | Zusammenfassung der betroffenen Geräte/Personen | ملخص العناصر/الأشخاص المتضررين

## Witnesses | Zeugen | الشهود

section_id: witnesses
optional_section: true
repeatable: true
min: 0
max: 5

- witnessName | text | | Witness Name | Name des Zeugen | اسم الشاهد
- witnessPhone | text | | Phone | Telefon | الهاتف
- witnessEmail | email | | Email | E-Mail | البريد الإلكتروني
- witnessStatement | textarea | | Witness Statement | Aussage des Zeugen | إفادة الشاهد

## Affected Devices/Items | Sichtbare Schäden | الأضرار المرئية

section_id: affected_devices
repeatable: true
min: 1
max: 20

- itemName | text | | Item/Device Name | Name des Gegenstandes/Geräts | اسم الجهاز/العنصر
- brand | text | | Brand | Marke | الماركة
- model | text | | Model | Modell | الطراز
- serialNumber | text | | Serial Number | Seriennummer | الرقم التسلسلي
- purchaseDate | date | | Purchase Date (if known) | Kaufdatum (falls bekannt) | تاريخ الشراء
- estimatedValue | number | | Estimated Value in EUR | Geschätzter Wert in EUR | القيمة المقدرة باليورو
- damageDescription | textarea | | Damage Description | Beschreibung des Schadens | وصف الضرر
- photoOverview | photo | | Overview photo of damage | Übersichtsfoto Schaden | صورة عامة للضرر
- photoDetail | photo | | Detail photo of damage | Detailfoto Schaden | صورة تفصيلية للضرر
- photoTypeLabel | photo | | Photo of type label / serial number | Foto Typenschild / Seriennummer | صورة لوحة النوع / الرقم التسلسلي

## Damage Minimization | Schadensminimierung | تقليل الضرر

section_id: damage_minimization

- minimizationPossible | radio | required | On-site damage minimization possible? | Schadensminimierung vor Ort möglich? | تقليل الضرر في الموقع ممكن؟
  options: yes, no
- minimizationActionsTaken | textarea | | What actions were taken? | Welche Maßnahmen wurden ergriffen? | ما الإجراءات التي تم اتخاذها؟
  show_if: minimizationPossible == yes
- minimizationNotPossibleReason | textarea | | Why not possible? | Warum nicht möglich? | لماذا غير ممكن؟
  show_if: minimizationPossible == no

## Remarks | Bemerkungen | ملاحظات

section_id: remarks

- remarks | textarea | | Remarks (initial situation, sequence, affected devices) | Bemerkungen (Ausgangssituation, Ablauf, betroffene Geräte) | ملاحظات

## Additional Info | Zusätzliche Informationen | معلومات إضافية

section_id: additional_info
optional_section: true
repeatable: true
min: 0
max: 10

- note | textarea | | Note | Bemerkung | ملاحظة
- image | photo | | Image | Bild | صورة

## Employee Info | Mitarbeiterinfo | معلومات الموظف

section_id: employee_info

## Signatures | Unterschriften | التوقيعات

section_id: signatures

- damagedPartyFullName | text | required | Damaged Party Full Name | Vollständiger Name des Geschädigten | الاسم الكامل للطرف المتضرر
- damagedPartySignature | signature | required | Damaged Party Signature | Unterschrift des Geschädigten | توقيع الطرف المتضرر
- employeeFullName | text | required | Employee Full Name | Vollständiger Name des Mitarbeiters | الاسم الكامل للموظف
- employeeSignature | signature | required | MAM Solarbau Employee Signature | Unterschrift MAM Solarbau Mitarbeiter | توقيع موظف MAM Solarbau
- protocolDateTime | datetime | calculated | Protocol creation date/time | Protokollerstellung Datum/Uhrzeit | تاريخ/وقت إنشاء البروتوكول
  default: current_time