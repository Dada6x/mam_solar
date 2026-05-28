---
protocol: installation_report
title: Site Survey Protocol (Aufmass)
title_de: Aufmassprotokoll
title_ar: بروتوكول المسح الموقعي
version: 3.0
company: MAM Solarbau
note: Comprehensive on-site survey for PV system planning (roof, electrical, cable routes, storage)
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- surveyTechnician | text | required | Survey Technician On-Site | Aufmaßtechniker vor Ort | فني المسح في الموقع
- customerName | text | required | Customer Name | Kunde | اسم العميل
- street | text | required | Street | Straße | الشارع
- houseNumber | text | required  | House Number | Hausnummer | رقم المنزل
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

### Overview | Übersicht | نظرة عامة

- photoOverview | photo | | Aerial overview photo with drawing including equipment (Yellow=Storage, Blue=ZK, Green=Wallbox, Red=HAK, Brown=WR if different from storage) | Bild vom Haus (Gesamtes Grundstück von oben mit Zeichnung inkl. Betriebsmittel)(Gelb=Speicher,Blau=ZK,Grün=Wallbox,Rot=HAK,Braun=WR falls abweichend zum Speicher) | صورة جوية مع رسم لجميع المعدات (أصفر=التخزين، أزرق=ZK، أخضر=Wallbox، أحمر=HAK، بني=WR إن اختلف)
- roofCovering | dropdown | | Roof Covering | Dacheindeckung | تغطية السقف
  options: tile, sheet_metal, slate, bitumen, other

---

### Tile Roof Details | Ziegeldach Details | تفاصيل سقف القرميد

- scaffoldOnSidewalk | radio | | Scaffold location on sidewalk/street? | Gerüstaufstellort auf Gehweg/Straße? | موقع السقالة على الرصيف/الشارع؟
  options: yes, no
- isolateOverheadLine | radio | | Isolate overhead line? | Freileitung isolieren? | عزل الخط الكهربائي العلوي؟
  options: yes, no
- externalLightning | radio | | External lightning protection present? | Äußerer Blitzschutz vorhanden? | حماية البرق الخارجية موجودة؟
  options: yes, no
- satDishPresent | radio | | SAT dish on roof area to be used? | SAT Schüssel auf belegter Dachfläche vorhanden? | طبق SAT على منطقة السقف المستخدمة؟
  options: yes, no
- mustMoveSatDish | radio | | Must SAT dish be moved for installation? | Muss SAT Schüssel für Installation versetzt werden? | يجب نقل طبق SAT للتركيب؟
  options: yes, no
  show_if: satDishPresent == yes
- newSatDishLocation | text | | Where to move SAT dish | Wohin soll die SAT Schüssel versetzt werden | إلى أين سيتم نقل طبق SAT
  show_if: mustMoveSatDish == yes
- photoNewSatDishLocation | photo | | Photo of new SAT location | Neuer Standort SAT Schüssel | صورة الموقع الجديد لـ SAT
  show_if: mustMoveSatDish == yes

---

### Roof Surfaces | Dachflächen | أسطح السقف

- roofSurfaces | repeatable | | Roof Surfaces | Dachflächen | أسطح السقف
  min: 1
  max: 4
  <!-- TODO what surface -->
  fields:
  - dormersPresent | radio | | Dormers present? | Gauben vorhanden? | نوافذ علوية موجودة؟
    options: yes, no
  - photosRoofAngles | multiphoto | | Photos of roof from different angles | Bilder der Dachfläche aus verschiedenen Winkeln | صور للسقف من زوايا مختلفة
    min: 3
  - photoEaveFront | photo | | Eave height front view with dimensions | Traufhöhe Frontansicht mit Bemaßung | ارتفاع الإفريز من الأمام مع الأبعاد
  - photoEaveLeft | photo | | Eave height left | Traufhöhe links | ارتفاع الإفريز الأيسر
  - photoEaveRight | photo | | Eave height right | Traufhöhe rechts | ارتفاع الإفريز الأيمن
  - eaveHeightMeters | number | | Eave height (H1/H2) in m | Traufhöhe (H1/H2) in m | ارتفاع الإفريز (H1/H2) بالمتر
  - photoEaveOverhang | photo | | Eave overhang with folding rule | Bild Traufüberstand mit Zollstock | بروز الإفريز مع مسطرة الطي
  - eaveOverhangCm | number | | Eave overhang in cm | Traufüberstand in cm | بروز الإفريز بالسم
  - ridgeTilesMortared | radio | | Ridge tiles mortared? | Firstziegel vermörtelt? | قرميد القمة مثبت بالملاط؟
    options: yes, no
  - photoUndersideVerge | photo | | Photo of roof underside / verge | Bild der Dachunterseite Ortgang | صورة الجانب السفلي للسقف
  - vergeOverhangCm | number | | Verge overhang in cm | Dachüberstand Ortgang in cm | بروز الحافة بالسم
  - photosRoofInside | multiphoto | | Photos of roof from inside | Bild Dachfläche von Innen | صور للسقف من الداخل
    min: 3
  - photoRafterWidth | photo | | Rafter width with scale | Sparrenbreite mit Maßstab | عرض العارضة مع مقياس
  - rafterWidthCm | number | | Rafter width in cm | Sparrenbreite in cm | عرض العارضة بالسم
  - photoRafterHeight | photo | | Rafter height with scale | Sparrenhöhe mit Maßstab | ارتفاع العارضة مع مقياس
  - rafterHeightCm | number | | Rafter height in cm | Sparrenhöhe in cm | ارتفاع العارضة بالسم
  - photoRafterDistance | photo | | Rafter distance with scale | Sparrenabstand mit Maßstab | المسافة بين العوارض مع مقياس
  - rafterDistanceCm | number | | Rafter distance in cm (center to center) | Sparrenabstand in cm (Mitte zu Mitte) | المسافة بين العوارض بالسم (مركز إلى مركز)
  - visibleRafters | radio | | Visible rafters? | Sichtsparren? | عوارض مرئية؟
    options: yes, no
  - aboveRoofInsulation | radio | | Above-roof insulation? | Aufdachdämmung vorhanden? | عزل فوق السقف؟
    options: yes, no
  - feltPlugs | radio | | Felt plugs? | Pappdocken? | سدادات اللباد؟
    options: yes, no
  - roofPitchDegrees | number | | Roof pitch (°) | Dachneigung (°) | ميل السقف (°)
  - photoRoofPitch | photo | | Photo of pitch measurement | Bild der Messung Dachneigung | صورة قياس الميل
  - tileType | dropdown | | Tile Type | Ziegeltyp | نوع القرميد
    options: concrete_tile, clay_tile, other
  - photoTileTop | photo | | Photo tile from top | Bild der Ziegel von oben | صورة القرميد من الأعلى
  - photoTileBottom | photo | | Photo tile from bottom | Bild der Ziegel von unten | صورة القرميد من الأسفل
  - photoTileHeight | photo | | Tile cover height with rule | Deckhöhe mit Zollstock | ارتفاع تغطية القرميد مع المسطرة
  - tileHeightCm | number | | Cover height in cm | Deckhöhe in cm | ارتفاع التغطية بالسم
  - photoTileWidth | photo | | Tile cover width with rule | Deckbreite mit Zollstock | عرض تغطية القرميد مع المسطرة
  - tileWidthCm | number | | Cover width in cm | Deckbreite in cm | عرض التغطية بالسم
  - hasReplacementTiles | radio | | Does customer have replacement tiles? | Hat der Kunde Ersatzziegel? | هل العميل لديه قرميد بديل؟
    options: yes, no
  - customerInformedAboutTiles | checkbox | | Customer informed that min. 20 replacement tiles are needed | Kunde wurde darauf hingewiesen, dass min. 20 Ersatzziegel benötigt werden | تم إبلاغ العميل بالحاجة إلى 20 قرميدًا بديلًا على الأقل
  - tilesScrewedOrClamped | radio | | Tiles screwed or clamped? | Sind die Ziegel geschraubt oder geklammert? | هل القرميد مثبت بالبراغي أم بالمشابك؟
    options: yes, no

## 2. DC Cable Route | DC Kabelweg | مسار كابل DC

section_id: dc_cable_route

- photoDcCableRoute | multiphoto | | Photos of planned cable route from inverter/storage to PV modules (lines in BLUE, mark breakthroughs) | Bilder geplanter Kabelweg von Wechselrichter/Speicher zu PV Modulen (Leitungen in BLAU, Durchbrüche kennzeichnen) | صور لمسار الكابل المخطط من العاكس/التخزين إلى وحدات PV (الخطوط باللون الأزرق، حدد الفتحات)
  min: 2
- dcCableLengthMeters | number | | Cable length in m | Länge Kabelweg in m | طول الكابل بالمتر

## 3. Electrical | Elektro | الكهرباء

section_id: electrical

### HAK (House Connection Box) | Hausanschlusskasten | صندوق توصيل المنزل

- photoHak | multiphoto | | Photo HAK opened (1m distance) | Bild des Hausanschlusskastens geöffnet (1m Abstand) | صورة HAK مفتوحة (مسافة 1م)
- hakFuseAmps | number | | Fuse (Amps) | Absicherung | المنصهر (أمبير)
- hakHousingMaterial | dropdown | | HAK Housing Material | HAK Gehäusematerial | مادة هيكل HAK
  options: metal, non_metal
- hakOpenableWithoutProvider | radio | | HAK openable without energy provider (key available)? | Öffnen des HAK ohne Energieversorger möglich? (Schlüssel vorhanden) | هل يمكن فتح HAK بدون مزود الطاقة؟
  options: yes, no
- photoHakSealNew | photo | | Photo of new HAK seal | Foto Plombe neu von HAK | صورة الختم الجديد لـ HAK
- distanceMeterToHak | number | | Distance meter cabinet to HAK in m | Abstand Zählerkasten zum HAK in m | المسافة من خزانة العداد إلى HAK بالمتر

### Way to Meter Cabinet | Weg zum Zählerkasten | الطريق إلى خزانة العداد

- photosWayToMeter | multiphoto | | Photos way to meter cabinet | Bilder Weg zum Zählerkasten | صور الطريق إلى خزانة العداد

### Meter Cabinet (Existing) | Zählerschrank Bestand | خزانة العداد الموجودة

- photoMeterCabinet | photo | | Photo of meter cabinet (all covers open + 1m distance) | Bild des Zählerschranks (alle Abdeckungen öffnen + 1m Abstand) | صورة خزانة العداد (جميع الأغطية مفتوحة + مسافة 1م)
- photosZkDetails | multiphoto | | Detail photos of ZK | Bilder ZK | صور تفصيلية لـ ZK
- typeLabelPresent | radio | | Type label present? | Typenschild ZK vorhanden? | لوحة النوع موجودة؟
  options: yes, no
- photoTypeLabel | photo | | Photo of type label | Bild des vorhandenen Typenschildes | صورة لوحة النوع
  show_if: typeLabelPresent == yes
- photoZkSealNew | photo | | Photo of new ZK seal | Foto Plombe neu von ZK | صورة الختم الجديد لـ ZK

### Main Meter | Hauptzähler | العداد الرئيسي

- photoMainMeter | photo | | Photo of main meter (where PV will be clamped) | Bild des Hauptzählers (Bezugszähler, auf dem die PV geklemmt wird) | صورة العداد الرئيسي
- mainMeterNumber | text | | Main meter number | Zählernummer Bezugszähler | رقم العداد الرئيسي
- mainMeterPurpose | text | | Purpose of meter | Zweck des Zählers | الغرض من العداد

### Additional Meters | Zusätzliche Zähler | عدادات إضافية

- additionalMetersPresent | radio | | Additional meters present? | Sind zusätzliche Zähler vorhanden? | هل توجد عدادات إضافية؟
  options: yes, no
- additionalMetersCount | number | | How many additional meters? | Wieviele zusätzliche Zähler? | كم عدد العدادات الإضافية؟
  show_if: additionalMetersPresent == yes
- additionalMeters | repeatable | | Additional Meters | Zusätzliche Zähler | عدادات إضافية
  show_if: additionalMetersPresent == yes
  min: 1
  fields:
  - photoMeter | photo | | Photo of meter | Bild des zusätzlichen Zählers | صورة العداد
  - meterNumber | text | | Meter number | Zählernummer | رقم العداد
  - meterPurpose | text | | Purpose (e.g. 1.OG, Heat Pump) | Zweck des Zählers (z.B. 1.OG, Wärmepumpe) | الغرض

### Consolidation & Other Systems

- meterConsolidation | radio | | Meter consolidation needed? | Zählerzusammenlegung? | دمج العدادات؟
  options: yes, no
- otherEnergySystems | radio | | Other energy generation systems present? | Sind andere Energieerzeugungsanlagen vorhanden? | هل توجد أنظمة توليد طاقة أخرى؟
  options: yes, no

### Optional Meter Cabinet | Optionaler Zählerschrank | خزانة العداد الاختيارية

- photoOptionalZkLocation | photo | | Photo of optional ZK location (room height min. 2.10m, wall width min. 1m, 1.50m distance to obstacles, no wood) | Bild des Montageorts des optionalen Zählerschranks (Raumhöhe mind. 2,10m, Wandbreite mind. 1m, Abstand zum nächsten Hindernis 1,50m, nicht auf Holz) | صورة موقع ZK الاختياري
- photosCableHakToOptionalZk | multiphoto | | Photos cable route HAK → optional ZK | Bilder Kabelweg HAK zum optionalen ZK | صور مسار الكابل HAK إلى ZK الاختياري
- photosCableExistingZkToOptionalZk | multiphoto | | Photos cable route existing ZK → optional ZK | Bilder Kabelweg ZK Bestand zu ZK optional | صور مسار الكابل من ZK الموجود إلى ZK الاختياري

## 4. Signal Measurement | Pegelmessung | قياس الإشارة

section_id: signal_measurement

### Existing ZK Location | ZK Bestand | موقع ZK الموجود

- signalTMobileExisting | number | | T-Mobile Signal (RSRP in dBm) | Messwert T-Mobile (RSRP in dBm) | إشارة T-Mobile (RSRP بـ dBm)
- signalVodafoneExisting | number | | Vodafone Signal (RSRP in dBm) | Messwert Vodafone (RSRP in dBm) | إشارة Vodafone (RSRP بـ dBm)
- signalTelefonicaExisting | number | | Telefonica Signal (RSRP in dBm) | Messwert Telefonica (RSRP in dBm) | إشارة Telefonica (RSRP بـ dBm)
- photoMeterDeviceExisting | photo | | Photo measurement device | Foto Messgerät Messwerte | صورة جهاز القياس
- photoAntennaPlacementExisting | photo | | Photo antenna placement | Platzierung der Antenne | صورة وضع الهوائي

### Optional ZK Location | ZK Optional | موقع ZK الاختياري

- signalTMobileOptional | number | | T-Mobile Signal (RSRP in dBm) | Messwert T-Mobile (RSRP in dBm) | إشارة T-Mobile
- signalVodafoneOptional | number | | Vodafone Signal (RSRP in dBm) | Messwert Vodafone (RSRP in dBm) | إشارة Vodafone
- signalTelefonicaOptional | number | | Telefonica Signal (RSRP in dBm) | Messwert Telefonica (RSRP in dBm) | إشارة Telefonica
- photoMeterDeviceOptional | photo | | Photo measurement device | Foto Messgerät Messwerte | صورة جهاز القياس
- photoAntennaPlacementOptional | photo | | Photo antenna placement | Platzierung der Antenne | صورة وضع الهوائي

## 5. Storage / Inverter | Speicher / Wechselrichter | التخزين / العاكس

section_id: storage_inverter

- photosInstallLocation | multiphoto | | Photos of storage/inverter location with dimensions (H/B) | Bilder des Montageorts mit Bemaßung (H/B) | صور موقع التركيب مع الأبعاد
  min: 2
- storageOnFireproofSurface | radio | | Storage on fireproof surface? | Speicher auf brandschutzsicherem Untergrund? | التخزين على سطح مقاوم للحريق؟
  options: yes, no
- inverterOnFireproofWall | radio | | Inverter on fireproof wall? | Wechselrichter auf brandschutzsicherer Wand? | العاكس على جدار مقاوم للحريق؟
  options: yes, no
- customerInformedTemperature | checkbox | | Customer informed that optimal operating temperature is between 15°-35°C | Kunde informiert: optimale Betriebstemperatur 15°-35° | تم إبلاغ العميل بدرجة الحرارة المثلى 15-35
- storageLocation | dropdown | | Storage location | Speicherstandort | موقع التخزين
  options: optimal, basement, garage, outdoor_protected, other
- distanceInverterToZk | number | | Distance inverter/storage to sub-distribution/ZK in m | Entfernung WR/Speicher zum ZK in m | المسافة من العاكس/التخزين إلى ZK
- photosCableInverterToExistingZk | multiphoto | | Photos planned cable route WR/Storage → existing ZK (lines in RED) | Bilder Kabelweg WR/Speicher zum ZK Bestand (Linien in ROT) | صور مسار الكابل من WR/التخزين إلى ZK الموجود
- photosCableInverterToOptionalZk | multiphoto | | Photos planned cable route WR/Storage → optional ZK | Bilder Kabelweg WR/Speicher zum ZK optional | صور مسار الكابل من WR/التخزين إلى ZK الاختياري

## 6. Earthing | Erdung | التأريض

section_id: earthing

- mainEarthingPresent | radio | | Main earthing present? | Haupterdung vorhanden? | التأريض الرئيسي موجود؟
  options: yes, no
- photoMainEarthing | photo | | Photo of main earthing | Bild von der Haupterdung | صورة التأريض الرئيسي
- photoPotentialRail | photo | | Photo of potential rail | Bild der Potenzialschiene | صورة قضيب الجهد
- distanceEarthingToStorage | number | | Distance earthing to storage in m | Entfernung Erdung zum Speicher in m | المسافة من التأريض إلى التخزين
- distanceEarthingToExistingZk | number | | Distance earthing to existing ZK in m | Entfernung Erdung zum ZK Bestand in m | المسافة من التأريض إلى ZK الموجود
- distanceEarthingToOptionalZk | number | | Distance earthing to optional ZK in m | Entfernung Erdung zum ZK optional in m | المسافة من التأريض إلى ZK الاختياري
- photosEarthingCableRoute | multiphoto | | Photos planned cable route earthing → WR/Storage | Bilder Kabelweg Haupterdung zum WR/Speicher | صور مسار كابل التأريض

## 7. Internet Connection | Internetanschluss | اتصال الإنترنت

section_id: internet

- internetAvailable | radio | | Internet connection available? | Internetverbindung vorhanden? | اتصال الإنترنت متاح؟
  options: yes, no
- customerLaysCableThemselves | radio | | Customer lays the cable themselves? | Legt der Kunde die Leitung selbst? | هل سيقوم العميل بمد الكابل بنفسه؟
  options: yes, no
  show_if: internetAvailable == yes
- distanceRouterToStorage | number | | Distance router to storage in m | Entfernung Router zum Speicher in m | المسافة من الراوتر إلى التخزين
  show_if: internetAvailable == yes
- photosRouterCableRoute | multiphoto | | Photos planned cable route router → WR/Storage | Bilder Leitungsweg Router zum WR/Speicher | صور مسار الكابل من الراوتر
  show_if: internetAvailable == yes
- photoRouterTypeLabel | photo | | Photo of router type label | Bild Typenschild des Routers | صورة لوحة نوع الراوتر
  show_if: internetAvailable == yes

## 8. Wallbox | Wallbox | شاحن الحائط

section_id: wallbox
optional_section: true

- wallboxOrdered | radio | | Wallbox ordered through MAM Solarbau? | Wallbox bei MAM Solarbau beauftragt? | تم طلب الشاحن عبر MAM Solarbau؟
  options: yes, no
- photoWallboxLocation | photo | | Photo of wallbox location | Bild des Montageorts der Wallbox | صورة موقع الشاحن
  show_if: wallboxOrdered == yes
- distanceWallboxToZk | number | | Distance wallbox to ZK in m | Entfernung Wallbox zum ZK in m | المسافة من الشاحن إلى ZK
  show_if: wallboxOrdered == yes
- photosWallboxCable | multiphoto | | Photos cable route wallbox | Bilder Kabelweg Wallbox | صور مسار كابل الشاحن
  show_if: wallboxOrdered == yes

## 9. Blackout Package | Blackout Paket | حزمة انقطاع الكهرباء

section_id: blackout
optional_section: true

- blackoutOrdered | radio | | Blackout package ordered through MAM Solarbau? | Blackoutpaket bei MAM Solarbau beauftragt? | تم طلب حزمة الانقطاع عبر MAM Solarbau؟
  options: yes, no
- photoNubLocation | photo | | Photo of NUB location | Bild des Montageorts des NUB | صورة موقع NUB
  show_if: blackoutOrdered == yes
- photosNubCableRoute | multiphoto | | Photos cable route NUB → ZK | Bilder Kabelweg NUB zum ZK | صور مسار كابل NUB
  show_if: blackoutOrdered == yes

## 10. Organizational | Organisatorisches | تنظيمي

section_id: organizational

- organizational | repeatable | | Organizational entries | Organisatorische Einträge | المداخل التنظيمية
  min: 1
  max: 5
  fields:
  - notes | text | | Material storage / Parking / Special access notes | Materiallagerplatz/Parkmöglichkeiten/Besonderheiten zur Anfahrt | تخزين المواد / مواقف السيارات / ملاحظات الوصول
  - photo | photo | | Photo | Foto | صورة

## 11. Special Notes / Internal Planning | Besonderheiten / Interne Planung | ملاحظات خاصة / تخطيط داخلي

section_id: special_notes

### DC Installation

- dcRemarks | textarea | | Remarks DC Installation | Bemerkungen zur DC Installation | ملاحظات حول تركيب DC
- dcCableDescription | textarea | | Description DC cable route | Beschreibung Kabelweg DC | وصف مسار كابل DC
- dcOtherRemarks | textarea | | Other remarks DC (hard to explain with pictures) | Sonstige Anmerkungen DC | ملاحظات أخرى DC

### AC Installation

- acRemarks | textarea | | Remarks AC Installation | Bemerkungen zur AC Installation | ملاحظات حول تركيب AC
- acCableDescription | textarea | | Description AC cable route | Beschreibung Kabelweg AC | وصف مسار كابل AC
- acOtherRemarks | textarea | | Other remarks AC | Sonstige Anmerkungen AC | ملاحظات أخرى AC

### Other

- dcAcSameRoute | radio | | DC and AC cable route the same? | Kabelweg DC und AC gleich? | مسار كابل DC و AC نفسه؟
  options: yes, no
- customerCablingWish | dropdown | | Customer wants cabling in: | Kunde wünscht Leitungsverlegung in: | يرغب العميل في وضع الكابل في:
  options: cable_duct, surface_mounted, flush_mounted, conduit
- techRemarks | textarea | | Further remarks of survey technician | Weitere Anmerkungen des Aufmaßtechnikers | ملاحظات إضافية من فني المسح
- photosSpecial | multiphoto | | Optional photos of specifics | Optional Bilder der Besonderheiten | صور اختيارية للخصوصيات

## 12. Heat Pump | Wärmepumpe | المضخة الحرارية

section_id: heat_pump
optional_section: true

- heatPumpOrdered | radio | | Heat pump ordered through MAM Solarbau? | Wärmepumpe bei MAM Solarbau beauftragt? | تم طلب المضخة الحرارية عبر MAM Solarbau؟
  options: yes, no
- photoHeatPumpLocation | photo | | Photo of heat pump location | Bild des Montageorts der Wärmepumpe | صورة موقع المضخة الحرارية
  show_if: heatPumpOrdered == yes
- distanceHeatPumpToZk | number | | Distance heat pump to ZK in m | Entfernung Wärmepumpe zum ZK in m | المسافة من المضخة إلى ZK
  show_if: heatPumpOrdered == yes
- heatPumpTechnicalData | textarea | | Technical data | Technische Daten | البيانات الفنية
  show_if: heatPumpOrdered == yes

## 13. Final Acceptance | Abschluss des Aufmaßprotokolles | إكمال البروتوكول

section_id: final_acceptance

- detailsRecorded | checkbox | | Survey technician has recorded all details and discussed them with customer | Der Aufmaßtechniker hat alle Details sorgfältig eingetragen und mit dem Kunden besprochen | قام فني المسح بتسجيل جميع التفاصيل ومناقشتها مع العميل


## Additional Info | Zusätzliche Informationen | معلومات إضافية

section_id: additional_info
optional_section: true
repeatable: true
min: 0
max: 10

- note | textarea | | Note | Bemerkung | ملاحظة
- image | photo | | Image | Bild | صورة


### Customer Signature

- customerSignature | signature | required | Customer/Representative Signature | Unterschrift des Kunden/Bevollmächtigten | توقيع العميل/الممثل
- customerFullName | text | required | First and Last Name | Vor- und Nachname | الاسم الكامل
- signatureLocation | text | required | Location | Ort | الموقع
- signatureDate | date | required | Date | Datum | التاريخ
- signatureTime | datetime | required | Time | Zeitpunkt | الوقت
  default: current_time

### Survey Technician Signature

- techSignature | signature | | Survey Technician On-Site Signature | Unterschrift des Aufmaßtechnikers vor Ort | توقيع فني المسح في الموقع
