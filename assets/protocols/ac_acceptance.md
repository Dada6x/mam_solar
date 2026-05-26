---
protocol: ac_acceptance
title: AC Acceptance Protocol
title_de: AC-Abnahmeprotokoll
title_ar: بروتوكول قبول التيار المتردد
version: 3.0
company: MAM Solarbau
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- customerName | text | required | Customer Name | Kundenname | اسم العميل
- street | text | required | Street | Straße | الشارع
- houseNumber | text | required | House Number | Hausnummer | رقم المنزل
- zipCode | text | required | ZIP Code | PLZ | الرمز البريدي
- city | text | required | City | Stadt | المدينة
- email | email | required | Email | E-Mail | البريد الإلكتروني
- phone | text | required | Phone | Telefon | الهاتف
- installationDate | date | required | Installation Date | Installationsdatum | تاريخ التركيب
- installationTime | time | required | Installation Time | Installationszeit | وقت التركيب
- installerName | text | required | Installer Name | Name Monteur/Vorarbeiter | اسم المثبت/مشرف الموقع
- partnerCompany | text | | Partner Company | Name Partnerunternehmen | الشركة الشريكة

## Installation Type | Anlagentyp | نوع التركيب

section_id: installation_type

- backupInstalled | checkbox | required | Backup System Installed? | Backup-System installiert? | هل نظام النسخ الاحتياطي مثبت؟
<!-- TODO make ti show if its not checked  -->
- backupHint | textarea | | Hint / Notes | Hinweis | تلميح / ملاحظات
show_if: backupInstalled == unchecked
- inspectionCompleted | checkbox | required | Inspection Completed? | Prüfung durchgeführt? | هل اكتمل التفتيش؟

- inspectionReason | textarea | required | Reason | Begründung | السبب
show_if: inspectionCompleted == unchecked
<!-- TODO make ti show if its not checked  -->

- groundRodInstalled | checkbox | | Ground Rod Installed? | Erdspieß verbaut? | هل قضيب التأريض مثبت؟

- privateMeterInstalled | checkbox | | Private Meter Installed? | Privater Zwischenzähler verbaut? | هل العداد الخاص مثبت؟

## Inverter | Wechselrichter | العاكس

section_id: inverter

- inverterCount | dropdown | required | Number of Inverters | Anzahl Wechselrichter | عدد العاكسات
  options: 1, 2, 3, 4, 5
- mountedOnFireproofSurface | checkbox | | Inverter mounted on fireproof surface (tiles, stone, concrete, calcium silicate) | Wechselrichter auf brandsicherem Untergrund montiert (Fliesen, Stein, Beton, Calciumsilikatplatte) | العاكس مثبت على سطح مقاوم للحريق (بلاط، حجر، خرسانة، سيليكات الكالسيوم)
- normsFollowed | checkbox | | Manufacturer specifications followed (thermal clearances etc.) | Herstellervorgaben eingehalten (thermische Abstände etc.) | تم اتباع مواصفات الشركة المصنعة (المسافات الحرارية وما إلى ذلك)
- fusesPerSpec | checkbox | required | Fuses and cable cross-sections per manufacturer installation guide? | Absicherungen und Leitungsquerschnitte nach Herstellervorgaben? | هل المنصهرات ومقاطع الكابلات وفقًا لمواصفات الشركة المصنعة؟
options: yes, no
<!-- TODO make ti show if its not checked  -->
- fusesRemark | textarea | required | Remark | Bemerkung | ملاحظة
  show_if: fusesPerSpec == no

## Battery Storage | Speicher | تخزين البطارية

section_id: battery_storage
optional_section: true

- batteryTowers | dropdown | required | Number of Battery Towers | Anzahl Batterietürme | عدد أبراج البطارية
  options: 1, 2, 3,4,5,6,7,8
- normsFollowed | checkbox | | Manufacturer specifications followed (thermal clearances etc.) | Herstellervorgaben eingehalten (thermische Abstände etc.) | تم اتباع مواصفات الشركة المصنعة

## Equipotential Bonding | Potentialausgleichsschiene | قضيب موازنة الجهد

section_id: equipotential_bonding

- componentsConnected | checkbox | required | Components connected as per specification | Komponenten angeschlossen wie vorgegeben | المكونات متصلة وفقًا للمواصفات

- photoBonding | photo | required | Photo - Equipotential Bonding | Foto - Potentialausgleich | صورة - موازنة الجهد

## Meter Cabinet | Zählerschrank | خزانة العداد

section_id: meter_cabinet

- touchProtection | checkbox | | Touch Protection for new components | Berührungsschutz für neu installierte Betriebsmittel | حماية اللمس للمكونات الجديدة

- photoCabinet | photo | required | Photo - Cabinet | Bild Verteilerkasten | صورة - خزانة التوزيع

- apzWiring | radio | required | APZ Wiring present? | APZ Verdrahtung vorhanden? | هل أسلاك APZ موجودة؟
  options: yes, no
- apzInstalled | radio | required | APZ Installed? | APZ installiert? | هل APZ مثبت؟
  options: yes, no

---

- photoNewFuse | photo | required | Photo - New fuse (legible!) | Bild der neu verbauten Absicherung (lesbar!) | صورة - المنصهر الجديد (مقروء!)
- photoApzCable | photo | required | Photo - Cable in APZ | Bild der Leitung im APZ | صورة - الكابل في APZ
- photoApzWiringMeter | photo | required | Photo - APZ wiring at meter | Bild APZ Verdrahtung am Zähler | صورة - أسلاك APZ في العداد

---

- existingSystemChanges | radio | required | Changes to existing electrical system? | Änderungen an bestehender Elektroanlage? | هل تم إجراء تغييرات على النظام الكهربائي الحالي؟
  options: none, changes_made
- safeOperation | checkbox | | PV operation does not impair safe power supply within existing system | PV-Betrieb beeinträchtigt nicht die sichere Stromversorgung der bestehenden Anlage | تشغيل PV لا يضعف الإمداد الآمن للكهرباء
- energridInstalled | radio | required | EnerGrid or comparable installed? | EnerGrid oder vergleichbar? | هل EnerGrid أو ما يماثله مثبت؟
  options: yes, no

---

- photoEnergrid | photo | required | Photo - EnerGrid | Foto - EnerGrid | صورة - EnerGrid

## Meter Registration (IBN) | Ein- und Ausbaumeldung IBN | تسجيل العداد

section_id: meter_registration

### Existing Meters | Vorhandene Zähler | العدادات الموجودة

- existingMeters | repeatable | required | Existing Meters | Vorhandene Zähler | العدادات الموجودة
  min: 1
  max: 10
  fields:
  - meterNumber | text | required | Meter Number | Zählernummer | رقم العداد
  - meterType | text | | Purpose | Zweck | الغرض
  - photo | photo | required | Photo | Foto | صورة

### New Meter | Neuer Zähler | عداد جديد

- newMeterType | dropdown | required | Type of new meter | Typ des neuen Zählers | نوع العداد الجديد
  options: three_point, ehz
- remoteControlPresent | checkbox | required | Remote control receiver present? | Rundsteuerempfänger vorhanden? | هل مستقبل التحكم عن بعد موجود؟
  options: yes, no
  <!-- TODO make ti show if its not checked  -->
- photoRemoteControl | photo | required | Photo - Remote Control Receiver | Bild des Rundsteuerempfängers | صورة - مستقبل التحكم عن بعد
  show_if: remoteControlPresent == yes
- removeRemoteControl | checkbox | required | Must remote control be removed? | Muss Rundsteuerempfänger ausgebaut werden? | هل يجب إزالة مستقبل التحكم عن بعد؟
  options: yes, no
  <!-- TODO make ti show if its not checked  -->
- meterConsolidation | checkbox | required | Meter Consolidation needed? | Zählerzusammenlegung erforderlich? | هل دمج العدادات مطلوب؟
  options: yes, no
- consolidationDescription | textarea | required | Description of consolidation | Beschreibung der Zählerzusammenlegung | وصف دمج العدادات
  show_if: meterConsolidation == yes
- meterRemarks | textarea | | Other remarks about meters | Sonstige Anmerkungen zu den Zählern | ملاحظات أخرى حول العدادات

### Measurement Concept | Messkonzept | مفهوم القياس

- measurementConcept | dropdown | required | Measurement Concept | Welches Messkonzept wurde aufgebaut? | ما هو مفهوم القياس؟
  options: excess_feed_in, full_feed_in, heat_pump_cascade, other

---

- photoPrep14a | photo | required | Photos - Preparation §14a | Bilder Vorbereitung §14a | صور - التحضير §14a
  multiple: true

## Heat Pump Order | Wärmepumpenauftrag | طلب المضخة الحرارية

section_id: heat_pump
optional_section: true

- heatPumpOrdered | checkbox | required | Heat pump ordered through MAM Solarbau? | Wärmepumpe bei MAM Solarbau beauftragt? | هل تم طلب المضخة الحرارية عبر MAM Solarbau؟
  options: yes, no
- photoSubDistribution | photo | required | Photo - Sub-distribution / ZK integration from distance (with covers) | Unterverteilung/ZK Einbindung aus größerer Entfernung (mit Abdeckungen) | صورة - التوزيع الفرعي / دمج ZK من مسافة (مع الأغطية)
  show_if: heatPumpOrdered == yes
- photoFusesHeatPump | photo | required | Photo - Fuses for heat pump (without covers, legible) | Sicherungen für Wärmepumpenabsicherung leserlich fotografiert (ohne Abdeckungen) | صورة - منصهرات المضخة الحرارية (بدون أغطية، مقروءة)
  show_if: heatPumpOrdered == yes

## Cable Routes | Kabelwege | مسارات الكابل

section_id: cable_routes

- photoCableRoute | photo | required | Photos of entire AC cable route | Bilder des gesamten AC Kabelwegs | صور لمسار كابل AC بالكامل
  multiple: true
- routeOver25m | checkbox | | Cable route over 25m? | Kabelweg über 25m? | مسار الكابل أكثر من 25 م؟
  options: yes, no
  <!-- TODO make ti show if its not checked  -->

- additionalMeters | number | required | How many additional meters were installed? | Wie viel Meter wurden zusätzlich verbaut? | كم متر إضافي تم تركيبه؟
  show_if: routeOver25m == yes

## Cleanliness | Sauberkeit | النظافة

section_id: cleanliness

- siteCleanedUp | checkbox | required | Waste was loaded into own vehicle, site left clean as found | Abfall im eigenen Fahrzeug, Baustelle ordentlich/reinlich verlassen | تم تحميل النفايات في السيارة الخاصة، تم ترك الموقع نظيفًا كما كان

## Final Acceptance | Abschluss des Abnahmeprotokolls | إكمال بروتوكول القبول

section_id: final_acceptance

- detailsRecorded | checkbox | required | Electrician has recorded all details, discussed and explained with customer. System operational and ready for invoicing. | Alle Details sorgfältig eingetragen, mit dem Kunden besprochen und erklärt. Anlage betriebsbereit und zur Rechnungsstellung freigegeben. | تم تسجيل جميع التفاصيل ومناقشتها مع العميل. النظام جاهز للتشغيل والفوترة.
<!-- TODO add a file for this  -->
- measurementProtocol | file | required | Attach Measurement Protocol | Messprotokoll anhängen | إرفاق بروتوكول القياس
accepted_formats: pdf, jpg, png

- completionDateTime | datetime | required | Date and Time | Datum und Uhrzeit | التاريخ والوقت

- completionDate | date | required | Completion Date | Abschlussdatum | تاريخ الإنجاز
- completionTime | time | required | Completion Time | Abschlusszeit | وقت الإنجاز

- remarks | textarea | | Remarks | Bemerkungen | ملاحظات

## Customer Signature | Unterschrift des Kunden/Bevollmächtigten | توقيع العميل/الممثل

section_id: customer_signature

- signatureLocation | text | required | Location | Ort | الموقع
- signatureTime | time | required | Time | Zeitpunkt | الوقت
  default: current_time
- signedBy | text | required | Signed by | Unterschrift von | موقع من قبل
- customerSignature | signature | required | Customer or Authorized
  Representative Signature | Unterschrift des Kunden oder Bevollmächtigen | توقيع العميل أو الممثل المعتمد

- customerFullName | text | required | Customer First and Last Name | Vor- und Nachname Kunde | الاسم الكامل للعميل
- representativeFullName | text | | Representative First and Last Name | Vor- und Nachname Bevollmächtigter | الاسم الكامل للممثل
  show_if: signedBy == authorized_representative

## Installer Signature | Unterschrift des Elektrikers/Partners | توقيع الكهربائي/الشريك

section_id: installer_signature

<!-- TODO add a display text thats not required to do anything or input anything just for reading -->

- legalDeclaration | display_text | | Declaration: Operator and installer declare that the system shown above and in the documentation is technically operational on the day on which the AC and DC acceptance protocols are signed (§ 3 No. 30 EEG 2021). | Vom Anlagenbetreiber und Installationsbetrieb wird erklärt, dass die oben genannte Anlage technisch betriebsbereit i.S.d. § 3 Nr. 30 EEG (2021) ist, an dem das AC- und DC-Abnahmeprotokoll unterzeichnet vorliegen. | إقرار: يصرح المشغل والمثبت بأن النظام جاهز للتشغيل تقنيًا في يوم توقيع بروتوكولات القبول AC و DC.
- objectionPeriod | display_text | | Objection period is 14 days; after expiration, the acceptance protocol is considered confirmed. | Die Widerspruchsfrist beträgt 14 Tage, nach Ablauf der Frist gilt das Abnahmeprotokoll als bestätigt. | فترة الاعتراض 14 يومًا، وبعد انتهائها يعتبر بروتوكول القبول مؤكدًا.
- installerDeclaration | display_text | | The installer confirms with his signature that the electrical system has been installed, measured and accepted according to current DIN-VDE standards as well as TAB and TAR. | Der ausführende Elektroinstallateur bestätigt mit seiner Unterschrift die elektrische Anlage nach den aktuell gültigen DIN-VDE Normen sowie TAB und TAR installiert, gemessen und abgenommen zu haben. | يؤكد المثبت بتوقيعه أن النظام الكهربائي تم تركيبه وقياسه وقبوله وفقًا لمعايير DIN-VDE الحالية وكذلك TAB و TAR.
- installerSignature | signature | required | Installer / Partner On-Site Signature | Unterschrift des Elektrikers/Partners vor Ort | توقيع الكهربائي / الشريك في الموقع
