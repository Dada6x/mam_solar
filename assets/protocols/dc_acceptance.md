---
protocol: dc_acceptance
title: DC Acceptance Protocol
title_de: DC-Abnahmeprotokoll
title_ar: بروتوكول قبول التيار المستمر
version: 2.0
company: MAM Solarbau
note: Rebuilt 1:1 from the BSH DC acceptance protocol, adapted for MAM Solarbau. All Ja/Nein gates show conditional follow-up photos or notes (show_if), same pattern as the AC protocol.
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
  options: Ja, Nein
- foremanIntroducedHinweis | textarea | | Note (why did the foreman not introduce himself?) | Hinweis (warum hat sich der Vorarbeiter nicht vorgestellt?) | ملاحظة (لماذا لم يقدّم المشرف نفسه؟)
  show_if: foremanIntroduced == Nein
- shoeCoversWorn | radio | | Were shoe covers worn? | Wurden Schuhüberzieher getragen? | هل تم ارتداء أغطية الأحذية؟
  options: Ja, Nein
- shoeCoversHinweis | textarea | | Note (why were no shoe covers worn?) | Hinweis (warum keine Schuhüberzieher?) | ملاحظة (لماذا لم تُرتدَ أغطية الأحذية؟)
  show_if: shoeCoversWorn == Nein
- guestTowelGifted | radio | | Was the guest towel hung up and a new one gifted after completion? | Wurde das Gästehandtuch aufgehängt und nach Fertigstellung ein neues geschenkt? | هل تم تعليق منشفة الضيوف وإهداء واحدة جديدة بعد الانتهاء؟
  options: Ja, Nein
- doormatGifted | radio | | Did the customer receive the doormat? | Hat der Kunde die Fußmatte erhalten? | هل استلم العميل دواسة الباب؟
  options: Ja, Nein
- photoTowelDoormat | photo | | Photo of towel and doormat | Bild des Handtuchs und der Fußmatte | صورة المنشفة ودواسة الباب
  show_if: guestTowelGifted == Ja

## 1. Scaffold | 1. Gerüst | 1. السقالة

section_id: scaffold

- suitableScaffoldUsed | radio | | A suitable scaffold was used for the installation | Ein geeignetes Gerüst wurde zur Montage verwendet | تم استخدام سقالة مناسبة للتركيب
  options: Ja, Nein
- scaffoldNotUsedHinweis | textarea | | Note (why no suitable scaffold?) | Hinweis (warum kein geeignetes Gerüst?) | ملاحظة (لماذا لا توجد سقالة مناسبة؟)
  show_if: suitableScaffoldUsed == Nein
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
  options: Mängelfrei, Mit Mängeln
- defectsDescription | textarea | required | Description of defects | Beschreibung der Mängel | وصف العيوب
  show_if: acceptanceResult == Mit Mängeln
- defectsPhotos | multiphoto | | Photos of defects | Fotos der Mängel | صور العيوب
  show_if: acceptanceResult == Mit Mängeln

## 3. Installation Documentation | 3. Montagedokumentation | 3. توثيق التركيب

section_id: installation_documentation

- systemType | radio | required | System type | Anlagentyp | نوع النظام
  options: PV ohne Speicher, PV mit Speicher
- senecStorage | dropdown | | Select the storage | Bitte den Speicher auswählen | اختر المخزن
  options: Senec Home P4, Senec Home E4, Senec Home V3, EcoFlow, Sonstiges
  show_if: systemType == PV mit Speicher
- moduleCount | number | required | Number of modules | Anzahl der Module | عدد الألواح
- moduleManufacturer | text | | Module manufacturer and type | Modul Hersteller und Typ | الشركة المصنعة للألواح والنوع
- moduleLabel | text | | Module label | Modulbezeichnung | تسمية اللوح
- nominalPowerKwp | number | required | Nominal system power (kWp) | Nennleistung der Anlage in kWp | القدرة الاسمية للنظام (kWp)
- photoModuleLabel | photo | | Photo of module nameplate | Bild des Typenschild der Module | صورة لوحة بيانات اللوح
- preexistingDamage | radio | required | Is there pre-existing damage? | Gibt es Vorschäden? | هل توجد أضرار مسبقة؟
  options: Ja, Nein
- preexistingDamageDescription | textarea | | Describe the pre-existing damage | Beschreibung der Vorschäden | وصف الأضرار المسبقة
  show_if: preexistingDamage == Ja
- preexistingDamagePhotos | multiphoto | | Photos of pre-existing damage | Fotos der Vorschäden | صور الأضرار المسبقة
  show_if: preexistingDamage == Ja
- roofType | dropdown | required | Roof type | Um was für ein Dachtyp handelt es sich | ما هو نوع السقف
  options: Ziegel, Blech, Trapezblech, Flachdach, Sonstiges
- roofTypeSonstiges | text | | Roof type (other - please specify) | Dachtyp (Sonstiges - bitte angeben) | نوع السقف (أخرى - يرجى التحديد)
  show_if: roofType == Sonstiges

## Tiles & Substructure | Ziegel & Unterkonstruktion | القرميد والبنية التحتية

section_id: tiles_substructure

- tilesProcessedCorrectly | radio | | The tiles were processed correctly with an angle grinder | Die Ziegel wurden richtig mit Winkelschleifer bearbeitet | تمت معالجة القرميد بشكل صحيح بمطحنة الزاوية
  options: Ja, Nein
  show_if: roofType == Ziegel
- fixingPointsPerDoc | radio | | Fixing points installed according to module documentation | Befestigungspunkte nach Moduldokumentation angebracht | تم تركيب نقاط التثبيت وفقًا لوثائق اللوح
  options: Ja, Nein
  show_if: roofType == Ziegel

## 3a. Roof Surface Documentation | 3a. Dachflächen-Dokumentation | 3a. توثيق سطح السقف

section_id: roof_surface_docs
repeatable: true
min: 1
max: 4

- photoFinishedSubstructure | multiphoto | | Photos finished roof with fixing points / substructure (photograph all sides) | Bilder fertiges Dach mit Befestigungspunkten / Unterkonstruktion (alle Seiten fotografieren) | صور السقف النهائي مع نقاط التثبيت
- safetyDistanceKept | radio | | Safety distance between hook and tile (top and bottom) was maintained | Sicherheitsabstand zwischen Haken und Ziegel oben und unten wurde eingehalten | تم الحفاظ على مسافة الأمان بين الخطاف والقرميد
  options: Ja, Nein
- photoSafetyDistance | photo | | Photo safety distance hook/tile | Bild Sicherheitsabstand zw. Haken und Ziegel | صورة مسافة الأمان
  show_if: safetyDistanceKept == Ja
- cablesFixedToRail | radio | | Cables and connectors fixed to the rail with cable ties (no contact with roof) | Kabel und Stecker wurden mit Kabelbinder an der Schiene befestigt (keine Berührung mit Dach) | تم تثبيت الكابلات بربطات على القضيب
  options: Ja, Nein
- photoCableFixing | photo | | Photo of cable and connector fixing | Bild der Befestigung Kabel und Stecker | صورة تثبيت الكابلات
- substructureEarthed | radio | | Earthing of the substructure was carried out (fixed to roof hook base) | Erdung der Unterkonstruktion wurde durchgeführt (an Dachhakenfuß befestigt) | تم تأريض البنية التحتية
  options: Ja, Nein
- photoEarthingUk | photo | | Photo earthing substructure (clamp + bridges) | Bild der Erdung UK (Erdungsklemme + Erdungsbrücken) | صورة تأريض البنية التحتية
- photoAluPerforatedTape | photo | | Photo Alu perforated tape | Bild Alu-Lochband | صورة شريط الألمنيوم المثقب
- photoPotentialRail | photo | | Photo of potential equalization rail | Bild der Potentialausgleichsschiene | صورة قضيب معادلة الجهد
- railsEarthed | radio | | Earthing of the rails (Alu perforated tape for potential bonding) carried out | Erdung der Schienen (Alu Lochband zur Potentialverbindung) durchgeführt | تم تأريض القضبان
  options: Ja, Nein
- cableEntrySealed | radio | | Cable entry into the roof skin correctly sealed with sealing tape or grommet | Kabeleinführung in die Dachhaut wurde korrekt mit Klebedichtband oder Manschette abgedichtet | تم إحكام إدخال الكابل في السقف
  options: Ja, Nein
- photoSealing | photo | | Photo sealing / roofing membrane penetration | Bild Abdichtung/Durchführung Untersparrenbahn | صورة الإحكام
- photoCableEntryTile | photo | | Photo cable entry under tile with mechanical protection | Bild Kabeleinführung unter der Ziegel mit mechanischem Schutz | صورة إدخال الكابل تحت القرميد

## Flat Vents | Flachlüfter | فتحات التهوية المسطحة

section_id: flat_vents

- flatVentsInstalled | radio | required | Were flat vents installed? | Wurde/n Flachlüfter verbaut? | هل تم تركيب فتحات تهوية مسطحة؟
  options: Ja, Nein
- photoFlatVents | multiphoto | | Photos of flat vents | Fotos der Flachlüfter | صور فتحات التهوية
  show_if: flatVentsInstalled == Ja

## 4. Modules | 4. Module | 4. الألواح

section_id: modules

- moduleSurfacesCount | number | required | How many module surfaces are there | Wieviele Modulflächen gibt es | كم عدد أسطح الألواح
- externalInverters | radio | required | Were external inverters installed? | Wurden externe Wechselrichter verbaut? | هل تم تركيب عاكسات خارجية؟
  options: Ja, Nein
- photoExternalInverters | multiphoto | | Photos of external inverters | Fotos externe Wechselrichter | صور العاكسات الخارجية
  show_if: externalInverters == Ja

## Module Surface Documentation | Modulflächen-Dokumentation | توثيق سطح الألواح

section_id: module_surface_docs
repeatable: true
min: 1
max: 4

- photoFinishedModuleSurface | photo | | Photo finished module surface | Bild fertige Modulfläche | صورة سطح الألواح النهائي
- photoStringPlan | photo | | Photo of the string plan | Bild des Stringplans | صورة مخطط السلسلة
- stringPlanMarked | radio | | String plan is marked with + and - | Stringplan ist mit + und - gekennzeichnet | مخطط السلسلة معلّم بـ + و -
  options: Ja, Nein
- stringPlanMatchesLayout | radio | | Is the string plan identical to the roof layout? | Ist der Stringplan identisch mit der Dachbelegung? | هل مخطط السلسلة مطابق لتوزيع السقف؟
  options: Ja, Nein
- stringPlanDeviationNote | textarea | | Note (describe the deviation from the roof layout) | Hinweis (Abweichung zur Dachbelegung beschreiben) | ملاحظة (وصف الاختلاف عن توزيع السقف)
  show_if: stringPlanMatchesLayout == Nein
- photoWiringDrawing | photo | | Photo of module surface with wiring drawn in | Bild der Modulfläche mit eingezeichneter Verschaltung | صورة سطح الألواح مع رسم التوصيل
- photoModuleUnderside | photo | | Photo module underside (no hanging cables) | Bild der Modulflächen Unterseite (keine herunterhängenden Kabel) | صورة الجانب السفلي للألواح

## 5. Cable Routing | 5. Kabelverlegung | 5. مسار الكابلات

section_id: cable_routing

- cableRoutedThrough | dropdown | required | How were the cables routed? | Wodurch wurden die Kabel verlegt? | كيف تم توجيه الكابلات؟
  options: Fassade, Innen, Kabelkanal, Sonstiges
- cableRoutedOther | text | | Cable routing (other - please specify) | Kabelverlegung (Sonstiges - bitte angeben) | توجيه الكابلات (أخرى - يرجى التحديد)
  show_if: cableRoutedThrough == Sonstiges
- photoCableRouting | photo | | Photo of the cable routing | Bild der Kabelverlegung | صورة توجيه الكابلات
- cableUnderTiles | radio | | Cable route outside the module field always under the tiles | Kabelweg außerhalb des Modulfelds stets unter den Ziegeln | مسار الكابل خارج حقل الألواح دائمًا تحت القرميد
  options: Ja, Nein
- wallBreakthrough | radio | required | External routing with wall breakthrough? | Außenverlegung mit Wanddurchbruch? | تمرير خارجي باختراق الجدار؟
  options: Ja, Nein
- photoSealedBreakthrough | photo | | Photo of the sealed breakthrough | Bild des abgedichteten Durchbruchs | صورة الاختراق المُحكم
  show_if: wallBreakthrough == Ja
- breakthroughSealed | radio | | External routing: drilled from outside upwards, sealed with well foam or 2K expansion resin | Außenverlegung: Bohrung von außen schräg nach oben, mit Brunnenschaum oder 2K-Expansionsharz abgedichtet | تم إحكام الاختراق
  options: Ja, Nein
  show_if: wallBreakthrough == Ja
- vaporBarrierSealed | radio | | All penetrations through vapor barrier (roof, walls) sealed with prescribed sealants | Sämtliche Durchführungen durch Dampfbremsfolie mit vorgeschriebenen Dichtstoffen abgedichtet | تم إحكام جميع الاختراقات عبر حاجز البخار
  options: Ja, Nein
- photosDcRouteOutside | multiphoto | required | Photos of the entire DC cable route outside (min. 2) | Bilder des gesamten DC-Kabelweges Außenbereich (min. 2) | صور مسار كابل DC الخارجي (٢ على الأقل)
- photosDcRouteInside | multiphoto | required | Photos of the entire DC cable route inside (min. 2) | Bilder des gesamten DC-Kabelweges Innenbereich (min. 2) | صور مسار كابل DC الداخلي (٢ على الأقل)

## 6. DC Surge Protection | 6. DC-ÜSS | 6. حماية الجهد الزائد DC

section_id: dc_surge_protection

- surgeProtectionNeeded | radio | required | Surge protection needed? | Überspannungsschutz benötigt? | هل حماية الجهد الزائد مطلوبة؟
  options: Nein (V3/V4 oder Kaco), Ja
- photoSurgeProtection | photo | | Photo of the installed surge protection | Bild des verbauten Überspannungsschutzes | صورة حماية الجهد الزائد المركبة
  show_if: surgeProtectionNeeded == Ja

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
  options: Ja, Nein
- photosGutter | multiphoto | | Photos of the gutters | Bilder der Dachrinnen | صور المزاريب
  show_if: gutterCleaned == Ja
- gutterNotCleanedHinweis | textarea | | Note (why was the gutter not cleaned?) | Hinweis (warum wurde die Dachrinne nicht gereinigt?) | ملاحظة (لماذا لم يُنظَّف المزراب؟)
  show_if: gutterCleaned == Nein

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
