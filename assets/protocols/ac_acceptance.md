---
protocol: ac_acceptance
title: AC Acceptance Protocol
title_de: AC-Abnahmeprotokoll
title_ar: بروتوكول قبول التيار المتردد
version: 2.2
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- customerName | text | required | Customer Name | Kundenname | اسم العميل
- street | text | | Street | Straße | الشارع
- city | text | | City | Stadt | المدينة
- zipCode | text | | ZIP Code | PLZ | الرمز البريدي
- email | email | | Email | E-Mail | البريد الإلكتروني
- phone | text | | Phone | Telefon | الهاتف
- installationDate | date | required | Installation Date | Installationsdatum | تاريخ التركيب
- installerName | text | required | Installer Name | Installateur | اسم المثبت
- partnerCompany | text | | Partner Company | Partnerfirma | الشركة الشريكة

## Installation Details | Installationsdetails | تفاصيل التركيب

section_id: installation_details

- installationType | dropdown | required | Installation Type | Installationstyp | نوع التركيب
  options: solar_pv, solar_pv_battery, solar_pv_wallbox
- storageManufacturer | text | | Storage Manufacturer | Speicherhersteller | الشركة المصنعة للتخزين

---

- wallboxInstalled | checkbox | | Wallbox Installed | Wallbox installiert | تم تركيب Wallbox
- backupInstalled | checkbox | | Backup Installed | Backup installiert | نظام الاحتياطي مثبت
- inspectionCompleted | checkbox | | Inspection Completed | Besichtigung durchgeführt | تم اجراء فحص
- inspectionReason | textarea | | Reason if not inspected | Grund wenn nicht besichtigt | سبب عدم التفتيش
  show_if: inspectionCompleted == false
- groundRodInstalled | checkbox | | Ground Rod Installed | Erdungsstab installiert | قضيب التأريض مثبت
- privateMeterInstalled | checkbox | | Private Meter Installed | Privater Zähler installiert | العداد الخاص مثبت
- supervisorIntroduced | checkbox | | Supervisor Introduced | Aufsicht eingewiesen | تم تعريف المشرف
- shoeCoversWorn | checkbox | | Shoe Covers Worn | Schuhüberzieher getragen | أغطية الأحذية مرتدية

## Inverter | Wechselrichter | العاكس

section_id: inverter
repeatable: true
min: 0
max: 5

- inverterCount | number | required | Number of Inverters Installed | Anzahl installierter Wechselrichter | عدد العاكسات المركبة
- brand | text | | Brand | Marke | الماركة
- model | text | | Model | Modell | الطراز
- serialNumber | text | | Serial Number | Seriennummer | الرقم التسلسلي
- networkType | dropdown | | Network Type | Netzwerktyp | نوع الشبكة
  options: wlan, powerline, ethernet

---

- installedCorrectly | checkbox | | Installed Correctly | Richtig installiert | مثبت بشكل صحيح
- mountedOnFireproofSurface | checkbox | | Mounted on Fireproof Surface | Feuerfester Untergrund | مثبت على سطح مقاوم للحريق
- manufacturerStandardsFollowed | checkbox | | Manufacturer Standards Followed | Herstellerstandards eingehalten | معايير الشركة المصنعة متبعة

---

- photoDataplate | photo | | Photo - Dataplate | Foto - Typenschild | صورة - لوحة البيانات
- photoAcGrid | photo | | Photo - AC Grid Connection | Foto - AC Netzanschluss | صورة - قابس AC شبكة مفتوح ومتصل
- photoAcBackup | photo | | Photo - AC Backup Connection | Foto - AC Backup | صورة - قابس AC احتياطي مفتوح ومتصل
- photoCommunicationPlug | photo | | Photo - Communication Plug | Foto - Kommunikationsstecker | صورة - قابس الاتصال مفتوح ومتصل
- photoThreeCommunicationPorts | photo | | Photo - Three Communication Ports | Foto - Drei Kommunikationsports | صورة - منافذ الاتصال الثلاثة
- photoEarthingLeft | photo | | Photo - Earthing Left Side | Foto - Erdung linke Seite | صورة - توصيل التأريض الجهة اليسرى
- photoEarthingRight | photo | | Photo - Earthing Right Side | Foto - Erdung rechte Seite | صورة - توصيل التأريض الجهة اليمنى
- photoPlcOrWlanExtender | photo | | Photo - PLC or WLAN Extender | Foto - PLC oder WLAN-Verstärker | صورة - مقوي WLAN أو محول Powerline
- photoDcBatteryCables | photo | | Photo - DC Battery Cables | Foto - DC-Batteriekabel | صورة - كابلات بطارية DC
- photoFinalInstall | photo | | Photo - Final Installation | Foto - Endinstallation | صورة - التركيب النهائي

## Battery Storage | Batteriespeicher | وحدة التخزين

section_id: battery_storage

- batteryBrand | text | | Battery Brand | Batteriemarke | العلامة التجارية للبطارية
- batteryModel | text | | Battery Model | Batteriemodell | طراز البطارية
- batteryCount | number | | Number of Storage Units Installed | Anzahl installierter Speichereinheiten | عدد وحدات التخزين المركبة
- batterySid | text | | SID | SID | رقم SID
- batteryTowers | number | | Battery Towers | Batterietürme | أبراج البطارية
- batteryModulesPerTower | number | | Modules per Tower | Module pro Turm | الوحدات لكل برج
- serialNumbers | textarea | | Serial Numbers | Seriennummern | الأرقام التسلسلية
- standardsFollowed | checkbox | | Manufacturer Safety Standards Followed | Sicherheitsstandards des Herstellers eingehalten | معايير السلامة متبعة وفق تعليمات الشركة المصنعة

---

- photoQrCode | photo | | Photo - QR Code | Foto - QR-Code | صورة - رمز QR
- photoBatteryConnections | photo | | Photo - Connections | Foto - Anschlüsse | صورة - التوصيلات
- photoEmsNumber | photo | | Photo - EMS Number | Foto - EMS-Nummer | صورة - رقم EMS
- photoAcPlugOpen | photo | | Photo - AC Plug Open | Foto - AC-Stecker offen | صورة - قابس AC مفتوح
- photoBatteryWithoutCovers | photo | | Photo - Unit Without Covers | Foto - Einheit ohne Abdeckungen | صورة - وحدة التخزين بدون أغطية
- photoBatteryWithCovers | photo | | Photo - Unit With All Covers | Foto - Einheit mit allen Abdeckungen | صورة - وحدة التخزين مع جميع الأغطية
- photoBatteryFromDistance | photo | | Photo - Unit From Distance | Foto - Einheit aus der Ferne | صورة - وحدة التخزين من مسافة بعيدة
- photoBatteryBase | photo | | Photo - Battery Base Leveled | Foto - Batteriesockel nivelliert | صورة - قاعدة برج البطارية بعد ضبطها بميزان الاستواء
- photoBatteryEarthing | photo | | Photo - Battery Tower Earthing | Foto - Batterieturm Erdung | صورة - توصيل التأريض لبرج البطارية
- photoBatteryTowerFinal | photo | | Photo - Battery Tower Final | Foto - Batterieturm Endmontage | صورة - برج البطارية بعد التركيب النهائي

## Potential Equalization Bar | Potenzialausgleichsschiene | قضيب موازنة الجهد

section_id: equalization_bar

- eqEarthingConnected | checkbox | | Earthing Connected and Labeled | Erdung angeschlossen und beschriftet | التأريض متصل وموسوم
- eqUkConnected | checkbox | | UK Connected and Labeled | UK angeschlossen und beschriftet | UK متصل وموسوم
- eqDcOvervoltageConnected | checkbox | | DC Overvoltage Protection Connected and Labeled | DC-Überspannungsschutz angeschlossen und beschriftet | حماية زيادة الجهد DC متصلة وموسومة
- eqInverterConnected | checkbox | | Inverter WR Connected and Labeled | Wechselrichter angeschlossen und beschriftet | العاكس WR متصل وموسوم

## Distribution Board | Verteilerkasten | لوحة التوزيع

section_id: distribution_board

- photoDistBoard1 | photo | | Photo - Distribution Board 1 | Foto - Verteilerkasten 1 | صورة - لوحة التوزيع 1
- photoDistBoard2 | photo | | Photo - Distribution Board 2 | Foto - Verteilerkasten 2 | صورة - لوحة التوزيع 2
- photoDistBoard3 | photo | | Photo - Distribution Board 3 | Foto - Verteilerkasten 3 | صورة - لوحة التوزيع 3

## Meter Cabinet | Zählerschrank | خزانة العداد

section_id: meter_cabinet

- newCabinetInstalled | checkbox | | New Cabinet Installed | Neuer Schrank installiert | الخزانة الجديدة مثبتة
- allComponentsInstalled | checkbox | | All Components Installed | Alle Komponenten installiert | جميع المكونات مثبتة
- touchProtection | checkbox | | Touch Protection VDE | Berührungsschutz VDE | الحماية ضد اللمس وفق معايير VDE
- apzWiringConnected | checkbox | | APZ Wiring Connected | APZ-Verkabelung angeschlossen | تمديد أسلاك APZ متصل
- apzInstalled | checkbox | | APZ Installed | APZ installiert | APZ مثبت
- energridInstalled | checkbox | | Energrid or Equivalent Installed | Energrid oder Äquivalent installiert | Energrid أو ما يعادله مثبت
- noModificationsToExistingSystem | checkbox | | No Modifications to Existing Electrical System | Keine Änderungen am Bestandssystem | لم يتم إجراء تعديلات على النظام الكهربائي الحالي
- gridStabilityEnsured | checkbox | | Grid Stability and Safety Ensured | Netzstabilität und Sicherheit sichergestellt | تم ضمان استقرار وأمان التغذية الكهربائية

---

- photoPvLabel | photo | | Photo - PV Label and Inspection Sticker | Foto - PV-Aufkleber und Prüfaufkleber | صورة - ملصق PV وملصق الفحص
- photoNewCabinet | photo | | Photo - New Cabinet With Covers and Labels | Foto - Neuer Schrank mit Abdeckungen | صورة - خزانة العدادات الجديدة مع الأغطية والملصقات
- photoOldCabinet | photo | | Photo - Old Cabinet | Foto - Alter Schrank | صورة - خزانة العدادات الحالية
- photoSlsOrNh | photo | | Photo - SLS Switch or NH Fuse | Foto - SLS-Schalter oder NH-Sicherung | صورة - مفتاح SLS أو فيوز NH الرئيسي
- photoAcOvervoltage | photo | | Photo - AC Overvoltage Protection | Foto - AC-Überspannungsschutz | صورة - حماية زيادة الجهد AC
- photoRcd | photo | | Photo - RCD Breaker | Foto - RCD-Schutzschalter | صورة - قاطع RCD
- photoCableRouteToNewCabinet | photo | | Photo - Cable Route to New Cabinet | Foto - Kabelweg zum neuen Schrank | صورة - مسار الكابل إلى خزانة العدادات الجديدة
- photoApzCableInside | photo | | Photo - Cable Inside APZ | Foto - Kabel innerhalb APZ | صورة - الكابل داخل APZ
- photoApzMeterConnections | photo | | Photo - APZ Connections at Meter | Foto - APZ-Anschlüsse am Zähler | صورة - توصيلات APZ عند العداد

## New Protection Devices | Neue Schutzgeräte | أجهزة الحماية الجديدة

section_id: protection_devices

- photoProtectionDevice1 | photo | | Photo - Protection Device 1 | Foto - Schutzgerät 1 | صورة - جهاز الحماية الجديد 1
- photoProtectionDevice2 | photo | | Photo - Protection Device 2 | Foto - Schutzgerät 2 | صورة - جهاز الحماية الجديد 2
- photoProtectionDevice3 | photo | | Photo - Protection Device 3 | Foto - Schutzgerät 3 | صورة - جهاز الحماية الجديد 3
- photoProtectionDevice4 | photo | | Photo - Protection Device 4 | Foto - Schutzgerät 4 | صورة - جهاز الحماية الجديد 4

## Meter Information | Zählerinformationen | معلومات العداد

section_id: meter_information

- meterType | dropdown | | Meter Type | Zählertyp | نوع العداد
  options: single_direction, bidirectional, three_point
- meterRemovalNeeded | checkbox | | Meter Removal Needed | Zählerentfernung nötig | إزالة العداد مطلوبة
- meterReplacementNeeded | checkbox | | Meter Replacement Needed | Zählerwechsel nötig | استبدال العداد مطلوب
- newMeterType | dropdown | | New Meter Type | Neuer Zählertyp | نوع العداد الجديد
  options: single_direction, bidirectional, three_point
- remoteControl | checkbox | | Remote Control Device Present | Fernsteuergerät vorhanden | يوجد جهاز تحكم بالتموجات
- meterConsolidation | checkbox | | Meter Consolidation Required | Zählerzusammenlegung erforderlich | يلزم دمج العدادات
- measurementConcept | dropdown | | Measurement Concept | Messkonzept | مفهوم القياس
  options: excess_feed_in, full_feed_in, self_consumption

---

- photoMeter | photo | | Photo - Meter | Foto - Zähler | صورة - العداد
- photoMeterReadings | photo | | Photo - Meter Readings | Foto - Zählerstände | صورة - قراءة العداد

## §14a Preparation | §14a Vorbereitung | التحضير §14a

section_id: section_14a

- photoSection14a | photo | | Photo - §14a Preparation | Foto - §14a Vorbereitung | صورة - التحضير §14a

## Heat Pump Request | Wärmepumpenanfrage | طلب مضخة الحرارة

section_id: heat_pump

- heatPumpRequested | checkbox | | Heat Pump Requested from BSH | Wärmepumpe bei BSH angefragt | تم طلب مضخة حرارة من BSH

## Cable Routes | Kabelwege | مسارات الكابل

section_id: cable_routes

- routeOver25m | checkbox | | Cable Route Over 25m | Kabelweg über 25m | مسار الكابل يتجاوز 25 مترًا
- notes | textarea | | Notes | Notizen | ملاحظات

---

- photoCable1 | photo | | Photo - Cable Route 1 | Foto - Kabelweg 1 | صورة - مسار الكابل 1
- photoCable2 | photo | | Photo - Cable Route 2 | Foto - Kabelweg 2 | صورة - مسار الكابل 2
- photoCable3 | photo | | Photo - Cable Route 3 | Foto - Kabelweg 3 | صورة - مسار الكابل 3
- photoCable4 | photo | | Photo - Cable Route 4 | Foto - Kabelweg 4 | صورة - مسار الكابل 4

## Final Acceptance | Endabnahme | القبول النهائي

section_id: final_acceptance

- systemOperational | checkbox | required | System Operational and Ready | Anlage betriebsbereit | النظام جاهز للتشغيل
- cleanupDone | checkbox | | Cleanup Completed | Reinigung abgeschlossen | اكتمل التنظيف
- customerInformed | checkbox | required | Customer Informed and Protocol Discussed | Kunde informiert und Protokoll besprochen | تم إعلام العميل وشرح البروتوكول
- invoiceApproved | checkbox | required | Invoice Approved | Rechnung freigegeben | تمت الموافقة على إصدار الفاتورة
- attachedDocument | text | | Attached Document Filename | Dateiname des Anhangs | اسم المستند المرفق

## Remarks | Bemerkungen | ملاحظات

section_id: remarks

- remarks | textarea | | Remarks | Bemerkungen | ملاحظات

## Signatures | Unterschriften | التوقيعات

section_id: signatures

- signatureLocation | text | | Signature Location | Unterschriftsort | مكان التوقيع
- customerSignature | signature | required | Customer Signature | Kundenunterschrift | توقيع العميل
- installerSignature | signature | required | Installer Signature | Installateurunterschrift | توقيع الكهربائي / الشريك
