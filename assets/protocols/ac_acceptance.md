---
protocol: ac_acceptance
title: AC Acceptance Protocol
title_de: AC-Abnahmeprotokoll
title_ar: بروتوكول قبول التيار المتردد
version: 5.0
company: MAM Solarbau
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- customerName | text | required | Customer Name | Kundenname | اسم العميل
- street | text | required | Street | Straße | الشارع
- houseNumber | text | | House Number | Hausnummer | رقم المنزل
- zipCode | text | required | ZIP Code | PLZ | الرمز البريدي
- city | text | required | City | Stadt | المدينة

---

## Installation Details | Installationsdetails | تفاصيل التركيب

section_id: installation_details

- installationType | radio | | Installation Type | Installationstyp | نوع التركيب
  options: pv_with_storage, pv_without_storage, pv_storage_expansion

- storageManufacturer | text | | Storage Manufacturer | Speicherhersteller | الشركة المصنعة للتخزين

- wallboxAvailable | checkbox | | Wallbox Available? | Wallbox vorhanden? | هل الشاحن الجداري متوفر؟
- backupAvailable | checkbox | | Backup Available? | Backup vorhanden? | هل النسخ الاحتياطي متوفر؟
- testPerformed | checkbox | | Test Performed? | Prüfung durchgeführt? | هل تم إجراء الاختبار؟

- installationDate | date | required | Installation Date | Montagetermin | تاريخ التركيب
- installerName | text | required | Installer Name | Name des Bearbeiters | اسم المثبت

---

## Storage | Speicher | التخزين

section_id: storage_details

- storageModel | text | | Storage Model | Speichermodell | طراز التخزين
- storageCount | number | | Number of Storage Units | Anzahl Speicher | عدد وحدات التخزين

- storageDetails | repeatable | | Storage Details | Speicherdetails | تفاصيل التخزين
  repeatable: true
  min: 1
  max: 10
  - serialNumberStorage | text | | Serial Number | Seriennummer Speicher | الرقم التسلسلي للتخزين
  - photoQrCode | photo | | Photo QR Code | Foto QR-Code | صورة رمز QR
  - photoConnections | photo | | Photo Connections | Foto Anschlüsse | صورة التوصيلات

---

## Inverter | Wechselrichter | الانفرتر

section_id: inverter_details

- inverterCount | number | | Number of Inverters | Anzahl Wechselrichter | عدد الانفرترات

- inverterDetails | repeatable | | Inverter Details | Wechselrichterdetails | تفاصيل الانفرتر
  repeatable: true
  min: 1
  max:
  - serialNumberInverter | text | | Inverter Serial Number | Seriennummer Wechselrichter | الرقم التسلسلي للانفرتر
  - photoDataplate | photo | | Photo of Nameplate | Foto Typenschild | صورة لوحة البيانات

---

## Meter Cabinet | Zählerschrank | خزانة العداد

section_id: meter_cabinet

- photoCabinet | multiphoto | | Photos of Meter Cabinet | Fotos Zählerschrank | صور خزانة العداد

- cabinetClean | checkbox | | Is the Meter Cabinet Clean? | Ist der Zählerschrank sauber? | هل خزانة العداد نظيفة؟
- cabinetLabeled | checkbox | | Is the Meter Cabinet Labeled? | Ist der Zählerschrank beschriftet? | هل خزانة العداد مُعلَّمة؟
- vdeTested | checkbox | | VDE Tested? | VDE geprüft? | هل تم اختبار VDE؟
- plumbed | checkbox | | Plumbed? | Abgedichtet? | هل تم السباكة؟

---

## Meter IBN | Zähler IBN | عداد IBN

section_id: meter_ibn

- counterType | radio | | Counter Type | Zählertyp | نوع العداد
  options: single_rate, two_rate, smart_meter, miscellaneous

- photoMeter | photo | | Photo of Meter | Foto Zähler | صورة العداد

- meterReplaced | checkbox | | Meter Replaced? | Zähler ausgetauscht? | هل تم استبدال العداد؟

---

## Cable Routes | Kabelwege | مسارات الكابل

section_id: cable_routes
repeatable: true
min: 1
max: 20

- photoCableRoute | photo | | Photo Cable Route | Foto Kabelweg | صورة مسار الكابل
- cableLength | number | | Cable Length (m) | Kabellänge (m) | طول الكابل (م)

---

## Diploma | Abschluss | الدبلوم

section_id: diploma

- remarks | textarea | | Remarks | Bemerkungen | ملاحظات
- completionDate | datetime | required | Completion Date & Time | Abschlussdatum und -uhrzeit | تاريخ ووقت الانتهاء

---

## Additional Info | Zusätzliche Informationen | معلومات إضافية

section_id: additional_info
optional_section: true
repeatable: true
min: 0
max: 10

- note | textarea | | Note | Bemerkung | ملاحظة
- image | photo | | Image | Bild | صورة

## Signatures | Unterschriften | التوقيعات

section_id: signatures

- location | text | required | Location | Ort | الموقع
<!-- Todo make it full name instead of name  -->
- sigCustomerFullName | text | required | Customer Full Name | Vollständiger Kundenname | الاسم الكامل للعميل
- customerEmail | email | | Customer Email | Kunden-E-Mail | البريد الإلكتروني للعميل
- customerSignature | signature | required | Customer Signature | Unterschrift Kunde | توقيع العميل
- electricianSignature | signature | required | Electrician Signature | Unterschrift Elektriker | توقيع الكهربائي
