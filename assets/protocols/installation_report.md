---
protocol: installation_report
title: Site Survey Protocol (Aufmass)
title_de: Aufmassprotokoll
title_ar: بروتوكول المسح الموقعي
version: 4.0
company: MAM Solarbau
note: Comprehensive on-site survey for PV system planning (roof, electrical, cable routes, storage)
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- surveyTechnician | text | required | Survey Technician On-Site | Aufmaßtechniker vor Ort | فني المسح في الموقع
- customerName | text | required | Customer Name | Kunde | اسم العميل
- street | text | required | Street | Straße | الشارع
- houseNumber | text | required | House Number | Hausnummer | رقم المنزل
- zipCode | text | required | ZIP Code | PLZ | الرمز البريدي
- installationCity | text | required | Installation City | Montageort | مدينة التركيب
- email | email | required | Email | E-Mail | البريد الإلكتروني
- phone | text | required | Phone (landline or mobile) | Telefon (Festnetz oder Mobil) | الهاتف (أرضي أو محمول)

## Storage Information | Speicher | معلومات التخزين

section_id: storage_info

- pvsNumber | text | | PVS Number / Order ID | PVS Nummer / Auftrags ID | رقم PVS / معرف الطلب
- storageType | dropdown | | Storage Type | Speicherart | نوع التخزين
  options: home_4, home_p4, home_e4, senec, ecoflow, sonnen, tesla_powerwall, other
- storageTypeOther | text | | Storage Type (other) | Speicherart (Sonstige) | نوع التخزين (أخرى)
  show_if: storageType == other

## 1. Roof | Dach | السقف

section_id: roof

- photoOverview | photo | | Aerial overview photo with drawing (Yellow=Storage, Blue=ZK, Green=Wallbox, Red=HAK, Brown=WR) | Übersichtsbild mit Zeichnung (Gelb=Speicher, Blau=ZK, Grün=Wallbox, Rot=HAK, Braun=WR) | صورة جوية مع رسم المعدات
- roofCovering | dropdown | | Roof Covering | Dacheindeckung | تغطية السقف
  options: tile, sheet_metal, slate, bitumen, other
- scaffoldOnSidewalk | radio | | Scaffold on sidewalk/street? | Gerüst auf Gehweg/Straße? | السقالة على الرصيف؟
  options: yes, no
- isolateOverheadLine | radio | | Isolate overhead line? | Freileitung isolieren? | عزل الخط العلوي؟
  options: yes, no
- externalLightning | radio | | External lightning protection present? | Äußerer Blitzschutz vorhanden? | حماية البرق الخارجية؟
  options: yes, no
- satDishPresent | radio | | SAT dish on roof area? | SAT Schüssel auf Dachfläche? | طبق SAT على السقف؟
  options: yes, no
- mustMoveSatDish | radio | | Must SAT dish be moved? | SAT Schüssel versetzen? | نقل طبق SAT؟
  options: yes, no
  show_if: satDishPresent == yes
- newSatDishLocation | text | | New SAT dish location | Neuer SAT Standort | الموقع الجديد لـ SAT
  show_if: mustMoveSatDish == yes
- photoNewSatDishLocation | photo | | Photo of new SAT location | Foto neuer SAT Standort | صورة الموقع الجديد
  show_if: mustMoveSatDish == yes

### Roof Surfaces | Dachflächen | أسطح السقف

- roofSurfaces | repeatable | | Roof Surfaces | Dachflächen | أسطح السقف
  min: 1
  max: 4
  fields:
  - dormersPresent | radio | | Dormers present? | Gauben vorhanden? | نوافذ علوية؟
    options: yes, no
  - photosRoof | multiphoto | | Roof photos (outside + inside, min. 3 each) | Dachfotos (außen + innen, mind. 3) | صور السقف (خارج + داخل)
    min: 6
  - eaveHeightMeters | number | | Eave height (m) | Traufhöhe (m) | ارتفاع الإفريز (م)
  - eaveOverhangCm | number | | Eave overhang (cm) | Traufüberstand (cm) | بروز الإفريز (سم)
  - vergeOverhangCm | number | | Verge overhang (cm) | Dachüberstand Ortgang (cm) | بروز الحافة (سم)
  - ridgeTilesMortared | radio | | Ridge tiles mortared? | Firstziegel vermörtelt? | قرميد القمة بالملاط؟
    options: yes, no
  - rafterWidthCm | number | | Rafter width (cm) | Sparrenbreite (cm) | عرض العارضة (سم)
  - rafterHeightCm | number | | Rafter height (cm) | Sparrenhöhe (cm) | ارتفاع العارضة (سم)
  - rafterDistanceCm | number | | Rafter distance center-to-center (cm) | Sparrenabstand Mitte-Mitte (cm) | المسافة بين العوارض (سم)
  - photoRafterMeasurements | multiphoto | | Photos of rafter measurements (width / height / distance) | Fotos Sparrenmaße (Breite / Höhe / Abstand) | صور قياسات العوارض
    min: 3
  - visibleRafters | radio | | Visible rafters? | Sichtsparren? | عوارض مرئية؟
    options: yes, no
  - aboveRoofInsulation | radio | | Above-roof insulation? | Aufdachdämmung? | عزل فوق السقف؟
    options: yes, no
  - feltPlugs | radio | | Felt plugs? | Pappdocken? | سدادات اللباد؟
    options: yes, no
  - roofPitchDegrees | number | | Roof pitch (°) | Dachneigung (°) | ميل السقف (°)
  - photoRoofPitch | photo | | Photo of pitch measurement | Foto Dachneigung | صورة قياس الميل
  - tileType | dropdown | | Tile Type | Ziegeltyp | نوع القرميد
    options: concrete_tile, clay_tile, other
  - photoTile | multiphoto | | Tile photos (top / bottom) with cover dimensions | Ziegelfotos (oben/unten) mit Deckmaßen | صور القرميد مع الأبعاد
    min: 2
  - tileHeightCm | number | | Cover height (cm) | Deckhöhe (cm) | ارتفاع التغطية (سم)
  - tileWidthCm | number | | Cover width (cm) | Deckbreite (cm) | عرض التغطية (سم)
  - tilesScrewedOrClamped | radio | | Tiles screwed or clamped? | Ziegel geschraubt oder geklammert? | القرميد مثبت بالبراغي أم المشابك؟
    options: yes, no
  - hasReplacementTiles | radio | | Customer has replacement tiles? | Kunde hat Ersatzziegel? | العميل لديه قرميد بديل؟
    options: yes, no
  - customerInformedAboutTiles | checkbox | | Customer informed: min. 20 replacement tiles needed | Kunde informiert: mind. 20 Ersatzziegel nötig | تم إبلاغ العميل: 20 قرميدًا بديلًا على الأقل

## 2. DC Cable Route | DC Kabelweg | مسار كابل DC

section_id: dc_cable_route

- photoDcCableRoute | multiphoto | | Photos of planned DC cable route (lines in BLUE, mark breakthroughs) | Fotos geplanter DC-Kabelweg (Linien BLAU, Durchbrüche kennzeichnen) | صور مسار كابل DC (الخطوط زرقاء)
  min: 2
- dcCableLengthMeters | number | | Cable length (m) | Kabellänge (m) | طول الكابل (م)

## 3. Electrical | Elektro | الكهرباء

section_id: electrical

- photoHak | multiphoto | | Photo HAK opened (1m distance) | Foto HAK geöffnet (1m Abstand) | صورة HAK مفتوحة
- hakFuseAmps | number | | HAK Fuse (A) | HAK Absicherung (A) | منصهر HAK (أمبير)
- hakHousingMaterial | dropdown | | HAK Housing Material | HAK Gehäusematerial | مادة هيكل HAK
  options: metal, non_metal
- hakOpenableWithoutProvider | radio | | HAK openable without energy provider? | HAK ohne Energieversorger öffenbar? | فتح HAK بدون مزود الطاقة؟
  options: yes, no
- distanceMeterToHak | number | | Distance meter cabinet → HAK (m) | Abstand Zählerkasten → HAK (m) | المسافة من خزانة العداد إلى HAK (م)
- photosWayToMeter | multiphoto | | Photos way to meter cabinet | Fotos Weg zum Zählerkasten | صور الطريق إلى خزانة العداد
- photoMeterCabinet | multiphoto | | Photos meter cabinet (all covers open, 1m distance) | Fotos Zählerschrank (alle Abdeckungen offen, 1m) | صور خزانة العداد
- typeLabelPresent | radio | | Type label present? | Typenschild vorhanden? | لوحة النوع موجودة؟
  options: yes, no
- photoTypeLabel | photo | | Photo of type label | Foto Typenschild | صورة لوحة النوع
  show_if: typeLabelPresent == yes
- photoMainMeter | photo | | Photo of main meter (PV clamp point) | Foto Hauptzähler (PV-Klemmstelle) | صورة العداد الرئيسي
- mainMeterNumber | text | | Main meter number | Zählernummer Hauptzähler | رقم العداد الرئيسي
- mainMeterPurpose | text | | Purpose of main meter | Zweck des Zählers | الغرض من العداد
- additionalMetersPresent | radio | | Additional meters present? | Zusätzliche Zähler vorhanden? | عدادات إضافية؟
  options: yes, no
- additionalMeters | repeatable | | Additional Meters | Zusätzliche Zähler | عدادات إضافية
  show_if: additionalMetersPresent == yes
  min: 1
  fields:
  - photoMeter | photo | | Photo of meter | Foto Zähler | صورة العداد
  - meterNumber | text | | Meter number | Zählernummer | رقم العداد
  - meterPurpose | text | | Purpose (e.g. 1.OG, Heat Pump) | Zweck (z.B. 1.OG, Wärmepumpe) | الغرض
- meterConsolidation | radio | | Meter consolidation needed? | Zählerzusammenlegung nötig? | دمج العدادات؟
  options: yes, no
- otherEnergySystems | radio | | Other energy generation systems present? | Andere Erzeugungsanlagen vorhanden? | أنظمة توليد طاقة أخرى؟
  options: yes, no
- photoOptionalZkLocation | photo | | Photo of optional ZK location | Foto optionaler ZK-Standort | صورة موقع ZK الاختياري
- photosCableRoutes | multiphoto | | Photos all cable routes (HAK → ZK, existing → optional) | Fotos alle Kabelwege (HAK→ZK, Bestand→Optional) | صور جميع مسارات الكابل

## 4. Signal Measurement | Pegelmessung | قياس الإشارة

section_id: signal_measurement

### Existing ZK | ZK Bestand | ZK الموجود

- signalTMobileExisting | number | | T-Mobile (RSRP dBm) | T-Mobile (RSRP dBm) | T-Mobile (RSRP dBm)
- signalVodafoneExisting | number | | Vodafone (RSRP dBm) | Vodafone (RSRP dBm) | Vodafone (RSRP dBm)
- signalTelefonicaExisting | number | | Telefonica (RSRP dBm) | Telefonica (RSRP dBm) | Telefonica (RSRP dBm)
- photoSignalExisting | multiphoto | | Photos measurement device + antenna placement | Fotos Messgerät + Antennenplatzierung | صور جهاز القياس + وضع الهوائي
  min: 2

### Optional ZK | ZK Optional | ZK الاختياري

- signalTMobileOptional | number | | T-Mobile (RSRP dBm) | T-Mobile (RSRP dBm) | T-Mobile (RSRP dBm)
- signalVodafoneOptional | number | | Vodafone (RSRP dBm) | Vodafone (RSRP dBm) | Vodafone (RSRP dBm)
- signalTelefonicaOptional | number | | Telefonica (RSRP dBm) | Telefonica (RSRP dBm) | Telefonica (RSRP dBm)
- photoSignalOptional | multiphoto | | Photos measurement device + antenna placement | Fotos Messgerät + Antennenplatzierung | صور جهاز القياس + وضع الهوائي
  min: 2

## 5. Storage / Inverter | Speicher / Wechselrichter | التخزين / العاكس

section_id: storage_inverter

- photosInstallLocation | multiphoto | | Photos of install location with dimensions (H/W) | Fotos Montageort mit Maßen (H/B) | صور موقع التركيب مع الأبعاد
  min: 2
- storageOnFireproofSurface | radio | | Storage on fireproof surface? | Speicher auf brandschutzsicherem Untergrund? | التخزين على سطح مقاوم للحريق؟
  options: yes, no
- inverterOnFireproofWall | radio | | Inverter on fireproof wall? | Wechselrichter auf brandschutzsicherer Wand? | العاكس على جدار مقاوم للحريق؟
  options: yes, no
- customerInformedTemperature | checkbox | | Customer informed: optimal operating temperature 15°–35°C | Kunde informiert: Betriebstemperatur 15°–35°C | تم إبلاغ العميل بدرجة الحرارة المثلى
- storageLocation | dropdown | | Storage location | Speicherstandort | موقع التخزين
  options: optimal, basement, garage, outdoor_protected, other
- distanceInverterToZk | number | | Distance WR/Storage → ZK (m) | Entfernung WR/Speicher → ZK (m) | المسافة من العاكس/التخزين إلى ZK (م)
- photosCableInverterToZk | multiphoto | | Photos cable route WR/Storage → ZK (lines in RED) | Fotos Kabelweg WR/Speicher → ZK (Linien ROT) | صور مسار الكابل من WR إلى ZK

## 6. Earthing | Erdung | التأريض

section_id: earthing

- mainEarthingPresent | radio | | Main earthing present? | Haupterdung vorhanden? | التأريض الرئيسي موجود؟
  options: yes, no
- photosEarthing | multiphoto | | Photos earthing (main point + potential rail + cable route to WR) | Fotos Erdung (Hauptpunkt + Potenzialschiene + Kabelweg zum WR) | صور التأريض
  min: 2
- distanceEarthingToStorage | number | | Distance earthing → storage (m) | Entfernung Erdung → Speicher (m) | المسافة من التأريض إلى التخزين (م)
- distanceEarthingToZk | number | | Distance earthing → ZK (m) | Entfernung Erdung → ZK (m) | المسافة من التأريض إلى ZK (م)

## 7. Internet Connection | Internetanschluss | اتصال الإنترنت

section_id: internet

- internetAvailable | radio | | Internet connection available? | Internetverbindung vorhanden? | اتصال الإنترنت متاح؟
  options: yes, no
- customerLaysCableThemselves | radio | | Customer lays cable themselves? | Kunde verlegt Leitung selbst? | العميل يمد الكابل بنفسه؟
  options: yes, no
  show_if: internetAvailable == yes
- distanceRouterToStorage | number | | Distance router → storage (m) | Entfernung Router → Speicher (m) | المسافة من الراوتر إلى التخزين (م)
  show_if: internetAvailable == yes
- photosInternetCableRoute | multiphoto | | Photos cable route router → WR/Storage + router type label | Fotos Leitungsweg Router → WR/Speicher + Typenschild Router | صور مسار الكابل + لوحة نوع الراوتر
  show_if: internetAvailable == yes
  min: 2

## 8. Wallbox | Wallbox | شاحن الحائط

section_id: wallbox
optional_section: true

- wallboxOrdered | radio | | Wallbox ordered through MAM Solarbau? | Wallbox bei MAM Solarbau beauftragt? | تم طلب الشاحن عبر MAM Solarbau؟
  options: yes, no
- photoWallboxLocation | photo | | Photo of wallbox location | Foto Montageort Wallbox | صورة موقع الشاحن
  show_if: wallboxOrdered == yes
- distanceWallboxToZk | number | | Distance wallbox → ZK (m) | Entfernung Wallbox → ZK (m) | المسافة من الشاحن إلى ZK (م)
  show_if: wallboxOrdered == yes
- photosWallboxCable | multiphoto | | Photos cable route wallbox | Fotos Kabelweg Wallbox | صور مسار كابل الشاحن
  show_if: wallboxOrdered == yes

## 9. Blackout Package | Blackout Paket | حزمة انقطاع الكهرباء

section_id: blackout
optional_section: true

- blackoutOrdered | radio | | Blackout package ordered through MAM Solarbau? | Blackoutpaket bei MAM Solarbau beauftragt? | تم طلب حزمة الانقطاع عبر MAM Solarbau؟
  options: yes, no
- photoNubLocation | photo | | Photo of NUB location | Foto Montageort NUB | صورة موقع NUB
  show_if: blackoutOrdered == yes
- photosNubCableRoute | multiphoto | | Photos cable route NUB → ZK | Fotos Kabelweg NUB → ZK | صور مسار كابل NUB
  show_if: blackoutOrdered == yes

## 10. Heat Pump | Wärmepumpe | المضخة الحرارية

section_id: heat_pump
optional_section: true

- heatPumpOrdered | radio | | Heat pump ordered through MAM Solarbau? | Wärmepumpe bei MAM Solarbau beauftragt? | تم طلب المضخة عبر MAM Solarbau؟
  options: yes, no
- photoHeatPumpLocation | photo | | Photo of heat pump location | Foto Montageort Wärmepumpe | صورة موقع المضخة
  show_if: heatPumpOrdered == yes
- distanceHeatPumpToZk | number | | Distance heat pump → ZK (m) | Entfernung Wärmepumpe → ZK (m) | المسافة من المضخة إلى ZK (م)
  show_if: heatPumpOrdered == yes
- heatPumpTechnicalData | textarea | | Technical data | Technische Daten | البيانات الفنية
  show_if: heatPumpOrdered == yes

## 11. Notes & Planning | Bemerkungen & Planung | الملاحظات والتخطيط

section_id: notes_planning

- dcAcSameRoute | radio | | DC and AC cable route the same? | Kabelweg DC und AC gleich? | مسار DC و AC نفسه؟
  options: yes, no
- customerCablingWish | dropdown | | Customer wants cabling in: | Leitungsverlegung in: | وضع الكابل في:
  options: cable_duct, surface_mounted, flush_mounted, conduit
- dcNotes | textarea | | DC remarks + cable route description | DC Bemerkungen + Kabelwegbeschreibung | ملاحظات DC ووصف المسار
- acNotes | textarea | | AC remarks + cable route description | AC Bemerkungen + Kabelwegbeschreibung | ملاحظات AC ووصف المسار
- organizationalNotes | textarea | | Material storage / Parking / Special access notes | Materiallager / Parkmöglichkeiten / Besonderheiten Anfahrt | تخزين المواد / مواقف / ملاحظات الوصول
- techRemarks | textarea | | Further remarks of survey technician | Weitere Anmerkungen des Aufmaßtechnikers | ملاحظات إضافية من فني المسح
- photosSpecial | multiphoto | | Optional photos of specifics | Optionale Fotos Besonderheiten | صور اختيارية للخصوصيات
- detailsRecorded | checkbox | | Survey technician has recorded all details and discussed them with customer | Alle Details eingetragen und mit Kunden besprochen | تم تسجيل جميع التفاصيل ومناقشتها مع العميل

## Additional Info | Zusätzliche Informationen | معلومات إضافية

section_id: additional_info
optional_section: true
repeatable: true
min: 0
max: 10

- note | textarea | | Note | Bemerkung | ملاحظة
- image | photo | | Image | Bild | صورة

---

## Signatures | Unterschriften | التوقيعات

section_id: signatures

- location | text | required | Location | Ort | الموقع
- customerFullName | text | required | First and Last Name | Vor- und Nachname | الاسم الكامل
- signatureDate | date | required | Date | Datum | التاريخ
- signatureTime | datetime | required | Time | Zeitpunkt | الوقت
  default: current_time
- customerSignature | signature | required | Customer/Representative Signature | Unterschrift des Kunden/Bevollmächtigten | توقيع العميل/الممثل
- techSignature | signature | | Survey Technician On-Site Signature | Unterschrift des Aufmaßtechnikers vor Ort | توقيع فني المسح في الموقع