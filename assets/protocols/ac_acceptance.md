---
protocol: ac_acceptance
title: AC Acceptance Protocol
title_de: AC-Abnahmeprotokoll
title_ar: بروتوكول قبول التيار المتردد
version: 4.2
company: MAM Solarbau
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- customerName | text | required | Customer Name | Kundenname | اسم العميل
- street | text | required | Street | Straße | الشارع
- houseNumber | text | | House Number | Hausnummer | رقم المنزل
- city | text | required | City | Stadt | المدينة
- zipCode | text | required | ZIP Code | PLZ | الرمز البريدي
- email | email | required | Email | E-Mail | البريد الإلكتروني
- phone | text | required | Phone | Telefon | الهاتف
- installationDate | date | required | Installation Date | Installationsdatum | تاريخ التركيب
- installationTime | time | required | Installation Time | Installationszeit | وقت التركيب
- installerName | text | required | Installer Name | Installateur / Monteur | اسم المثبت
- partnerCompany | text | | Partner Company | Partnerfirma | الشركة الشريكة

---

## Installation Details | Installationsdetails | تفاصيل التركيب

section_id: installation_details

- installationType | dropdown | | Installation Type | Installationstyp | نوع التركيب
  options: solar_pv, solar_pv_battery, solar_pv_wallbox

- storageManufacturer | text | | Storage Manufacturer | Speicherhersteller | الشركة المصنعة للتخزين
- wallboxInstalled | checkbox | | Wallbox Installed | Wallbox installiert | شاحن الحائط مثبت
- backupInstalled | checkbox | | Backup Installed | Backup installiert | النسخ الاحتياطي مثبت
- inspectionCompleted | checkbox | | Inspection Completed | Prüfung durchgeführt | تم التفتيش
- inspectionReason | textarea | | Reason if not inspected | Grund wenn nicht geprüft | سبب عدم التفتيش
  show_if: inspectionCompleted == false

- groundRodInstalled | checkbox | | Ground Rod Installed | Erdungsstab installiert | قضيب التأريض مثبت
- privateMeterInstalled | checkbox | | Private Meter Installed | Zwischenzähler installiert | العداد الخاص مثبت
- supervisorIntroduced | checkbox | | Supervisor Introduced | Aufsicht eingewiesen | وجود مشرف
- shoeCoversWorn | checkbox | | Shoe Covers Worn | Schuhüberzieher getragen | ارتداء أغطية الأحذية

---

## Inverter | Wechselrichter | الانفرتر

section_id: inverter
repeatable: true
min: 1
max: 5

- brand | text | | Brand | Marke | الماركة
- model | text | | Model | Modell | الطراز
- serialNumber | text | | Serial Number | Seriennummer | الرقم التسلسلي
- networkType | dropdown | | Network Type | Netzwerktyp | نوع الشبكة
  options: wlan, powerline, ethernet

- installedCorrectly | checkbox | | Installed Correctly | Richtig installiert | مثبت بشكل صحيح
- mountedOnFireproofSurface | checkbox | | Mounted on Fireproof Surface | Auf feuerfestem Untergrund montiert | مثبت على سطح مقاوم للحريق

- photoDataplate | photo | | Photo - Dataplate | Foto - Typenschild | صورة - لوحة البيانات
- photoAcGrid | photo | | Photo - AC Grid Connection | Foto - AC Netzanschluss | صورة - اتصال شبكة AC
- photoAcBackup | photo | | Photo - AC Backup Connection | Foto - AC Backup Anschluss | صورة - اتصال AC الاحتياطي
- photoCommunicationPlug | photo | | Photo - Communication Plug | Foto - Kommunikationsanschluss | صورة - منفذ الاتصال
- photoThreeCommunicationPorts | photo | | Photo - Three Communication Ports | Foto - Drei Kommunikationsanschlüsse | صورة - منافذ الاتصال الثلاثة
- photoEarthingLeft | photo | | Photo - Left Earthing | Foto - Erdung links | صورة - التأريض الأيسر
- photoEarthingRight | photo | | Photo - Right Earthing | Foto - Erdung rechts | صورة - التأريض الأيمن
- photoPlcOrWlanExtender | photo | | Photo - PLC or WLAN Extender | Foto - PLC oder WLAN Verstärker | صورة - PLC أو مقوي WLAN
- photoDcBatteryCables | photo | | Photo - DC Battery Cables | Foto - DC Batteriekabel | صورة - كابلات بطارية DC
- photoFinalInstall | photo | | Photo - Final Installation | Foto - Endinstallation | صورة - التركيب النهائي

- manufacturerStandardsFollowed | checkbox | | Manufacturer Standards Followed | Herstellerstandards eingehalten | تم اتباع معايير الشركة المصنعة

<!-- TODO add them later -->

<!-- - firmwareVersion | text | | Firmware Version | Firmware Version | إصدار البرنامج -->
<!-- - monitoringActivated | checkbox | | Monitoring Activated | Monitoring aktiviert | تفعيل المراقبة -->
<!-- - commissioningDate | date | | Commissioning Date | Inbetriebnahmedatum | تاريخ التشغيل الأول -->
<!-- - gridCodeCompliant | checkbox | | Grid Code Compliance | Netzkonformität erfüllt | مطابقة معايير الشبكة -->
<!-- - rcdTestPassed | checkbox | | RCD Test Passed | FI-Test bestanden | نجاح اختبار RCD -->

---

## Battery Storage | Batteriespeicher | تخزين البطارية

section_id: battery_storage
repeatable: true
min: 1
max: 5

- batteryBrand | text | | Battery Brand | Batteriemarke | العلامة التجارية للبطارية
- batteryModel | text | | Battery Model | Batteriemodell | طراز البطارية
- batterySid | text | | SID | SID | SID
- batteryTowers | number | | Battery Towers | Batterietürme | أبراج البطارية
- batteryModulesPerTower | number | | Modules per Tower | Module pro Turm | الوحدات لكل برج
- serialNumbers | textarea | | Serial Numbers | Seriennummern | الأرقام التسلسلية
- standardsFollowed | checkbox | | Standards Followed | Normen eingehalten | تم اتباع المعايير

- photoQrCode | photo | | Photo - QR Code | Foto - QR-Code | صورة - رمز QR
- photoBatteryConnections | photo | | Photo - Battery Connections | Foto - Batterieanschlüsse | صورة - توصيلات البطارية
- photoEmsNumber | photo | | Photo - EMS Number | Foto - EMS Nummer | صورة - رقم EMS
- photoAcPlugOpen | photo | | Photo - Open AC Plug | Foto - Offener AC Stecker | صورة - قابس AC المفتوح
- photoBatteryWithoutCovers | photo | | Photo - Battery Without Covers | Foto - Batterie ohne Abdeckung | صورة - البطارية بدون أغطية
- photoBatteryWithCovers | photo | | Photo - Battery With Covers | Foto - Batterie mit Abdeckung | صورة - البطارية مع الأغطية
- photoBatteryFromDistance | photo | | Photo - Battery From Distance | Foto - Batterie aus der Entfernung | صورة - البطارية من مسافة
- photoBatteryBase | photo | | Photo - Battery Base | Foto - Batteriesockel | صورة - قاعدة البطارية
- photoBatteryEarthing | photo | | Photo - Battery Earthing | Foto - Batterie Erdung | صورة - تأريض البطارية
- photoBatteryTowerFinal | photo | | Photo - Final Battery Tower | Foto - Finaler Batterieturm | صورة - البرج النهائي للبطارية

---

## Meter Cabinet | Zählerschrank | خزانة العداد

section_id: meter_cabinet

- newCabinetInstalled | checkbox | | New Cabinet Installed | Neuer Schrank installiert | تم تركيب خزانة جديدة
- allComponentsInstalled | checkbox | | All Components Installed | Alle Komponenten installiert | تم تركيب جميع المكونات
- apzInstalled | checkbox | | APZ Installed | APZ installiert | تم تركيب APZ
- energridInstalled | checkbox | | EnerGrid Installed | EnerGrid installiert | تم تركيب EnerGrid
- touchProtection | checkbox | | Touch Protection Installed | Berührungsschutz installiert | تم تركيب الحماية من اللمس
- apzWiring | checkbox | | APZ Wiring Completed | APZ Verdrahtung abgeschlossen | تم إنهاء توصيلات APZ
- existingSystemChanges | checkbox | | Existing System Modified | Änderungen am Bestandssystem | تم تعديل النظام الحالي
- gridStabilityEnsured | checkbox | | Grid Stability Ensured | Netzstabilität sichergestellt | تم ضمان استقرار الشبكة

- photoNewFuse | photo | | Photo - New Fuse | Foto - Neue Sicherung | صورة - الفيوز الجديد
- photoApzCable | photo | | Photo - APZ Cable | Foto - APZ Kabel | صورة - كابل APZ
- photoApzWiringMeter | photo | | Photo - APZ Wiring Meter | Foto - APZ Verdrahtung Zähler | صورة - توصيلات APZ للعداد
- photoEnergrid | photo | | Photo - EnerGrid | Foto - EnerGrid | صورة - EnerGrid
- photoPvLabel | photo | | Photo - PV Label | Foto - PV Beschriftung | صورة - ملصق PV
- photoNewCabinet | photo | | Photo - New Cabinet | Foto - Neuer Schrank | صورة - الخزانة الجديدة
- photoOldCabinet | photo | | Photo - Old Cabinet | Foto - Alter Schrank | صورة - الخزانة القديمة
- photoSlsOrNh | photo | | Photo - SLS or NH Fuse | Foto - SLS oder NH Sicherung | صورة - فيوز SLS أو NH
- photoAcOvervoltage | photo | | Photo - AC Overvoltage Protection | Foto - AC Überspannungsschutz | صورة - حماية زيادة الجهد AC
- photoRcd | photo | | Photo - RCD | Foto - FI-Schalter | صورة - قاطع RCD
- photoCableRouteToNewCabinet | photo | | Photo - Cable Route to New Cabinet | Foto - Kabelweg zum neuen Schrank | صورة - مسار الكابل إلى الخزانة الجديدة
- photoApzCableInside | photo | | Photo - APZ Cable Inside | Foto - APZ Kabel innen | صورة - كابل APZ الداخلي
- photoApzMeterConnections | photo | | Photo - APZ Meter Connections | Foto - APZ Zähleranschlüsse | صورة - توصيلات عداد APZ

- photoCabinet | photo | | Cabinet Photo | Schrank Foto | صورة الخزانة

---

## Distribution Board | Endabnahme | لوحة التوزيع

section_id: distribution_board
repeatable: true
min: 1
max: 5

- photoDistBoard | photo | | Photo - Distribution Board | Foto - Verteilerschrank | صورة - لوحة التوزيع
- additionalDetails | textarea | | Additional Details | Zusätzliche Details | تفاصيل إضافية

---

## Protection Devices | Schutzeinrichtungen | أجهزة الحماية

section_id: protection_devices
repeatable: true
min: 1
max: 5

- photoProtectionDevice | photo | | Photo - Protection Device | Foto - Schutzeinrichtung | صورة - جهاز الحماية
<!-- TODO add them three to the protocol -->
- noChangesMade | checkbox | | No Changes Have Been Made | Keine Änderungen vorgenommen | لم يتم إجراء أي تغييرات
- systemStabilityTested | checkbox | | Solar System Does Not Affect Stability and Security | Netzstabilität und Sicherheit geprüft | تم التأكد أن النظام الشمسي لا يؤثر على استقرار وأمان النظام
- enerGridUsed | checkbox | | EnerGrid Used | EnerGrid verwendet | تم استخدام EnerGrid

---

## Meter Registration (IBN) | Zählerregistrierung (IBN) | تسجيل العداد (IBN)

section_id: meter_registration
repeatable: true
min: 1
max: 5

- meterNumber | text | | Meter Number | Zählernummer | رقم العداد
- meterType | text | | Current Meter Type | Aktueller Zählertyp | نوع العداد الحالي
- photoMeter | photo | | Photo - Current Meter | Foto - Aktueller Zähler | صورة - العداد الحالي
- existingMeters | text | | Existing Meters | Vorhandene Zähler | العدادات الموجودة
- newMeterType | text | | New Meter Type | Neuer Zählertyp | نوع العداد الجديد
- remoteControlPrdesent | checkbox | | Remote Control Present | Rundsteuerempfänger vorhanden | جهاز التحكم موجود
- photoRemoteControl | photo | | Photo - Remote Control | Foto - Rundsteuerempfänger | صورة - جهاز التحكم
- removeRemoteControl | checkbox | | Remove Remote Control | Rundsteuerempfänger entfernen | إزالة جهاز التحكم
- meterConsolidation | checkbox | | Meter Consolidation | Zählerzusammenlegung | دمج العدادات
- consolidationDescription | textarea | | Consolidation Description | Beschreibung Zusammenlegung | وصف الدمج
- meterRemarks | textarea | | Meter Remarks | Bemerkungen zum Zähler | ملاحظات العداد
- meterRemovalNeeded | checkbox | | Meter Removal Needed | Zählerausbau erforderlich | يتطلب إزالة العداد
- meterReplacementNeeded | checkbox | | Meter Replacement Needed | Zählerwechsel erforderlich | يتطلب استبدال العداد
- photoMeterReadings | photo | | Photo - Meter Readings | Foto - Zählerstände | صورة - قراءات العداد
- measurementConcept | text | | Measurement Concept | Messkonzept | مفهوم القياس

---

## Cable Routes | Kabelwege | مسارات الكابل

section_id: cable_routes

- routeOver25m | radio | | Cable Route Over 25m? | Kabelweg über 25m? | هل مسار الكابل أكثر من 25 متر؟
  options: yes, no

- additionalMeters | number | | Additional Installed Cable Length (m) | Zusätzlich verbaute Meter | عدد الأمتار الإضافية المركبة
  show_if: routeOver25m == yes

- notes | textarea | | Notes | Notizen | ملاحظات

- photoCableRoute | multiphoto | | Photos of Entire AC Cable Route | Bilder des gesamten AC Kabelwegs | صور لمسار كابل AC بالكامل
---

## Heat Pump Order | Wärmepumpenauftrag | طلب المضخة الحرارية

section_id: heat_pump
optional_section: true

- heatPumpOrdered | radio | | Heat Pump Ordered Through MAM Solarbau? | Wärmepumpe bei MAM Solarbau beauftragt? | هل تم طلب المضخة الحرارية عبر MAM Solarbau؟
  options: yes, no

- photoSubDistribution | photo | | Photo - Sub-distribution / ZK Integration from Distance | Unterverteilung / ZK Einbindung aus größerer Entfernung | صورة - التوزيع الفرعي / دمج ZK من مسافة
  show_if: heatPumpOrdered == yes

- photoFusesHeatPump | photo | | Photo - Heat Pump Fuses (Legible) | Sicherungen Wärmepumpe leserlich | صورة - منصهرات المضخة الحرارية واضحة
  show_if: heatPumpOrdered == yes

---

## Cleanliness | Sauberkeit | النظافة

section_id: cleanliness

- siteCleanedUp | checkbox | | Waste Loaded Into Own Vehicle and Site Left Clean | Abfall im eigenen Fahrzeug entsorgt und Baustelle sauber verlassen | تم تحميل النفايات وترك الموقع نظيفًا

---

## Final Acceptance | Endabnahme | القبول النهائي

section_id: final_acceptance

- systemOperational | checkbox | required | System Operational | Anlage betriebsbereit | النظام يعمل
- customerInformed | checkbox | required | Customer Informed | Kunde informiert | تم إعلام العميل
- invoiceApproved | checkbox | | Invoice Approved | Rechnung freigegeben | تمت الموافقة على الفاتورة
- detailsRecorded | checkbox | | All Details Recorded and Discussed with Customer | Alle Details erfasst und mit dem Kunden besprochen | تم تسجيل جميع التفاصيل ومناقشتها مع العميل
- completionDate | date | required | Completion Date | Abschlussdatum | تاريخ الانتهاء
- completionTime | time | required | Completion Time | Abschlusszeit | وقت الانتهاء

---

## Remarks | Bemerkungen | ملاحظات

section_id: remarks

- remarksGeneral | textarea | | Remarks | Bemerkungen | ملاحظات

---

## Additional info | additional  | additional info

section_id: additional_info
repeatable: true
min: 1
max: 10

- note | textarea | | Remarks | Bemerkungen | ملاحظة
- image | photo| || image| image | صورة

---

## Signatures | Unterschriften | التوقيعات

section_id: signatures

- customerFullName | text | required | Customer Full Name | Kundenvollname | الاسم الكامل للعميل
- customerSignature | signature | required | Customer Signature | Unterschrift Kunde | توقيع العميل
- installerSignature | signature | required | Installer Signature | Unterschrift Installateur | توقيع المثبت