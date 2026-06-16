---
protocol: dc_acceptance
title: DC Acceptance Protocol
title_de: DC-Abnahmeprotokoll
title_ar: بروتوكول قبول التيار المستمر
version: 1.0
company: MAM Solarbau
note: Rebuilt 1:1 from the BSH DC acceptance protocol, adapted for MAM Solarbau with conditional (show_if) fields.
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- installationDate | datetime | required | Installation Date & Time | Montagetermin Datum + Uhrzeit | تاريخ ووقت التركيب
- foreman | text | required | Foreman / Partner on Site | Vorarbeiter/Partner vor Ort | المشرف/الشريك في الموقع
- customerName | text | required | Customer | Kunde | العميل
- street | text | required | Street | Straße | الشارع
- houseNumber | text | required | House Number | Hausnummer | رقم المنزل
- zipCode | text | required | ZIP Code | PLZ | الرمز البريدي
- installationCity | text | required | Installation City | Montageort | مدينة التركيب
- email | email | required | Customer Email | E-Mail-Adresse des Kunden | البريد الإلكتروني للعميل

- foremanIntroduced | radio | | Did the foreman introduce himself by name? | Hat sich der Vorarbeiter vor Ort namentlich vorgestellt? | هل قدّم المشرف نفسه بالاسم؟
  options: yes, no
- shoeCoversWorn | radio | | Were shoe covers worn? | Wurden Schuhüberzieher getragen? | هل تم ارتداء أغطية الأحذية؟
  options: yes, no
- guestTowelGifted | radio | | Was the BSH guest towel hung up and a new one gifted after completion? | Wurde das Gästehandtuch aufgehängt und nach Fertigstellung ein neues geschenkt? | هل تم تعليق منشفة الضيوف وإهداء واحدة جديدة بعد الانتهاء؟
  options: yes, no
- doormatGifted | radio | | Did the customer receive the doormat? | Hat der Kunde die Fußmatte erhalten? | هل استلم العميل دواسة الباب؟
  options: yes, no
- photoTowelDoormat | photo | | Photo of towel and doormat | Bild des Handtuchs und der Fußmatte | صورة المنشفة ودواسة الباب

## 1. Scaffold | 1. Gerüst | 1. السقالة

section_id: scaffold

- suitableScaffoldUsed | checkbox | | A suitable scaffold was used for the installation | Ein geeignetes Gerüst wurde zur Montage verwendet | تم استخدام سقالة مناسبة للتركيب
- roofSurfacesCount | number | required | How many roof surfaces were used | Wieviele Dachflächen wurden belegt | كم عدد أسطح السقف المستخدمة
- scaffoldType | text | | Which scaffold was used? | Welches Gerüst wurde verwendet? | أي سقالة تم استخدامها؟

## Scaffold Photos | Gerüstfotos | صور السقالة

section_id: scaffold_photos
repeatable: true
min: 1
max: 8

- scaffoldPhotoFront | photo | | Scaffold side frontal | Gerüstseite Frontal | جانب السقالة من الأمام
- scaffoldPhotoTop | photo | | Scaffold side from above (full width) | Gerüstseite von oben (ganze Breite) | جانب السقالة من الأعلى (بالعرض الكامل)

## 2. Acceptance | 2. Abnahmeprotokoll | 2. محضر القبول

section_id: acceptance

- acceptanceResult | radio | required | The acceptance is | Die Abnahme erfolgt | يتم القبول
  options: defect_free, with_defects
- defectsDescription | textarea | required | Description of defects | Beschreibung der Mängel | وصف العيوب
  show_if: acceptanceResult == with_defects
- defectsPhotos | multiphoto | | Photos of defects | Fotos der Mängel | صور العيوب
  show_if: acceptanceResult == with_defects

## 3. Installation Documentation | 3. Montagedokumentation | 3. توثيق التركيب

section_id: installation_documentation

- systemType | radio | required | System type | Anlagentyp | نوع النظام
  options: pv_only, pv_with_storage
- senecStorage | dropdown | | Select the Senec storage | Bitte den Senec Speicher auswählen | اختر مخزن Senec
  options: senec_home_p4, senec_home_e4, senec_home_v3, other
  show_if: systemType == pv_with_storage
- moduleCount | number | required | Number of modules | Anzahl der Module | عدد الألواح
- moduleManufacturer | text | | Module manufacturer and type | Modul Hersteller und Typ | الشركة المصنعة للألواح والنوع
- moduleLabel | text | | Module label | Modulbezeichnung | تسمية اللوح
- nominalPowerKwp | number | required | Nominal system power (kWp) | Nennleistung der Anlage in kWp | القدرة الاسمية للنظام (kWp)
- photoModuleLabel | photo | | Photo of module nameplate | Bild des Typenschild der Module | صورة لوحة بيانات اللوح
- preexistingDamage | radio | required | Is there pre-existing damage? | Gibt es Vorschäden? | هل توجد أضرار مسبقة؟
  options: yes, no
- preexistingDamageDescription | textarea | | Describe the pre-existing damage | Beschreibung der Vorschäden | وصف الأضرار المسبقة
  show_if: preexistingDamage == yes
- preexistingDamagePhotos | multiphoto | | Photos of pre-existing damage | Fotos der Vorschäden | صور الأضرار المسبقة
  show_if: preexistingDamage == yes
- roofType | dropdown | required | Roof type | Um was für ein Dachtyp handelt es sich | ما هو نوع السقف
  options: tile, sheet_metal, trapezoidal, flat_roof, other

## Tiles & Substructure | Ziegel & Unterkonstruktion | القرميد والبنية التحتية

section_id: tiles_substructure

- tilesProcessedCorrectly | checkbox | | The tiles were processed correctly with an angle grinder | Die Ziegel wurden richtig mit Winkelschleifer bearbeitet | تمت معالجة القرميد بشكل صحيح بمطحنة الزاوية
  show_if: roofType == tile
- fixingPointsPerDoc | checkbox | | Fixing points installed according to module documentation | Befestigungspunkte nach Moduldokumentation angebracht | تم تركيب نقاط التثبيت وفقًا لوثائق اللوح
  show_if: roofType == tile

## 3a. Roof Surface Documentation | 3a. Dachflächen-Dokumentation | 3a. توثيق سطح السقف

section_id: roof_surface_docs
repeatable: true
min: 1
max: 4

- photoFinishedSubstructure | multiphoto | | Photos finished roof with fixing points / substructure (photograph all sides) | Bilder fertiges Dach mit Befestigungspunkten / Unterkonstruktion (alle Seiten fotografieren) | صور السقف النهائي مع نقاط التثبيت
- safetyDistanceKept | checkbox | | Safety distance between hook and tile (top and bottom) was maintained | Sicherheitsabstand zwischen Haken und Ziegel oben und unten wurde eingehalten | تم الحفاظ على مسافة الأمان بين الخطاف والقرميد
- photoSafetyDistance | photo | | Photo safety distance hook/tile | Bild Sicherheitsabstand zw. Haken und Ziegel | صورة مسافة الأمان
- cablesFixedToRail | checkbox | | Cables and connectors fixed to the rail with cable ties (no contact with roof) | Kabel und Stecker wurden mit Kabelbinder an der Schiene befestigt (keine Berührung mit Dach) | تم تثبيت الكابلات بربطات على القضيب
- photoCableFixing | photo | | Photo of cable and connector fixing | Bild der Befestigung Kabel und Stecker | صورة تثبيت الكابلات
- substructureEarthed | checkbox | | Earthing of the substructure was carried out (fixed to roof hook base) | Erdung der Unterkonstruktion wurde durchgeführt (an Dachhakenfuß befestigt) | تم تأريض البنية التحتية
- photoEarthingUk | photo | | Photo earthing substructure (clamp + bridges) | Bild der Erdung UK (Erdungsklemme + Erdungsbrücken) | صورة تأريض البنية التحتية
- photoAluPerforatedTape | photo | | Photo Alu perforated tape | Bild Alu-Lochband | صورة شريط الألمنيوم المثقب
- photoPotentialRail | photo | | Photo of potential equalization rail | Bild der Potentialausgleichsschiene | صورة قضيب معادلة الجهد
- railsEarthed | checkbox | | Earthing of the rails (Alu perforated tape for potential bonding) carried out | Erdung der Schienen (Alu Lochband zur Potentialverbindung) durchgeführt | تم تأريض القضبان
- cableEntrySealed | checkbox | | Cable entry into the roof skin correctly sealed with sealing tape or grommet | Kabeleinführung in die Dachhaut wurde korrekt mit Klebedichtband oder Manschette abgedichtet | تم إحكام إدخال الكابل في السقف
- photoSealing | photo | | Photo sealing / roofing membrane penetration | Bild Abdichtung/Durchführung Untersparrenbahn | صورة الإحكام
- photoCableEntryTile | photo | | Photo cable entry under tile with mechanical protection | Bild Kabeleinführung unter der Ziegel mit mechanischem Schutz | صورة إدخال الكابل تحت القرميد

## Flat Vents | Flachlüfter | فتحات التهوية المسطحة

section_id: flat_vents

- flatVentsInstalled | radio | required | Were flat vents installed? | Wurde/n Flachlüfter verbaut? | هل تم تركيب فتحات تهوية مسطحة؟
  options: yes, no
- photoFlatVents | multiphoto | | Photos of flat vents | Fotos der Flachlüfter | صور فتحات التهوية
  show_if: flatVentsInstalled == yes

## 4. Modules | 4. Module | 4. الألواح

section_id: modules

- moduleSurfacesCount | number | required | How many module surfaces are there | Wieviele Modulflächen gibt es | كم عدد أسطح الألواح
- externalInverters | radio | required | Were external inverters installed? | Wurden externe Wechselrichter verbaut? | هل تم تركيب عاكسات خارجية؟
  options: yes, no
- photoExternalInverters | multiphoto | | Photos of external inverters | Fotos externe Wechselrichter | صور العاكسات الخارجية
  show_if: externalInverters == yes

## Module Surface Documentation | Modulflächen-Dokumentation | توثيق سطح الألواح

section_id: module_surface_docs
repeatable: true
min: 1
max: 4

- photoFinishedModuleSurface | photo | | Photo finished module surface | Bild fertige Modulfläche | صورة سطح الألواح النهائي
- photoStringPlan | photo | | Photo of the string plan | Bild des Stringplans | صورة مخطط السلسلة
- stringPlanMarked | checkbox | | String plan is marked with + and - | Stringplan ist mit + und - gekennzeichnet | مخطط السلسلة معلّم بـ + و -
- stringPlanMatchesLayout | radio | | Is the string plan identical to the roof layout? | Ist der Stringplan identisch mit der Dachbelegung? | هل مخطط السلسلة مطابق لتوزيع السقف؟
  options: yes, no
- photoWiringDrawing | photo | | Photo of module surface with wiring drawn in | Bild der Modulfläche mit eingezeichneter Verschaltung | صورة سطح الألواح مع رسم التوصيل
- photoModuleUnderside | photo | | Photo module underside (no hanging cables) | Bild der Modulflächen Unterseite (keine herunterhängenden Kabel) | صورة الجانب السفلي للألواح

## 5. Cable Routing | 5. Kabelverlegung | 5. مسار الكابلات

section_id: cable_routing

- cableRoutedThrough | dropdown | required | How were the cables routed? | Wodurch wurden die Kabel verlegt? | كيف تم توجيه الكابلات؟
  options: facade, inside, cable_duct, other
- photoCableRouting | photo | | Photo of the cable routing | Bild der Kabelverlegung | صورة توجيه الكابلات
- cableUnderTiles | radio | | Cable route outside the module field always under the tiles | Kabelweg außerhalb des Modulfelds stets unter den Ziegeln | مسار الكابل خارج حقل الألواح دائمًا تحت القرميد
  options: yes, no
- wallBreakthrough | radio | required | External routing with wall breakthrough? | Außenverlegung mit Wanddurchbruch? | تمرير خارجي باختراق الجدار؟
  options: yes, no
- photoSealedBreakthrough | photo | | Photo of the sealed breakthrough | Bild des abgedichteten Durchbruchs | صورة الاختراق المُحكم
  show_if: wallBreakthrough == yes
- breakthroughSealed | checkbox | | External routing: drilled from outside upwards, sealed with well foam or 2K expansion resin | Außenverlegung: Bohrung von außen schräg nach oben, mit Brunnenschaum oder 2K-Expansionsharz abgedichtet | تم إحكام الاختراق
  show_if: wallBreakthrough == yes
- vaporBarrierSealed | radio | | All penetrations through vapor barrier (roof, walls) sealed with prescribed sealants | Sämtliche Durchführungen durch Dampfbremsfolie mit vorgeschriebenen Dichtstoffen abgedichtet | تم إحكام جميع الاختراقات عبر حاجز البخار
  options: yes, no
- photosDcRouteOutside | multiphoto | required | Photos of the entire DC cable route outside (min. 2) | Bilder des gesamten DC-Kabelweges Außenbereich (min. 2) | صور مسار كابل DC الخارجي (٢ على الأقل)
- photosDcRouteInside | multiphoto | required | Photos of the entire DC cable route inside (min. 2) | Bilder des gesamten DC-Kabelweges Innenbereich (min. 2) | صور مسار كابل DC الداخلي (٢ على الأقل)

## 6. DC Surge Protection | 6. DC-ÜSS | 6. حماية الجهد الزائد DC

section_id: dc_surge_protection

- surgeProtectionNeeded | radio | required | Surge protection needed? | Überspannungsschutz benötigt? | هل حماية الجهد الزائد مطلوبة؟
  options: no_v3_v4_kaco, yes
- photoSurgeProtection | photo | | Photo of the installed surge protection | Bild des verbauten Überspannungsschutzes | صورة حماية الجهد الزائد المركبة
  show_if: surgeProtectionNeeded == yes

## 7. DC Measurements | 7. Messungen DC | 7. قياسات DC

section_id: dc_measurements

- stringCount | number | required | Number of strings | Anzahl der Strings | عدد السلاسل
- photoDcConnectionsInverter | photo | | Photo of connected DC lines at inverter and storage | Bild angeschlossener DC-Leitungen am Wechselrichter und am Speicher | صورة خطوط DC الموصولة بالعاكس والمخزن

## String Measurements | String-Messungen | قياسات السلسلة

section_id: string_measurements
repeatable: true
min: 1
max: 30

- photoMeasurement | photo | | Measurement result Benning PV 1.1 / PV 2 (mode "Auto") | Messresultat Benning PV 1.1 / PV 2 Messung "Auto" | نتيجة القياس
- stringNumberAndValue | text | | String number and measured value | Stringnummer und Messwert | رقم السلسلة والقيمة المقاسة

## 8. Completion | 8. Abschluss | 8. الإكمال

section_id: completion

- allDetailsRecorded | checkbox | required | The foreman/PV partner carefully recorded all details, discussed and explained them with the customer. The system is operationally accepted and released for invoicing. | Der Vorarbeiter/Partner PV hat alle Details sorgfältig eingetragen, mit dem Kunden besprochen und erklärt. Die Anlage ist betriebsfertig abgenommen und zur Rechnungsstellung freigegeben. | تم تسجيل جميع التفاصيل ومناقشتها مع العميل
- gutterCleaned | radio | required | Was the gutter cleaned? | Wurde die Dachrinne gereinigt? | هل تم تنظيف المزراب؟
  options: yes, no
- photosGutter | multiphoto | | Photos of the gutters | Bilder der Dachrinnen | صور المزاريب
  show_if: gutterCleaned == yes

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
- completionDateTime | datetime | required | Date / Time | Zeitpunkt | التاريخ / الوقت
  default: current_time
- noticePeriod | display_text | | The objection period is 14 days; after expiry the acceptance protocol is deemed confirmed. | Die Widerspruchsfrist beträgt 14 Tage, nach Ablauf der Frist gilt das Abnahmeprotokoll als bestätigt. | فترة الاعتراض ١٤ يومًا
- customerFullName | text | required | First and Last Name (Customer) | Vor- und Nachname (Kunde) | الاسم الكامل (العميل)
- customerSignature | signature | required | Customer / Representative Signature | Unterschrift des Kunden/Bevollmächtigten | توقيع العميل/الممثل
- foremanSignature | signature | required | Foreman On-Site Signature | Unterschrift des Vorarbeiters vor Ort | توقيع المشرف في الموقع
- emailSentTo | email | | Sent email | Versendete E-Mail | البريد الإلكتروني المُرسل
