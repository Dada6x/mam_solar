---
protocol: ac_acceptance
title: AC Acceptance Protocol
title_de: AC-Abnahmeprotokoll
title_ar: بروتوكول قبول التيار المتردد
version: 2.1
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

- installationType    | dropdown | required | Installation Type | Installationstyp | نوع التركيب
  options: solar_pv, solar_pv_battery, solar_pv_wallbox
- storageManufacturer | text     |          | Storage Manufacturer | Speicherhersteller | الشركة المصنعة للتخزين
---
- wallboxInstalled      | checkbox |          | Wallbox Installed | Wallbox installiert | شاحن الحائط مثبت
- backupInstalled       | checkbox |          | Backup Installed | Backup installiert | النسخ الاحتياطي مثبت
- inspectionCompleted   | checkbox |          | Inspection Completed | Besichtigung durchgeführt | اكتمل التفتيش
- inspectionReason      | textarea |          | Reason if not inspected | Grund wenn nicht besichtigt | سبب عدم التفتيش
  show_if: inspectionCompleted == false
- groundRodInstalled    | checkbox |          | Ground Rod Installed | Erdungsstab installiert | قضيب التأريض مثبت
- privateMeterInstalled | checkbox |          | Private Meter Installed | Privater Zähler installiert | العداد الخاص مثبت
- supervisorIntroduced  | checkbox |          | Supervisor Introduced | Aufsicht eingewiesen | تم تعريف المشرف
- shoeCoversWorn        | checkbox |          | Shoe Covers Worn | Schuhüberzieher getragen | أغطية الأحذية مرتدية

## Inverter
section_id: inverter
repeatable: true
min: 1
max: 5

- brand        | text     | required | Brand | Marke | الماركة
- model        | text     |          | Model | Modell | الطراز
- serialNumber | text     | required | Serial Number | Seriennummer | الرقم التسلسلي
- networkType  | dropdown | required | Network Type | Netzwerktyp | نوع الشبكة
  options: wlan, powerline, ethernet
---
- installedCorrectly        | checkbox |          | Installed Correctly | Richtig installiert | مثبت بشكل صحيح
- mountedOnFireproofSurface | checkbox |          | Mounted on Fireproof Surface | Feuerfester Untergrund | مثبت على سطح مقاوم للحريق
---
- photoDataplate    | photo |          | Photo - Dataplate | Foto - Typenschild | صورة - لوحة البيانات
- photoAcGrid       | photo |          | Photo - AC Grid Connection | Foto - AC Netzanschluss | صورة - اتصال شبكة AC
- photoAcBackup     | photo |          | Photo - AC Backup Connection | Foto - AC Backup | صورة - اتصال AC احتياطي
- photoCommunication | photo |         | Photo - Communication | Foto - Kommunikation | صورة - الاتصالات
- photoFinalInstall | photo |          | Photo - Final Installation | Foto - Endinstallation | صورة - التركيب النهائي

## Battery Storage
section_id: battery_storage

- batteryBrand           | text     |          | Battery Brand | Batteriemarke | العلامة التجارية للبطارية
- batteryModel           | text     |          | Battery Model | Batteriemodell | طراز البطارية
- batteryTowers          | number   |          | Battery Towers | Batterietürme | أبراج البطارية
- batteryModulesPerTower | number   |          | Modules per Tower | Module pro Turm | الوحدات لكل برج
- serialNumbers          | textarea |          | Serial Numbers | Seriennummern | الأرقام التسلسلية
- standardsFollowed      | checkbox |          | Safety Standards Followed | Sicherheitsstandards eingehalten | معايير السلامة متبعة
---
- photoBattery | photo |          | Photo - Battery | Foto - Batterie | صورة - البطارية

## Meter Cabinet
section_id: meter_cabinet

- newCabinetInstalled    | checkbox |          | New Cabinet Installed | Neuer Schrank installiert | الخزانة الجديدة مثبتة
- allComponentsInstalled | checkbox |          | All Components Installed | Alle Komponenten installiert | جميع المكونات مثبتة
- touchProtection        | checkbox |          | Touch Protection | Berührungsschutz | حماية اللمس
- apzConnected           | checkbox |          | APZ Connected | APZ angeschlossen | APZ متصل
- apzInstalled           | checkbox |          | APZ Installed | APZ installiert | APZ مثبت
- energridInstalled      | checkbox |          | Energrid Installed | Energrid installiert | Energrid مثبت
---
- photoNewCabinet    | photo |          | Photo - New Cabinet | Foto - Neuer Schrank | صورة - الخزانة الجديدة
- photoOldCabinet    | photo |          | Photo - Old Cabinet | Foto - Alter Schrank | صورة - الخزانة القديمة
- photoSlsOrNh       | photo |          | Photo - SLS/NH | Foto - SLS/NH | صورة - SLS/NH
- photoAcOvervoltage | photo |          | Photo - AC Overvoltage | Foto - AC Überspannung | صورة - الجهد الزائد AC
- photoRcd           | photo |          | Photo - RCD | Foto - RCD | صورة - RCD

## Meter Information
section_id: meter_information

- meterType              | dropdown |          | Meter Type | Zählertyp | نوع العداد
  options: single_direction, bidirectional, three_point
- meterRemovalNeeded     | checkbox |          | Meter Removal Needed | Zählerentfernung nötig | إزالة العداد مطلوبة
- meterReplacementNeeded | checkbox |          | Meter Replacement Needed | Zählerwechsel nötig | استبدال العداد مطلوب
- newMeterType           | dropdown |          | New Meter Type | Neuer Zählertyp | نوع العداد الجديد
  options: single_direction, bidirectional, three_point
- remoteControl          | checkbox |          | Remote Control Capable | Fernsteuerbar | تحكم عن بعد
- meterConsolidation     | checkbox |          | Meter Consolidation | Zählerzusammenlegung | دمج العدادات
- measurementConcept     | dropdown |          | Measurement Concept | Messkonzept | مفهوم القياس
  options: excess_feed_in, full_feed_in, self_consumption
---
- photoMeter         | photo |          | Photo - Meter | Foto - Zähler | صورة - العداد
- photoMeterReadings | photo |          | Photo - Meter Readings | Foto - Zählerstände | صورة - قراءات العداد

## Cable Routes
section_id: cable_routes

- routeOver25m | checkbox |          | Cable Route Over 25m | Kabelweg über 25m | مسار الكابل أكثر من 25م
- notes        | textarea |          | Notes | Notizen | ملاحظات
---
- photoCable1 | photo |          | Photo - Cable 1 | Foto - Kabel 1 | صورة - الكابل 1
- photoCable2 | photo |          | Photo - Cable 2 | Foto - Kabel 2 | صورة - الكابل 2
- photoCable3 | photo |          | Photo - Cable 3 | Foto - Kabel 3 | صورة - الكابل 3

## Final Acceptance
section_id: final_acceptance

- systemOperational | checkbox | required | System Operational | Anlage betriebsbereit | النظام جاهز للتشغيل
- cleanupDone       | checkbox |          | Cleanup Completed | Reinigung abgeschlossen | اكتمل التنظيف
- customerInformed  | checkbox | required | Customer Informed | Kunde informiert | تم إعلام العميل
- invoiceApproved   | checkbox | required | Invoice Approved | Rechnung freigegeben | الفاتورة معتمدة

+ ## Remarks
section_id: remarks

- remarks | textarea |          | Remarks | Bemerkungen | ملاحظات

## Signatures
section_id: signatures

- customerSignature  | signature | required | Customer Signature | Kundenunterschrift | توقيع العميل
- installerSignature | signature | required | Installer Signature | Installateurunterschrift | توقيع المثبت