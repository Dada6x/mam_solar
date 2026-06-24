---
protocol: ac_acceptance
title: AC Acceptance Protocol
title_de: AC-Abnahmeprotokoll
title_ar: بروتوكول قبول التيار المتردد
version: 6.0
company: MAM Solarbau
note: Rebuilt 1:1 from the BSH AC acceptance protocol (PDFs + smapOne fill-out screenshots). Conditional fields via show_if. Nested repeatables flattened (Batterieturm -> Akkumodule via per-item OR-gated slots).
---

## Customer Data | Kundendaten | بيانات العميل

section_id: customer_data

- einsatzart | radio | required | Type of deployment | Einsatzart | نوع التشغيل
  options: Photovoltaikanlage mit Speicher, Photovoltaikanlage ohne Speicher
- herstellerSpeicher | dropdown | | Storage manufacturer | Hersteller Speicher | الشركة المصنعة للتخزين
  options: EcoFlow Stromspeicher, Senec, Sonstiges
  show_if: einsatzart == Photovoltaikanlage mit Speicher
- wallboxInstalliert | radio | required | Wallbox installed? | Wallbox installiert? | هل تم تركيب الشاحن الجداري؟
  options: Ja, Nein
- photoWallbox | photo | required | Photo of the wallbox | Bild der Wallbox | صورة الشاحن الجداري
  show_if: wallboxInstalliert == Ja
- backupSystem | radio | required | Backup system installed? | Backup System installiert? | هل تم تركيب نظام احتياطي؟
  options: Ja, Nein
- pruefungDurchgefuehrt | radio | required | Test performed? | Prüfung durchgeführt? | هل تم إجراء الفحص؟
  options: Ja, Nein
- montagetermin | datetime | required | Installation date + time | Montagetermin Datum + Uhrzeit | تاريخ ووقت التركيب
- partnerunternehmen | text | required | Partner company name | Name Partnerunternehmen | اسم الشركة الشريكة
- monteurVorarbeiter | text | required | Installer / foreman name | Name Monteur/Vorarbeiter | اسم الفني/المشرف
- customerName | text | required | Customer | Kunde | العميل
- street | text | required | Street | Straße | الشارع
- houseNumber | text | required | House number | Hausnummer | رقم المنزل
- zipCode | text | required | ZIP code | PLZ | الرمز البريدي
- montageort | text | required | Installation city | Montageort | مدينة التركيب
- email | email | required | Customer email | E-Mail-Adresse des Kunden | البريد الإلكتروني للعميل
- vorarbeiterVorgestellt | radio | | Did the foreman introduce himself by name? | Hat sich der Vorarbeiter vor Ort namentlich vorgestellt? | هل قدّم المشرف نفسه بالاسم؟
  options: Ja, Nein
- schuhueberzieher | radio | | Were shoe covers worn? | Wurden Schuhüberzieher getragen? | هل تم ارتداء أغطية الأحذية؟
  options: Ja, Nein

## 1. Inverter | 1. Wechselrichter | 1. الانفرتر

section_id: inverter
repeatable: true
min: 1
max: 6

- photoTypenschild | photo | required | Photo of inverter nameplate (incl. serial number) | Bild des Typenschilds Wechselrichter (inkl. Seriennummer) | صورة لوحة بيانات الانفرتر (مع الرقم التسلسلي)
- photoAcGrid | photo | required | Photo of opened, connected AC plug (Grid) | Bild des geöffneten, angeschlossenen AC-Anschlussstecker (Grid) | صورة قابس AC المفتوح والموصول (Grid)
- photoAcBackup | photo | | Photo of opened, connected AC plug (Backup) | Bild des geöffneten, angeschlossenen AC-Anschlussstecker (Backup) | صورة قابس AC المفتوح والموصول (Backup)
- photoKommStecker | photo | | Photo of opened, connected communication plug | Bild des geöffneten, angeschlossenen Kommunikations-Anschlussstecker | صورة قابس الاتصال المفتوح والموصول
- photoDreiKomm | photo | | Photo of the three communication ports of the inverter | Bild der drei Kommunikationsanschlüsse des Wechselrichters | صورة منافذ الاتصال الثلاثة للانفرتر
- photoErdungLinks | photo | | Photo of connected earthing on inverter housing (left) | Bild der angeschlossenen Erdungsanschlüsse am Wechselrichtergehäuse (links) | صورة وصلات التأريض الموصولة (يسار)
- photoErdungRechts | photo | | Photo of connected earthing on inverter housing (right) | Bild der angeschlossenen Erdungsanschlüsse am Wechselrichtergehäuse (rechts) | صورة وصلات التأريض الموصولة (يمين)
- netzwerkanbindung | dropdown | | Type of network connection | Art der Netzwerkanbindung | نوع الاتصال بالشبكة
  options: WLAN-Verstärker/Powerline Adapter, direkte LAN-Verbindung, direkte WLAN-Verbindung
- photoVerstaerker | photo | | Photo of the repeater / powerline adapter | Bild vom Verstärker/Powerline Adapter | صورة المقوّي/محول Powerline
  show_if: netzwerkanbindung == WLAN-Verstärker/Powerline Adapter
- photoDcAkkukabel | photo | | Photo of connected DC battery cables to battery tower | Bild der angeschlossenen DC-Akkukabel zum Batterieturm | صورة كابلات DC الموصولة إلى برج البطارية
- photoWrFertig | photo | required | Photo of finished installed inverter (approx. 1m distance) | Bild des fertig installierten Wechselrichters (ca. 1m Entfernung) | صورة الانفرتر بعد التركيب (مسافة ~1م)
- cbBrandsicher | checkbox | | Inverter mounted on fireproof surface (tiles, stone, concrete, calcium silicate board) | Wechselrichter wurde auf brandsicherem Untergrund montiert (Fliesen, Stein, Beton, Calciumsilikatplatte) | تم تركيب الانفرتر على سطح مقاوم للحريق
- cbNormvorgaben | checkbox | | Normative and manufacturer specifications for the inverter were met (thermal clearances etc.) | Normative sowie Herstellervorgaben für den Wechselrichter wurden eingehalten (thermische Abstände etc.) | تم الالتزام بالمواصفات المعيارية ومواصفات الشركة المصنعة
- absicherungNachVorgaben | radio | | Selection of fuses and cable cross-sections per manufacturer specs per installation manuals | Auswahl der Absicherungen und Leitungsquerschnitte nach Herstellervorgaben laut Installationsanleitungen | اختيار المنصهرات ومقاطع الكابلات حسب مواصفات الشركة المصنعة
  options: Ja, Nein

## 2. Storage | 2. Speicher | 2. التخزين

section_id: storage
repeatable: true
min: 1
max: 4

- photoFussteil | photo | required | Photo of the level-aligned base of the battery tower | Bild des Waage ausgerichteten Fußteils des Batterieturms | صورة قاعدة برج البطارية المستوية
- anzahlAkkumodule | radio | required | How many battery modules were installed? | Wie viele Akkumodule wurden installiert? | كم عدد وحدات البطارية المركبة؟
  options: 1, 2, 3, 4
- photoModul1Aufgesteckt | photo | required | Photo of 1st mounted battery module with tightened wall bracket | Bild des 1. aufgesteckten Akkumoduls mit festgezogener Wandhalterung | صورة وحدة البطارية الأولى المركبة
- photoModul1Typenschild | photo | required | Photo of nameplate 1st battery module | Bild des Typenschilds 1. Akkumodul | صورة لوحة بيانات الوحدة الأولى
- photoModul2Aufgesteckt | photo | | Photo of 2nd mounted battery module with tightened wall bracket | Bild des 2. aufgesteckten Akkumoduls mit festgezogener Wandhalterung | صورة وحدة البطارية الثانية المركبة
  show_if: anzahlAkkumodule == 2 OR anzahlAkkumodule == 3 OR anzahlAkkumodule == 4
- photoModul2Typenschild | photo | | Photo of nameplate 2nd battery module | Bild des Typenschilds 2. Akkumodul | صورة لوحة بيانات الوحدة الثانية
  show_if: anzahlAkkumodule == 2 OR anzahlAkkumodule == 3 OR anzahlAkkumodule == 4
- photoModul3Aufgesteckt | photo | | Photo of 3rd mounted battery module with tightened wall bracket | Bild des 3. aufgesteckten Akkumoduls mit festgezogener Wandhalterung | صورة وحدة البطارية الثالثة المركبة
  show_if: anzahlAkkumodule == 3 OR anzahlAkkumodule == 4
- photoModul3Typenschild | photo | | Photo of nameplate 3rd battery module | Bild des Typenschilds 3. Akkumodul | صورة لوحة بيانات الوحدة الثالثة
  show_if: anzahlAkkumodule == 3 OR anzahlAkkumodule == 4
- photoModul4Aufgesteckt | photo | | Photo of 4th mounted battery module with tightened wall bracket | Bild des 4. aufgesteckten Akkumoduls mit festgezogener Wandhalterung | صورة وحدة البطارية الرابعة المركبة
  show_if: anzahlAkkumodule == 4
- photoModul4Typenschild | photo | | Photo of nameplate 4th battery module | Bild des Typenschilds 4. Akkumodul | صورة لوحة بيانات الوحدة الرابعة
  show_if: anzahlAkkumodule == 4
- photoKopfteilTypenschild | photo | required | Photo of nameplate of the battery tower head unit (incl. serial number) | Bild des Typenschilds vom Kopfteil des Batterieturmes (inkl. Seriennummer) | صورة لوحة بيانات رأس برج البطارية
- photoDcAkkukabelWr | photo | required | Photo of connected DC battery cables to the inverter | Bild der angeschlossenen DC-Akkukabel zum Wechselrichter | صورة كابلات DC الموصولة إلى الانفرتر
- photoKommLeitungWr | photo | | Photo of connected communication cable to the inverter | Bild der angeschlossenen Kommunikationsleitung zum Wechselrichter | صورة كابل الاتصال الموصول إلى الانفرتر
- photoAbschlusswiderstand | photo | | Photo of the connected terminating resistor | Bild des angeschlossenen Abschlusswiderstands | صورة المقاومة الطرفية الموصولة
- photoErdung | photo | | Photo earthing connection battery tower | Bild Erdungsanschluss Batterieturm | صورة وصلة تأريض برج البطارية
- photoGesamt | photo | required | Photo of the entire, finished and level-aligned battery tower | Bild des gesamten, fertig installierten & Waage ausgerichteten Batterieturms | صورة برج البطارية الكامل بعد التركيب
- cbNormvorgabenSpeicher | checkbox | | Normative and manufacturer specifications for the battery tower were met (thermal clearances etc.) | Normative sowie Herstellervorgaben für den Batterieturm wurden eingehalten (thermische Abstände etc.) | تم الالتزام بالمواصفات للبرج

## 3. Potential Equalization Rail | 3. Potentialausgleichsschiene | 3. قضيب معادلة الجهد

section_id: potential_rail

- photoKomponenten | photo | required | Components connected and labelled: Discharge, UK, DC-SPD, Inverter | Komponenten angeschlossen und wie folgt beschriftet: Ableitung, UK, DC-ÜSS, WR | المكونات موصولة وموسومة: التفريغ، البنية، DC-ÜSS، الانفرتر

## 4. Meter Cabinet | 4. Zählerschrank | 4. خزانة العداد

section_id: meter_cabinet

- photoPvAufkleber | photo | required | Photo of the PV sticker + test plate | Bild des PV-Aufklebers + der Prüfplakette | صورة ملصق PV + لوحة الفحص
- neuerZaehlerkasten | radio | required | New meter box installed? | Neuer Zählerkasten montiert? | هل تم تركيب خزانة عداد جديدة؟
  options: Ja, Nein
- photoNeuerZk | photo | required | Photo of new meter box with all covers, labels and stickers | Bild des neuen Zählerkastens mit allen Abdeckungen, Beschriftungen und Aufklebern | صورة خزانة العداد الجديدة مع كل الأغطية والملصقات
  show_if: neuerZaehlerkasten == Ja
- cbAlleKomponenten | checkbox | | All necessary components were installed | Alle notwendigen Komponenten wurden verbaut | تم تركيب جميع المكونات اللازمة
- photoBestandZk | photo | required | Photo of the existing meter box | Bild des Bestandzählerkastens | صورة خزانة العداد القائمة
- photoSls | photo | | Photo of installed SLS resp. existing NH back-up fuse | Bild des verbauten SLS bzw. der vorhandenen NH-Vorsicherung | صورة SLS أو منصهر NH
- photoAcUess | photo | | Photo of installed AC surge protection (AC-ÜSS) | Bild des verbauten AC-ÜSS | صورة حماية الجهد الزائد AC
- photoRcd | photo | | Photo of installed RCD (for service socket) | Bild des verbauten RCD´s (für Servicesteckdose) | صورة RCD المركب
- photoLeitungswegNeuerZk | photo | | Photo incl. cable route to the new meter cabinet | Bild inkl. Leitungsweg zum neuen ZK | صورة مع مسار الكابل إلى الخزانة الجديدة
  show_if: neuerZaehlerkasten == Ja
- cbBeruehrungsschutz | checkbox | | Contact protection for newly installed equipment per VDE provided | Berührungsschutz für neu installierte Betriebsmittel gem. VDE gegeben | حماية اللمس للمعدات الجديدة حسب VDE
- photoVerteilerkasten | multiphoto | | Photo distribution box (without cover: WR data cable, WR connection, connection from/to HL terminal) | Bild Verteilerkasten (ohne Abdeckung: Datenkabel WR, Anschluss WR, Anschluss von/zur HL-Klemme) | صور صندوق التوزيع
- apzVerdrahtung | radio | required | APZ wiring present? | APZ Verdrahtung vorhanden? | هل يوجد تمديد APZ؟
  options: Ja, Nein
- apzInstalliert | radio | required | APZ installed? | APZ installiert? | هل تم تركيب APZ؟
  options: Ja, Nein
- photoLeitungApz | photo | required | Photo of the cable in the APZ | Bild der Leitung im APZ | صورة الكابل في APZ
  show_if: apzInstalliert == Ja
- photoApzVerdrahtungZaehler | photo | required | Photo APZ wiring at the meter | Bild APZ Verdrahtung am Zähler | صورة تمديد APZ عند العداد
  show_if: apzInstalliert == Ja
- photoNeueAbsicherung | multiphoto | required | Photo of the newly installed fuse (legible!) | Bild der neu verbauten Absicherung (lesbar!) | صورة المنصهر الجديد (مقروء!)
- bestandsanlage | radio | required | On the existing electrical system, apart from the AC-side grid connection of the PV system | An der bestehenden Elektroanlage wurden bis auf die AC-seitige Netzanbindung der Photovoltaikanlage | على النظام الكهربائي القائم
  options: keine Änderungen vorgenommen, Änderungen vorgenommen
- cbStoerungsfrei | checkbox | | It is ensured that operating the PV system does not impair the trouble-free, safe power supply of the existing electrical system. | Es ist gewährleistet, dass durch den Betrieb der Photovoltaikanlage die störungsfreie und sichere Stromversorgung innerhalb der bestehenden Elektroanlage nicht beeinträchtigt wird. | مضمون أن تشغيل نظام PV لا يؤثر على إمداد الطاقة الآمن
- enerGrid | radio | required | EnerGrid or comparable | EnerGrid oder vergleichbar | EnerGrid أو ما يعادله
  options: Ja, Nein
- photoEnerGrid | photo | required | Photo | Foto | صورة
  show_if: enerGrid == Ja

## 5. Meter Registration (IBN) - Existing Meters | 5. Ein- und Ausbaumeldung IBN - Vorhandene Zähler | 5. عدادات قائمة

section_id: meter_ibn_meters
repeatable: true
min: 1
max: 10

- artZaehler | dropdown | required | Type of meter | Art des Zählers | نوع العداد
  options: Eintarif, Zweirichtungszähler, Zweitarif
- photoZaehler | photo | required | Photo of the meter | Bild des Zählers | صورة العداد
- photoZaehlerstaende | photo | required | Photo of the meter readings | Bild der Zählerstände | صورة قراءات العداد
- zaehlerAusbauen | radio | required | Does the meter have to be removed? | Muss der Zähler ausgebaut werden? | هل يجب إزالة العداد؟
  options: Ja, Nein
- zaehlerAustauschen | radio | required | Does the meter have to be replaced? | Muss der Zähler ausgetauscht werden? | هل يجب استبدال العداد؟
  options: Ja, Nein

## 5. Meter Registration (IBN) | 5. Ein- und Ausbaumeldung IBN | 5. الإبلاغ عن التركيب/الإزالة

section_id: meter_ibn

- typNeuerZaehler | radio | required | Type of the new meter | Typ des neuen Zählers | نوع العداد الجديد
  options: Dreipunkt, EHZ
- rundsteuerVorhanden | radio | required | Ripple control receiver present? | Rundsteuerempfänger vorhanden? | هل يوجد مستقبل التحكم؟
  options: Ja, Nein
- photoRundsteuer | photo | required | Photo of the ripple control receiver | Bild des Rundsteuerempfängers | صورة مستقبل التحكم
  show_if: rundsteuerVorhanden == Ja
- rundsteuerAusbauen | radio | required | Does the ripple control receiver have to be removed? | Muss Rundsteuerempfänger ausgebaut werden? | هل يجب إزالة مستقبل التحكم؟
  options: Ja, Nein
  show_if: rundsteuerVorhanden == Ja
- zaehlerzusammenlegung | radio | required | Meter consolidation required? | Zählerzusammenlegung erforderlich? | هل يلزم دمج العدادات؟
  options: Ja, Nein
- welcheZaehlerNr | text | | Which meter no. with which meter no.? | Welche Zähler Nr. mit welcher Zähler Nr.? | أي رقم عداد مع أي رقم عداد؟
  show_if: zaehlerzusammenlegung == Ja
- sonstigeAnmerkungen | textarea | | Other notes about the meters | Sonstige Anmerkungen zu den Zählern | ملاحظات أخرى حول العدادات
- messkonzept | radio | required | Which metering concept was set up? | Welches Messkonzept wurde aufgebaut? | ما مفهوم القياس الذي تم إعداده؟
  options: Überschusseinspeisung, Volleinspeisung, Wärmepumpenkaskade, Sonstiges Messkonzept
- photoVorbereitung14a | multiphoto | required | Photos preparation §14a | Bilder Vorbereitung §14a | صور تحضير §14a

## 6. Heat Pump Order for BSH Heat Pump | 6. Wärmepumpenauftrag für BSH-Wärmepumpe | 6. طلب المضخة الحرارية BSH

section_id: heat_pump

- hpHinweis | display_text | | For an order confirmed and commissioned by BSH for a heat pump. | Bei einem von der BSH beauftragten und bestätigten Wärmepumpenauftrag. | في حال طلب مضخة حرارية معتمد من BSH.
- bshWaermepumpe | radio | required | BSH heat pump ordered? | BSH-Wärmepumpe beauftragt? | هل تم طلب مضخة BSH الحرارية؟
  options: Ja, Nein
- photoUnterverteilungZk | photo | required | Sub-distribution / meter cabinet integration from a greater distance (with covers) | Unterverteilung/ZK Einbindung aus größerer Entfernung (mit Abdeckungen) | دمج التوزيع الفرعي من مسافة أكبر (مع الأغطية)
  show_if: bshWaermepumpe == Ja
- photoSicherungenWp | photo | required | Fuses for heat pump protection photographed legibly (without covers) | Sicherungen für Wärmepumpenabsicherung leserlich fotografiert (ohne Abdeckungen) | منصهرات حماية المضخة (بدون أغطية)
  show_if: bshWaermepumpe == Ja

## 7. Cable Routes | 7. Kabelwege | 7. مسارات الكابل

section_id: cable_routes

- photoAcKabelweg | multiphoto | required | Photos of the entire AC cable route | Bilder des gesamten AC Kabelwegs | صور مسار كابل AC بالكامل
- kabelwegUeber25m | radio | required | Cable route over 25m? | Kabelweg über 25m? | هل مسار الكابل أطول من 25م؟
  options: Ja, Nein
- zusaetzlicheMeter | number | required | How many additional metres were installed? | Wie viel Meter wurden zusätzlich verbaut? | كم متراً إضافياً تم تركيبه؟
  show_if: kabelwegUeber25m == Ja

## 8. Cleanliness | 8. Sauberkeit | 8. النظافة

section_id: cleanliness

- cbAbfallGeladen | checkbox | required | The waste was loaded into the own vehicle for removal and the site was left tidy/clean as found. | Der Abfall wurde zum Abtransport in das eigene Fahrzeug geladen und die Baustelle wurde wie vorgefunden, ordentlich/reinlich verlassen. | تم تحميل النفايات في المركبة وتُرك الموقع نظيفاً كما وُجد.

## 9. Completion of the Acceptance Protocol | 9. Abschluss des Abnahmeprotokolls | 9. إنهاء محضر القبول

section_id: completion

- cbAlleDetails | checkbox | required | The electrician carefully recorded all details in the protocol, discussed and explained them with the customer. The system is operationally accepted and released for invoicing. | Der Elektriker hat alle Details im Protokoll sorgfältig eingetragen, mit dem Kunden besprochen und erklärt. Die Anlage ist betriebsfertig abgenommen und ist zur Rechnungsstellung freigeben. | سجّل الكهربائي كل التفاصيل وناقشها مع العميل. النظام جاهز للتشغيل ومُعتمد.
- messprotokoll | file | required | Attach measurement protocol | Messprotokoll anhängen | إرفاق محضر القياس
  accepted_formats: pdf
- datumUhrzeit | datetime | required | Date and time | Datum und Uhrzeit | التاريخ والوقت
- bemerkungen | textarea | | Remarks | Bemerkungen | ملاحظات
- legalEeg | display_text | | The plant operator and the installation company declare that the plant described above and in the installation documentation (annex) is technically ready for operation within the meaning of § 3 No. 30 EEG (2021) on the day the AC acceptance protocol and the DC acceptance protocol are signed. | Vom Anlagenbetreiber sowie vom Installationsbetrieb wird erklärt, dass die oben genannte und in der Montagedokumentation (Anhang) dargestellte Anlage an dem Tag technisch betriebsbereit i.S.d. § 3 Nr. 30 EEG (2021) ist, an dem das AC-Abnahmeprotokoll sowie das DC-Abnahmeprotokoll unterzeichnet vorliegen. | يُقر المشغّل وشركة التركيب بأن النظام جاهز تقنياً وفق § 3 رقم 30 EEG (2021).
- electricianConfirm | display_text | | The executing electrical installer confirms with their signature that the electrical system was installed, measured and accepted according to the currently valid DIN-VDE standards as well as TAB and TAR. | Der ausführende Elektroinstallateur bestätigt mit seiner Unterschrift die elektrische Anlage nach den aktuell gültigen DIN-VDE Normen sowie TAB und TAR installiert, gemessen und abgenommen zu haben. | يؤكد الكهربائي بتوقيعه تركيب النظام وفق معايير DIN-VDE وTAB وTAR.
- electricianSignature | signature | required | Signature of the electrician/partner on site | Unterschrift des Elektrikers/Partners vor Ort | توقيع الكهربائي/الشريك في الموقع
- ort | text | required | Location | Ort | المكان
- zeitpunkt | datetime | required | Time | Zeitpunkt | الوقت
  default: current_time
- unterschriftVon | radio | required | Signature by | Unterschrift von | التوقيع من
  options: Kunde, Bevollmächtigter
- customerSignature | signature | required | Signature of the customer or authorized representative | Unterschrift des Kunden oder Bevollmächtigten | توقيع العميل أو المفوّض
- customerFullName | text | required | First and last name customer | Vor- und Nachname Kunde | الاسم الكامل للعميل
- bevollmaechtigterName | text | | First and last name authorized representative | Vor- und Nachname Bevollmächtigter | الاسم الكامل للمفوّض
  show_if: unterschriftVon == Bevollmächtigter
- widerspruchHinweis | display_text | | The objection period is 14 days; after expiry the acceptance protocol is deemed confirmed. | Die Widerspruchsfrist beträgt 14 Tage, nach Ablauf der Frist gilt das Abnahmeprotokoll als bestätigt. | فترة الاعتراض 14 يوماً، بعدها يُعتبر المحضر مؤكداً.
- versendeteEmail | email | | Sent email | Versendete E-Mail | البريد الإلكتروني المُرسل
