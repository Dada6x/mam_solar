---
protocol: installation_report
title: Installation Report
title_de: Installationsbericht
title_ar: تقرير التركيب
version: 1.1
---

## Customer Data
section_id: customer_data

- customerName     | text      | required | Customer Name | Kundenname | اسم العميل
- street           | text      |          | Street | Straße | الشارع
- city             | text      |          | City | Stadt | المدينة
- zipCode          | text      |          | ZIP Code | PLZ | الرمز البريدي
- email            | email     |          | Email | E-Mail | البريد الإلكتروني
- phone            | text      |          | Phone | Telefon | الهاتف
- installationDate | date      | required | Installation Date | Installationsdatum | تاريخ التركيب
- installerName    | text      | required | Installer Name | Installateur | اسم المثبت
- partnerCompany   | text      |          | Partner Company | Partnerfirma | الشركة الشريكة

## Installation Details
section_id: installation_details

- installationType      | dropdown | required | Installation Type | Installationstyp | نوع التركيب
  options: solar_pv, solar_pv_battery, solar_pv_wallbox
- storageManufacturer   | text     |          | Storage Manufacturer | Speicherhersteller | الشركة المصنعة للتخزين
- wallboxInstalled      | checkbox |          | Wallbox Installed | Wallbox installiert | شاحن الحائط مثبت
- backupInstalled       | checkbox |          | Backup Installed | Backup installiert | النسخ الاحتياطي مثبت
- groundRodInstalled    | checkbox |          | Ground Rod Installed | Erdungsstab installiert | قضيب التأريض مثبت
- privateMeterInstalled | checkbox |          | Private Meter Installed | Privater Zähler installiert | العداد الخاص مثبت

## Meter Cabinet
section_id: meter_cabinet

- newCabinetInstalled      | checkbox |          | New Cabinet Installed | Neuer Schrank installiert | الخزانة الجديدة مثبتة
- allComponentsInstalled   | checkbox |          | All Components Installed | Alle Komponenten installiert | جميع المكونات مثبتة
- touchProtection          | checkbox |          | Touch Protection | Berührungsschutz | حماية اللمس
- apzInstalled             | checkbox |          | APZ Installed | APZ installiert | APZ مثبت
- energridInstalled        | checkbox |          | Energrid Installed | Energrid installiert | Energrid مثبت
- photoNewCabinet          | photo    |          | Photo - New Cabinet | Foto - Neuer Schrank | صورة - الخزانة الجديدة
- photoOldCabinet          | photo    |          | Photo - Old Cabinet | Foto - Alter Schrank | صورة - الخزانة القديمة

## Meter Information
section_id: meter_information

- meterType               | dropdown |          | Meter Type | Zählertyp | نوع العداد
  options: single_direction, bidirectional, three_point
- meterReplacementNeeded  | checkbox |          | Meter Replacement Needed | Zählerwechsel nötig | استبدال العداد مطلوب
- measurementConcept      | dropdown |          | Measurement Concept | Messkonzept | مفهوم القياس
  options: excess_feed_in, full_feed_in, self_consumption
- photoMeter              | photo    |          | Photo - Meter | Foto - Zähler | صورة - العداد

## Remarks
section_id: remarks

- remarks | textarea |          | Remarks | Bemerkungen | ملاحظات

## Signatures
section_id: signatures

- customerSignature  | signature | required | Customer Signature | Kundenunterschrift | توقيع العميل
- installerSignature | signature | required | Installer Signature | Installateurunterschrift | توقيع المثبت
