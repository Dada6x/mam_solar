---
protocol: installation_report
title: Survey Protocol
title_de: Aufmaßprotokoll
title_ar: بروتوكول القياس
version: 2.0
company: MAM Solarbau
note: Rebuilt 1:1 from the BSH Aufmaßprotokoll PDF, adapted for MAM Solarbau. Conditional fields via show_if (Ja/Nein gates), repeatable roof surfaces and additional meters. Photo collections use multiphoto fields.
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- aufmasstechniker | text | required | On-site surveyor | Aufmaßtechniker vor Ort | فني القياس في الموقع
- customerName | text | required | Customer | Kunde | العميل
- street | text | required | Street | Straße | الشارع
- houseNumber | text | required | House number | Hausnummer | رقم المنزل
- zipCode | text | required | ZIP code | PLZ | الرمز البريدي
- montageort | text | required | Installation city | Montageort | مدينة التركيب
- email | email | required | Customer email address | E-Mail-Adresse des Kunden | البريد الإلكتروني للعميل
- phone | text | required | Customer phone (landline or mobile) | Telefonnummern des Kunden (Festnetz oder Mobil) | هاتف العميل (أرضي أو محمول)
- pvsNummer | text | | PVS number / order ID | PVS Nummer / Auftrags ID | رقم PVS / معرّف الطلب
- speicherart | text | | Storage type | Speicherart | نوع التخزين

## 1. Roof | 1. Dach | 1. السقف

section_id: roof

- photoHaus | photo | required | Photo of the house (entire property directly from above with drawing incl. equipment) (Yellow dot=storage, Blue dot=meter cabinet, Green dot=wallbox, Red dot=HAK, Brown dot=inverter if different from storage) | Bild vom Haus (Gesamtes Grundstück direkt von oben mit Zeichnung inkl. Betriebsmittel) (Gelber Punkt=Speicher, Blauer Punkt=ZK, Grüner Punkt=Wallbox, Roter Punkt=HAK, Brauner Punkt=WR falls abweichend zum Speicher) | صورة المنزل من الأعلى مع رسم يشمل التجهيزات
- dacheindeckung | dropdown | required | Roof covering | Dacheindeckung | تغطية السقف
  options: Ziegeleindeckung, Blecheindeckung, Sonstiges
- dacheindeckungSonstiges | text | | Roof covering (other - please specify) | Dacheindeckung (Sonstiges - bitte angeben) | تغطية السقف (أخرى - يرجى التحديد)
  show_if: dacheindeckung == Sonstiges
- geruestaufstellort | radio | | Scaffold setup location on sidewalk/street? | Gerüstaufstellort auf Gehweg/Straße? | موقع نصب السقالة على الرصيف/الشارع؟
  options: Ja, Nein
- geruestaufstellortHinweis | textarea | | Note on scaffold setup location | Hinweis zum Gerüstaufstellort | ملاحظة حول موقع نصب السقالة
  show_if: geruestaufstellort == Ja
- freileitungIsolieren | radio | | Insulate overhead line? | Freileitung isolieren? | عزل الخط الهوائي؟
  options: Ja, Nein
- blitzschutzVorhanden | radio | | External lightning protection present? | Äußerer Blitzschutz vorhanden? | هل توجد حماية خارجية من الصواعق؟
  options: Ja, Nein
- photoBlitzschutz | photo | | Photo of the external lightning protection | Bild des äußeren Blitzschutzes | صورة الحماية الخارجية من الصواعق
  show_if: blitzschutzVorhanden == Ja
- satSchuessel | radio | | SAT dish on an occupied roof area present? | SAT Schüssel auf belegter Dachfläche vorhanden? | هل يوجد طبق ساتلايت على سطح السقف المستخدم؟
  options: Ja, Nein
- photoSatSchuessel | photo | | Photo of the SAT dish | Bild der SAT Schüssel | صورة طبق الساتلايت
  show_if: satSchuessel == Ja

## Roof Surfaces | Dachflächen | أسطح السقف

section_id: roof_surfaces
repeatable: true
min: 1
max: 8

- gaubenVorhanden | radio | | Dormers present? | Gauben vorhanden? | هل توجد نوافذ سقفية؟
  options: Ja, Nein
- photoGauben | photo | | Photo of the dormers | Bild der Gauben | صورة النوافذ السقفية
  show_if: gaubenVorhanden == Ja
- photoDachflaeche | multiphoto | | Photo of the roof area from various angles with dimensions (min. rafter length) | Bild der Dachfläche aus verschiedenen Winkeln mit Bemaßung (mind. Sparrenlänge) | صورة سطح السقف من زوايا مختلفة مع الأبعاد
- photoTraufhoeheFront | photo | | Eaves height front view with dimensions | Traufhöhe Frontansicht mit Bemaßung | ارتفاع الإفريز من الأمام مع الأبعاد
- photoTraufhoeheLinks | photo | | Eaves height left | Traufhöhe links | ارتفاع الإفريز يسار
- photoTraufhoeheRechts | photo | | Eaves height right | Traufhöhe rechts | ارتفاع الإفريز يمين
- traufhoehe | text | | Eaves height (H1/H2) in m | Traufhöhe (H1/H2) in m | ارتفاع الإفريز (H1/H2) بالمتر
- photoTraufueberstand | photo | | Photo eaves overhang with folding rule | Bild Traufüberstand mit Zollstock | صورة بروز الإفريز مع المتر
- traufueberstand | number | | Eaves overhang in cm | Traufüberstand in cm | بروز الإفريز بالسنتيمتر
- photoFirst | photo | | Photo of the ridge | Bild des Firstes | صورة القمة
- photoDachunterseiteOrtgang | photo | | Photo of roof underside verge | Bild der Dachunterseite Ortgang | صورة الجانب السفلي للسقف عند الحافة
- dachueberstandOrtgang | number | | Roof overhang verge in cm | Dachüberstand Ortgang in cm | بروز السقف عند الحافة بالسنتيمتر
- blechtyp | dropdown | | Sheet type (sheet metal roof) | Blechtyp (bei Blecheindeckung) | نوع الصفيحة (سقف معدني)
  options: Trapezblech, Wellblech, Stehfalz, Sonstiges
- blechstaerke | number | | Sheet thickness in mm | Blechstärke in mm | سماكة الصفيحة بالمليمتر
- photoSickenhoehe | photo | | Photo of the corrugation height (with folding rule) | Bild der Sickenhöhe (mit Zollstock) | صورة ارتفاع التضليع
- photoSickenbreite | photo | | Photo of the corrugation width over 2 corrugations (with folding rule) | Bild der Sickenbreite über 2 Sicken (mit Zollstock) | صورة عرض التضليع فوق تضليعتين
- photoUeberlappung | photo | | Photo overlap of the sheets (from front) | Bild Überlappung der Bleche (von vorne) | صورة تداخل الصفائح من الأمام
- photoVerschraubung | photo | | Photo of the screw fixing | Bild der Verschraubung | صورة التثبيت بالبراغي
- photoDachflaecheInnen | multiphoto | | Photo of the roof area from inside | Bild Dachfläche von Innen | صورة سطح السقف من الداخل
- photoSparrenbreite | photo | | Rafter width with scale | Sparrenbreite mit Maßstab | عرض العارضة مع المقياس
- sparrenbreite | number | | Rafter width in cm | Sparrenbreite in cm | عرض العارضة بالسنتيمتر
- photoSparrenhoehe | photo | | Rafter height with scale | Sparrenhöhe mit Maßstab | ارتفاع العارضة مع المقياس
- sparrenhoehe | number | | Rafter height in cm | Sparrenhöhe in cm | ارتفاع العارضة بالسنتيمتر
- photoSparrenabstand | photo | | Rafter spacing with scale | Sparrenabstand mit Maßstab | تباعد العوارض مع المقياس
- sparrenabstand | number | | Rafter spacing in cm (center to center) | Sparrenabstand in cm (Mitte Mitte) | تباعد العوارض بالسنتيمتر (مركز لمركز)
- sichtsparren | radio | | Exposed rafters? | Sichtsparren? | عوارض ظاهرة؟
  options: Ja, Nein
- photoSichtsparren | multiphoto | | Photo of the exposed rafters | Bild des Sichtsparren | صورة العوارض الظاهرة
  show_if: sichtsparren == Ja
- aufdachdaemmung | radio | | On-roof insulation present (sandwich sheet)? | Aufdachdämmung vorhanden (Sandwichblech)? | هل يوجد عزل فوق السقف (صفيحة ساندويتش)؟
  options: Ja, Nein
- dachneigung | number | | Roof pitch (°) | Dachneigung (°) | ميل السقف (°)
- photoDachneigung | photo | | Photo of the roof pitch measurement | Bild der Messung Dachneigung | صورة قياس ميل السقف

## 2. DC Cable Route | 2. DC Kabelweg | 2. مسار كابل DC

section_id: dc_cable_route

- photoDcKabelweg | multiphoto | | Photos planned cable route from inverter/storage to PV modules (draw lines in blue, mark penetrations) | Bilder geplanter Kabelweg von Wechselrichter/Speicher zu PV Modulen (Leitungen in Blau einzeichnen, Durchbrüche kennzeichnen) | صور مسار الكابل المخطط من العاكس/المخزن إلى الألواح
- laengeKabelwegDc | number | required | Cable route length in m | Länge Kabelweg in m | طول مسار الكابل بالمتر

## 3. Electrical | 3. Elektro | 3. الكهرباء

section_id: electrical

- photoHak | photo | | Photo of the house connection box (opened, 1m distance) | Bild des Hausanschlusskastens (mit 1m Abstand geöffnet) | صورة صندوق التوصيل المنزلي مفتوحًا (مسافة 1م)
- absicherung | number | | Fuse rating | Absicherung | الحماية (أمبير)
- hakGehaeusematerial | dropdown | | HAK housing material | HAK Gehäusematerial | مادة هيكل صندوق التوصيل
  options: Metall, Nicht Metall
- hakOeffnenMoeglich | radio | | Opening the HAK without the energy provider possible? (key available) | Öffnen des HAK ohne Energieversorger möglich? (Schlüssel vorhanden) | هل يمكن فتح الصندوق بدون مزود الطاقة؟ (المفتاح متوفر)
  options: Ja, Nein
- hakOeffnenHinweis | textarea | | Note (HAK can only be opened by the energy provider) | Hinweis (HAK nur durch Energieversorger zu öffnen) | ملاحظة (لا يمكن فتح الصندوق إلا بواسطة المزود)
  show_if: hakOeffnenMoeglich == Nein
- photoPlombeHak | photo | | Photo new seal of HAK | Foto Plombe neu von HAK | صورة الختم الجديد للصندوق
- abstandZkHak | number | | Distance meter cabinet to HAK in m | Abstand Zählerkasten zum HAK in m | المسافة بين خزانة العداد والصندوق بالمتر
- photoWegZk | multiphoto | | Photo route to the meter cabinet | Bild Weg zum Zählerkasten | صورة الطريق إلى خزانة العداد
- photoZaehlerschrank | photo | | Photo of the meter cabinet (open all covers + 1m distance) | Bild des Zählerschranks (alle Abdeckungen öffnen + 1m Abstand) | صورة خزانة العداد (افتح كل الأغطية + مسافة 1م)
- photoZk | multiphoto | | Photos of the meter cabinet | Bilder ZK | صور خزانة العداد
- typenschildZk | radio | | Nameplate of the meter cabinet present? | Typenschild ZK vorhanden? | هل توجد لوحة بيانات لخزانة العداد؟
  options: Ja, Nein
- photoTypenschildZk | photo | | Photo of the existing nameplate | Bild des vorhandenen Typenschildes | صورة لوحة البيانات الموجودة
  show_if: typenschildZk == Ja
- photoPlombeZk | photo | | Photo new seal of the meter cabinet | Foto Plombe neu von ZK | صورة الختم الجديد لخزانة العداد
- photoHauptzaehler | photo | | Photo of the main meter (consumption meter on which the PV is connected) | Bild des Hauptzählers (Bezugszähler, auf dem die PV geklemmt wird) | صورة العداد الرئيسي
- zaehlernummerBezug | text | | Meter number of the consumption meter | Zählernummer Bezugszähler | رقم العداد الرئيسي
- zweckZaehler | text | | Purpose of the meter | Zweck des Zählers | الغرض من العداد
- zusaetzlicheZaehler | radio | | Are additional meters present? | Sind zusätzliche Zähler vorhanden? | هل توجد عدادات إضافية؟
  options: Ja, Nein
- anzahlZusaetzlicheZaehler | number | | How many additional meters are present? | Wieviele zusätzliche Zähler sind vorhanden? | كم عدد العدادات الإضافية؟
  show_if: zusaetzlicheZaehler == Ja
- andereEnergieerzeugung | radio | | Are other energy generation systems present? | Sind andere Energieerzeugunganlagen vorhanden? | هل توجد أنظمة توليد طاقة أخرى؟
  options: Ja, Nein
- photoAndereEnergieerzeugung | photo | | Photo of the other energy generation system | Bild der anderen Energieerzeugungsanlage | صورة نظام توليد الطاقة الآخر
  show_if: andereEnergieerzeugung == Ja
- photoMontageortOptionalerZk | photo | | Photo of the mounting location of the optional meter cabinet (room height min. 2.10m, wall width min. 1m, distance to next obstacle 1.50m, mounting on wood not possible) | Bild des Montageorts des optionalen Zählerschranks (Raumhöhe mind. 2,10m, Wandbreite mind. 1m, Abstand zum nächsten Hindernis 1,50m, Montage nicht auf Holz möglich) | صورة موقع تركيب خزانة العداد الاختيارية
- photoKabelwegHakOptionalerZk | multiphoto | | Photos of the possible cable route, HAK to optional meter cabinet | Bilder vom möglichen Kabelweg, HAK zum optionalen ZK | صور مسار الكابل المحتمل من الصندوق إلى الخزانة الاختيارية
- photoKabelwegZkBestandOptional | multiphoto | | Photos of the possible cable route, existing meter cabinet to optional meter cabinet | Bilder vom möglichen Kabelweg, ZK Bestand zum optionalen ZK | صور مسار الكابل من الخزانة الحالية إلى الاختيارية

## Additional Meters | Zusätzliche Zähler (Mehrfacherfassung) | عدادات إضافية

section_id: additional_meters
repeatable: true
min: 0
max: 20

- photoZusaetzlicherZaehler | photo | | Photo of the additional meter | Bild des zusätzlichen Zählers | صورة العداد الإضافي
- zaehlernummer | text | | Meter number | Zählernummer | رقم العداد
- zweck | text | | Purpose of the meter | Zweck des Zählers | الغرض من العداد
- zaehlerzusammenlegung | radio | | Meter consolidation? | Zählerzusammenlegung? | دمج العدادات؟
  options: Ja, Nein

## 4. Signal Measurement | 4. Pegelmessung | 4. قياس الإشارة

section_id: signal_measurement

- messwertTMobileBestand | number | | Reading T-Mobile (RSRP value in dBm) - existing ZK | Messwert T-Mobile (RSRP Wert in dBm) - ZK Bestand | قياس T-Mobile (الخزانة الحالية)
- messwertVodafoneBestand | number | | Reading Vodafone (RSRP value in dBm) - existing ZK | Messwert Vodafone (RSRP Wert in dBm) - ZK Bestand | قياس Vodafone (الخزانة الحالية)
- messwertTelefonicaBestand | number | | Reading Telefonica (RSRP value in dBm) - existing ZK | Messwert Telefonica (RSRP Wert in dBm) - ZK Bestand | قياس Telefonica (الخزانة الحالية)
- photoMessgeraetBestand | photo | | Photo measuring device readings - existing ZK | Foto Messgerät Messwerte - ZK Bestand | صورة جهاز القياس (الخزانة الحالية)
- photoAntenneBestand | photo | | Antenna placement (location of measurement and probable antenna installation) - existing ZK | Platzierung der Antenne (Standort der Messung und vermutlicher Einbau der Antenne) - ZK Bestand | موضع الهوائي (الخزانة الحالية)
- messwertTMobileOptional | number | | Reading T-Mobile (RSRP value in dBm) - optional ZK | Messwert T-Mobile (RSRP Wert in dBm) - ZK Optional | قياس T-Mobile (الخزانة الاختيارية)
- messwertVodafoneOptional | number | | Reading Vodafone (RSRP value in dBm) - optional ZK | Messwert Vodafone (RSRP Wert in dBm) - ZK Optional | قياس Vodafone (الخزانة الاختيارية)
- messwertTelefonicaOptional | number | | Reading Telefonica (RSRP value in dBm) - optional ZK | Messwert Telefonica (RSRP Wert in dBm) - ZK Optional | قياس Telefonica (الخزانة الاختيارية)
- photoMessgeraetOptional | photo | | Photo measuring device readings - optional ZK | Foto Messgerät Messwerte - ZK Optional | صورة جهاز القياس (الخزانة الاختيارية)
- photoAntenneOptional | photo | | Antenna placement - optional ZK | Platzierung der Antenne - ZK Optional | موضع الهوائي (الخزانة الاختيارية)

## 5. Storage / Inverter | 5. Speicher/Wechselrichter | 5. المخزن/العاكس

section_id: storage_inverter

- photoMontageortWr | multiphoto | | Photos of the mounting location inverter/storage with dimensions | Bilder des Montageorts Wechselrichter/Speicher mit Bemaßung | صور موقع تركيب العاكس/المخزن مع الأبعاد
- speicherBrandschutzUntergrund | radio | | Is the storage on a fire-safe surface? | Steht der Speicher auf brandschutzsicheren Untergrund? | هل المخزن على سطح آمن من الحريق؟
  options: Ja, Nein
- speicherUntergrundHinweis | textarea | | Note (storage surface not fire-safe) | Hinweis (Untergrund nicht brandschutzsicher) | ملاحظة (السطح غير آمن من الحريق)
  show_if: speicherBrandschutzUntergrund == Nein
- wrBrandschutzWand | radio | | Is the inverter mounted on a fire-safe wall? | Ist der Wechselrichter auf brandschutzsicherer Wand montiert? | هل العاكس مركّب على جدار آمن من الحريق؟
  options: Ja, Nein
- wrWandHinweis | textarea | | Note (wall not fire-safe) | Hinweis (Wand nicht brandschutzsicher) | ملاحظة (الجدار غير آمن من الحريق)
  show_if: wrBrandschutzWand == Nein
- kundeInformiertTemperatur | radio | | The customer was informed that the optimal operating temperature of the storage (inverter) should be between 15° and 35°. Depending on the storage manufacturer, outdoor placement in a weather-protected area is possible in exceptional cases. | Der Kunde wurde darüber informiert das die optimale Betriebstemperatur des Speichers (Wechselrichters) zwischen 15° und 35° liegen sollte. Je nach Speicherhersteller ist im Ausnahmefall ein Aufstellen im Außenbereich im wettergeschützten Bereich möglich. | تم إبلاغ العميل بدرجة حرارة التشغيل المثلى للمخزن
  options: Ja, Nein
- speicherstandort | dropdown | | Storage location | Speicherstandort | موقع المخزن
  options: Optimaler Standort, Suboptimaler Standort, Außenbereich (wettergeschützt)
- entfernungWrUv | number | | Distance of the inverter or storage to the sub-distribution/meter cabinet in meters | Entfernung des Wechselrichters oder Speichers zur Unterverteilung/Zählerkasten in Meter | المسافة بين العاكس/المخزن والتوزيع الفرعي بالمتر
- photoKabelwegWrUvBestand | multiphoto | | Photos planned cable route inverter/storage to existing sub-distribution/meter cabinet (draw lines in red, mark penetrations) | Bilder geplanter Kabelweg von Wechselrichter/Speicher zur Unterverteilung/Zählerkasten Bestand (Leitungen in Rot einzeichnen, Durchbrüche kennzeichnen) | صور مسار الكابل المخطط إلى التوزيع الحالي
- photoKabelwegWrUvOptional | multiphoto | | Photos planned cable route inverter/storage to optional sub-distribution/meter cabinet | Bilder geplanter Kabelweg von Wechselrichter/Speicher zur Unterverteilung/Zählerkasten optional | صور مسار الكابل المخطط إلى التوزيع الاختياري

## 6. Earthing | 6. Erdung | 6. التأريض

section_id: earthing

- haupterdungVorhanden | radio | | Main earthing present? | Haupterdung vorhanden? | هل يوجد تأريض رئيسي؟
  options: Ja, Nein
- haupterdungHinweis | textarea | | Note (no main earthing present - action required) | Hinweis (keine Haupterdung vorhanden - Handlungsbedarf) | ملاحظة (لا يوجد تأريض رئيسي)
  show_if: haupterdungVorhanden == Nein
- photoHaupterdung | photo | | Photo of the main earthing | Bild von der Haupterdung | صورة التأريض الرئيسي
  show_if: haupterdungVorhanden == Ja
- photoPotenzialschiene | photo | | Photo of the potential rail | Bild der Potenzialschiene | صورة قضيب الجهد
- entfernungErdungSpeicher | number | | Distance earthing to storage in m | Entfernung Erdung zum Speicher in m | المسافة من التأريض إلى المخزن بالمتر
- entfernungErdungZkBestand | number | | Distance earthing to existing meter cabinet in m | Entfernung Erdung zum ZK Bestand in m | المسافة من التأريض إلى الخزانة الحالية بالمتر
- entfernungErdungZkOptional | number | | Distance earthing to optional meter cabinet in m | Entfernung Erdung zum ZK optional in m | المسافة من التأريض إلى الخزانة الاختيارية بالمتر
- photoKabelwegErdungWr | multiphoto | | Photos of the planned cable route main earthing to inverter/storage | Bilder des geplanten Kabelwegs Haupterdung zum Wechselrichter/Speicher | صور مسار الكابل المخطط للتأريض إلى العاكس/المخزن

## 7. Internet Connection | 7. Internetanschluss | 7. اتصال الإنترنت

section_id: internet

- internetverbindungVorhanden | radio | | Is there generally an internet connection? | Besteht grundsätzlich eine Internetverbindung? | هل يوجد اتصال إنترنت أساسًا؟
  options: Ja, Nein
- internetHinweis | textarea | | Note (no internet connection - clarify with customer) | Hinweis (keine Internetverbindung - mit Kunde klären) | ملاحظة (لا يوجد اتصال إنترنت)
  show_if: internetverbindungVorhanden == Nein
- kundeLegtLeitung | radio | | Does the customer lay the cable himself? | Legt der Kunde die Leitung selbst? | هل يقوم العميل بمد الكابل بنفسه؟
  options: Ja, Nein
- entfernungRouterSpeicher | number | | Distance to the storage (system) in m | Entfernung zum Speicher (Anlage) in m | المسافة إلى المخزن بالمتر
  show_if: kundeLegtLeitung == Nein
- photoLeitungswegRouter | multiphoto | | Photos planned cable route from router to inverter/storage | Bilder geplanter Leitungsweg von Router zum Wechselrichter/Speicher | صور مسار الكابل من الراوتر إلى العاكس/المخزن
  show_if: kundeLegtLeitung == Nein
- photoTypenschildRouter | photo | | Photo of the router's nameplate | Bild vom Typenschild des Routers | صورة لوحة بيانات الراوتر

## 8. Wallbox | 8. Wallbox | 8. شاحن جداري

section_id: wallbox

- wallboxBeauftragt | radio | required | Is a wallbox commissioned with MAM Solarbau? | Ist eine Wallbox bei der Firma MAM Solarbau beauftragt? | هل تم التعاقد على شاحن جداري مع MAM Solarbau؟
  options: Ja, Nein
- photoWallboxMontageort | multiphoto | | Photos of the wallbox mounting location | Bilder des Montageorts der Wallbox | صور موقع تركيب الشاحن الجداري
  show_if: wallboxBeauftragt == Ja
- photoWallboxKabelweg | multiphoto | | Photos of the cable route to the wallbox | Bilder des Kabelwegs zur Wallbox | صور مسار الكابل إلى الشاحن الجداري
  show_if: wallboxBeauftragt == Ja
- entfernungWallbox | number | | Distance wallbox to meter cabinet in m | Entfernung Wallbox zum Zählerkasten in m | المسافة بين الشاحن وخزانة العداد بالمتر
  show_if: wallboxBeauftragt == Ja

## 9. Blackout Package | 9. Blackout Paket | 9. حزمة الطوارئ

section_id: blackout

- blackoutBeauftragt | radio | required | Is a blackout package commissioned with MAM Solarbau? | Ist ein Blackoutpaket bei der Firma MAM Solarbau beauftragt? | هل تم التعاقد على حزمة الطوارئ مع MAM Solarbau؟
  options: Ja, Nein
- photoMontageortNub | photo | | Photo of the mounting location of the NUB | Bild des Montageorts des NUB | صورة موقع تركيب NUB
  show_if: blackoutBeauftragt == Ja
- photoKabelwegNubZk | multiphoto | | Photos cable route NUB to meter cabinet | Bilder Kabelweg NUB zum ZK | صور مسار الكابل من NUB إلى الخزانة
  show_if: blackoutBeauftragt == Ja

## 10. Organizational | 10. Organisatorisches | 10. تنظيمي

section_id: organizational
repeatable: true
min: 0
max: 10

- materiallagerplatz | text | | Material storage / parking / special features for access | Materiallagerplatz/Parkmöglichkeiten/Besonderheiten zur Anfahrt | مكان تخزين المواد/مواقف/خصائص الوصول
- photoOrganisatorisch | photo | | Photo | Foto | صورة

## 11. Special Features / Internal Planning | 11. Besonderheiten/interne Planung | 11. خصائص/تخطيط داخلي

section_id: special_planning

- bemerkungenDc | textarea | | Remarks on the DC installation | Bemerkungen zur DC Installation | ملاحظات حول تركيب DC
- beschreibungKabelwegDc | textarea | | Description cable route DC | Beschreibung Kabelweg DC | وصف مسار كابل DC
- sonstigeAnmerkungenDc | textarea | | Other remarks DC, hard to explain via images | Sonstige Anmerkungen DC, die über Bilder schlecht zu erklären sind | ملاحظات أخرى DC يصعب شرحها بالصور
- bemerkungenAc | textarea | | Remarks on the AC installation | Bemerkungen zur AC Installation | ملاحظات حول تركيب AC
- beschreibungKabelwegAc | textarea | | Description cable route AC | Beschreibung Kabelweg AC | وصف مسار كابل AC
- sonstigeAnmerkungenAc | textarea | | Other remarks AC, hard to explain via images | Sonstige Anmerkungen AC, die über Bilder schlecht zu erklären sind | ملاحظات أخرى AC يصعب شرحها بالصور
- kabelwegDcAcGleich | radio | | Cable route DC and AC the same? | Kabelweg DC und AC gleich? | هل مسار كابل DC و AC متطابق؟
  options: Ja, Nein
- leitungsverlegung | dropdown | | Customer wishes cable laying in: | Kunde wünscht Leitungsverlegung in: | يرغب العميل في تمديد الكابلات في:
  options: Kabelkanal, Unterputz, Aufputz, Sonstiges
- weitereAnmerkungen | textarea | | Further remarks of the surveyor | Weitere Anmerkungen des Aufmaßtechnikers | ملاحظات إضافية لفني القياس
- photoBesonderheiten | multiphoto | | Optional photos of the special features | Optional Bilder der Besonderheiten | صور اختيارية للخصائص

## 12. Heat Pump | 12. Wärmepumpe | 12. مضخة حرارية

section_id: heat_pump

- waermepumpeBeauftragt | radio | required | Did the customer commission a heat pump through MAM Solarbau? | Hat der Kunde eine Wärmepumpe über die Firma MAM Solarbau beauftragt? | هل تعاقد العميل على مضخة حرارية مع MAM Solarbau؟
  options: Ja, Nein
- photoWaermepumpe | multiphoto | | Photos of the heat pump location | Bilder des Standorts der Wärmepumpe | صور موقع المضخة الحرارية
  show_if: waermepumpeBeauftragt == Ja

---

## 13. Completion of the Survey Protocol | 13. Abschluss des Aufmaßprotokolles | 13. إنهاء بروتوكول القياس

section_id: completion

- alleDetailsEingetragen | checkbox | required | The surveyor has carefully entered all details in the protocol, discussed and explained them with the customer. | Der Aufmaßtechniker hat alle Details im Protokoll sorgfältig eingetragen, mit dem Kunden besprochen und erklärt. | أدخل فني القياس جميع التفاصيل بعناية وناقشها مع العميل
- customerSignature | signature | required | Customer / representative signature | Unterschrift des Kunden/Bevollmächtigten | توقيع العميل/الممثل
- customerFullName | text | required | First and last name | Vor- und Nachname | الاسم الكامل
- ort | text | required | Location | Ort | المكان
- datum | date | required | Date | Datum | التاريخ
- zeitpunkt | datetime | | Timestamp | Zeitpunkt | الوقت
- aufmasstechnikerSignature | signature | required | On-site surveyor signature | Unterschrift des Aufmaßtechnikers vor Ort | توقيع فني القياس في الموقع
- versendeteEmail | email | | Sent email | Versendete E-Mail | البريد الإلكتروني المُرسل
