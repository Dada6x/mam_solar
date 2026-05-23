import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
    Locale('ar'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'mam-solarbau'**
  String get appTitle;

  /// No description provided for @newProtocol.
  ///
  /// In en, this message translates to:
  /// **'New Protocol'**
  String get newProtocol;

  /// No description provided for @savedDrafts.
  ///
  /// In en, this message translates to:
  /// **'Saved Drafts'**
  String get savedDrafts;

  /// No description provided for @exportedPdfs.
  ///
  /// In en, this message translates to:
  /// **'Exported PDFs'**
  String get exportedPdfs;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @acAcceptanceProtocol.
  ///
  /// In en, this message translates to:
  /// **'AC Acceptance Protocol'**
  String get acAcceptanceProtocol;

  /// No description provided for @workOrder.
  ///
  /// In en, this message translates to:
  /// **'Work Order'**
  String get workOrder;

  /// No description provided for @damageReport.
  ///
  /// In en, this message translates to:
  /// **'Damage Report'**
  String get damageReport;

  /// No description provided for @installationReport.
  ///
  /// In en, this message translates to:
  /// **'Installation Report'**
  String get installationReport;

  /// No description provided for @customerData.
  ///
  /// In en, this message translates to:
  /// **'Customer Data'**
  String get customerData;

  /// No description provided for @installationDetails.
  ///
  /// In en, this message translates to:
  /// **'Installation Details'**
  String get installationDetails;

  /// No description provided for @inverter.
  ///
  /// In en, this message translates to:
  /// **'Inverter'**
  String get inverter;

  /// No description provided for @batteryStorage.
  ///
  /// In en, this message translates to:
  /// **'Battery Storage'**
  String get batteryStorage;

  /// No description provided for @meterCabinet.
  ///
  /// In en, this message translates to:
  /// **'Meter Cabinet'**
  String get meterCabinet;

  /// No description provided for @meterInfo.
  ///
  /// In en, this message translates to:
  /// **'Meter Information'**
  String get meterInfo;

  /// No description provided for @cableRoutes.
  ///
  /// In en, this message translates to:
  /// **'Cable Routes'**
  String get cableRoutes;

  /// No description provided for @finalAcceptance.
  ///
  /// In en, this message translates to:
  /// **'Final Acceptance'**
  String get finalAcceptance;

  /// No description provided for @remarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get remarks;

  /// No description provided for @signatures.
  ///
  /// In en, this message translates to:
  /// **'Signatures'**
  String get signatures;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @generate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generate;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @autosaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get autosaved;

  /// No description provided for @protocolCompleted.
  ///
  /// In en, this message translates to:
  /// **'Protocol completed'**
  String get protocolCompleted;

  /// No description provided for @draftSaved.
  ///
  /// In en, this message translates to:
  /// **'Draft saved'**
  String get draftSaved;

  /// No description provided for @signatureCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer Signature'**
  String get signatureCustomer;

  /// No description provided for @signatureInstaller.
  ///
  /// In en, this message translates to:
  /// **'Installer Signature'**
  String get signatureInstaller;

  /// No description provided for @signatureTechnician.
  ///
  /// In en, this message translates to:
  /// **'Technician Signature'**
  String get signatureTechnician;

  /// No description provided for @signatureDamagedParty.
  ///
  /// In en, this message translates to:
  /// **'Damaged Party Signature'**
  String get signatureDamagedParty;

  /// No description provided for @signatureEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee Signature'**
  String get signatureEmployee;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// No description provided for @noDraftsYet.
  ///
  /// In en, this message translates to:
  /// **'No drafts yet'**
  String get noDraftsYet;

  /// No description provided for @noDraftsYetDesc.
  ///
  /// In en, this message translates to:
  /// **'Completed protocols will appear here'**
  String get noDraftsYetDesc;

  /// No description provided for @deleteDraftConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this draft?'**
  String get deleteDraftConfirm;

  /// No description provided for @deleteDraftMsg.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteDraftMsg;

  /// No description provided for @clearDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Clear all data?'**
  String get clearDataConfirm;

  /// No description provided for @clearDataMsg.
  ///
  /// In en, this message translates to:
  /// **'All protocols, signatures, and drafts will be permanently deleted.'**
  String get clearDataMsg;

  /// No description provided for @pdfGenerationFailed.
  ///
  /// In en, this message translates to:
  /// **'PDF generation failed'**
  String get pdfGenerationFailed;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed — tap to retry'**
  String get saveFailed;

  /// No description provided for @generatePdf.
  ///
  /// In en, this message translates to:
  /// **'Generate PDF'**
  String get generatePdf;

  /// No description provided for @protocolNumber.
  ///
  /// In en, this message translates to:
  /// **'Protocol No.'**
  String get protocolNumber;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerName;

  /// No description provided for @installationDate.
  ///
  /// In en, this message translates to:
  /// **'Installation Date'**
  String get installationDate;

  /// No description provided for @installerName.
  ///
  /// In en, this message translates to:
  /// **'Installer Name'**
  String get installerName;

  /// No description provided for @partnerCompany.
  ///
  /// In en, this message translates to:
  /// **'Partner Company'**
  String get partnerCompany;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'ZIP Code'**
  String get zipCode;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @installationType.
  ///
  /// In en, this message translates to:
  /// **'Installation Type'**
  String get installationType;

  /// No description provided for @solarPv.
  ///
  /// In en, this message translates to:
  /// **'Solar PV'**
  String get solarPv;

  /// No description provided for @solarPvBattery.
  ///
  /// In en, this message translates to:
  /// **'Solar PV + Battery'**
  String get solarPvBattery;

  /// No description provided for @solarPvWallbox.
  ///
  /// In en, this message translates to:
  /// **'Solar PV + Wallbox'**
  String get solarPvWallbox;

  /// No description provided for @storageManufacturer.
  ///
  /// In en, this message translates to:
  /// **'Storage Manufacturer'**
  String get storageManufacturer;

  /// No description provided for @wallboxInstalled.
  ///
  /// In en, this message translates to:
  /// **'Wallbox installed'**
  String get wallboxInstalled;

  /// No description provided for @backupInstalled.
  ///
  /// In en, this message translates to:
  /// **'Backup installed'**
  String get backupInstalled;

  /// No description provided for @inspectionCompleted.
  ///
  /// In en, this message translates to:
  /// **'Inspection completed'**
  String get inspectionCompleted;

  /// No description provided for @inspectionReason.
  ///
  /// In en, this message translates to:
  /// **'Reason for missing inspection'**
  String get inspectionReason;

  /// No description provided for @groundRodInstalled.
  ///
  /// In en, this message translates to:
  /// **'Ground rod installed'**
  String get groundRodInstalled;

  /// No description provided for @privateMeterInstalled.
  ///
  /// In en, this message translates to:
  /// **'Private meter installed'**
  String get privateMeterInstalled;

  /// No description provided for @supervisorIntroduced.
  ///
  /// In en, this message translates to:
  /// **'Supervisor introduced'**
  String get supervisorIntroduced;

  /// No description provided for @shoeCoversWorn.
  ///
  /// In en, this message translates to:
  /// **'Shoe covers worn'**
  String get shoeCoversWorn;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @serialNumber.
  ///
  /// In en, this message translates to:
  /// **'Serial Number'**
  String get serialNumber;

  /// No description provided for @networkType.
  ///
  /// In en, this message translates to:
  /// **'Network Type'**
  String get networkType;

  /// No description provided for @wlan.
  ///
  /// In en, this message translates to:
  /// **'WLAN'**
  String get wlan;

  /// No description provided for @powerline.
  ///
  /// In en, this message translates to:
  /// **'Powerline'**
  String get powerline;

  /// No description provided for @ethernet.
  ///
  /// In en, this message translates to:
  /// **'Ethernet'**
  String get ethernet;

  /// No description provided for @installedCorrectly.
  ///
  /// In en, this message translates to:
  /// **'Installed correctly'**
  String get installedCorrectly;

  /// No description provided for @photoDataplate.
  ///
  /// In en, this message translates to:
  /// **'Photo - Dataplate'**
  String get photoDataplate;

  /// No description provided for @photoAcConnection.
  ///
  /// In en, this message translates to:
  /// **'Photo - AC Connection'**
  String get photoAcConnection;

  /// No description provided for @photoFinalInstall.
  ///
  /// In en, this message translates to:
  /// **'Photo - Final Installation'**
  String get photoFinalInstall;

  /// No description provided for @batteryBrand.
  ///
  /// In en, this message translates to:
  /// **'Battery Brand'**
  String get batteryBrand;

  /// No description provided for @batteryModel.
  ///
  /// In en, this message translates to:
  /// **'Battery Model'**
  String get batteryModel;

  /// No description provided for @batteryTowers.
  ///
  /// In en, this message translates to:
  /// **'Battery Towers'**
  String get batteryTowers;

  /// No description provided for @batteryModules.
  ///
  /// In en, this message translates to:
  /// **'Modules per Tower'**
  String get batteryModules;

  /// No description provided for @serialNumbers.
  ///
  /// In en, this message translates to:
  /// **'Serial Numbers'**
  String get serialNumbers;

  /// No description provided for @photoBattery.
  ///
  /// In en, this message translates to:
  /// **'Photo - Battery'**
  String get photoBattery;

  /// No description provided for @newCabinetInstalled.
  ///
  /// In en, this message translates to:
  /// **'New cabinet installed'**
  String get newCabinetInstalled;

  /// No description provided for @allComponentsInstalled.
  ///
  /// In en, this message translates to:
  /// **'All components installed'**
  String get allComponentsInstalled;

  /// No description provided for @touchProtection.
  ///
  /// In en, this message translates to:
  /// **'Touch protection'**
  String get touchProtection;

  /// No description provided for @apzInstalled.
  ///
  /// In en, this message translates to:
  /// **'APZ installed'**
  String get apzInstalled;

  /// No description provided for @energridInstalled.
  ///
  /// In en, this message translates to:
  /// **'Energrid installed'**
  String get energridInstalled;

  /// No description provided for @photoNewCabinet.
  ///
  /// In en, this message translates to:
  /// **'Photo - New Cabinet'**
  String get photoNewCabinet;

  /// No description provided for @photoOldCabinet.
  ///
  /// In en, this message translates to:
  /// **'Photo - Old Cabinet'**
  String get photoOldCabinet;

  /// No description provided for @meterType.
  ///
  /// In en, this message translates to:
  /// **'Meter Type'**
  String get meterType;

  /// No description provided for @singleDirection.
  ///
  /// In en, this message translates to:
  /// **'Single Direction'**
  String get singleDirection;

  /// No description provided for @bidirectional.
  ///
  /// In en, this message translates to:
  /// **'Bidirectional'**
  String get bidirectional;

  /// No description provided for @threePoint.
  ///
  /// In en, this message translates to:
  /// **'Three-Point'**
  String get threePoint;

  /// No description provided for @meterReplacementNeeded.
  ///
  /// In en, this message translates to:
  /// **'Meter replacement needed'**
  String get meterReplacementNeeded;

  /// No description provided for @meterRemovalNeeded.
  ///
  /// In en, this message translates to:
  /// **'Meter removal needed'**
  String get meterRemovalNeeded;

  /// No description provided for @measurementConcept.
  ///
  /// In en, this message translates to:
  /// **'Measurement Concept'**
  String get measurementConcept;

  /// No description provided for @excessFeedIn.
  ///
  /// In en, this message translates to:
  /// **'Excess Feed-in'**
  String get excessFeedIn;

  /// No description provided for @fullFeedIn.
  ///
  /// In en, this message translates to:
  /// **'Full Feed-in'**
  String get fullFeedIn;

  /// No description provided for @selfConsumption.
  ///
  /// In en, this message translates to:
  /// **'Self-consumption'**
  String get selfConsumption;

  /// No description provided for @photoMeter.
  ///
  /// In en, this message translates to:
  /// **'Photo - Meter'**
  String get photoMeter;

  /// No description provided for @routeOver25m.
  ///
  /// In en, this message translates to:
  /// **'Cable route over 25m'**
  String get routeOver25m;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @photoCable1.
  ///
  /// In en, this message translates to:
  /// **'Photo - Cable 1'**
  String get photoCable1;

  /// No description provided for @photoCable2.
  ///
  /// In en, this message translates to:
  /// **'Photo - Cable 2'**
  String get photoCable2;

  /// No description provided for @photoCable3.
  ///
  /// In en, this message translates to:
  /// **'Photo - Cable 3'**
  String get photoCable3;

  /// No description provided for @systemOperational.
  ///
  /// In en, this message translates to:
  /// **'System is operational'**
  String get systemOperational;

  /// No description provided for @customerInformed.
  ///
  /// In en, this message translates to:
  /// **'Customer has been informed'**
  String get customerInformed;

  /// No description provided for @invoiceApproved.
  ///
  /// In en, this message translates to:
  /// **'Invoice approved'**
  String get invoiceApproved;

  /// No description provided for @cleanupDone.
  ///
  /// In en, this message translates to:
  /// **'Cleanup completed'**
  String get cleanupDone;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @zipCity.
  ///
  /// In en, this message translates to:
  /// **'ZIP / City'**
  String get zipCity;

  /// No description provided for @workDescription.
  ///
  /// In en, this message translates to:
  /// **'Work Description'**
  String get workDescription;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @workDetail.
  ///
  /// In en, this message translates to:
  /// **'Work Detail'**
  String get workDetail;

  /// No description provided for @materials.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get materials;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @vehicleTravel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle / Travel'**
  String get vehicleTravel;

  /// No description provided for @departure.
  ///
  /// In en, this message translates to:
  /// **'Departure'**
  String get departure;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHours;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @techName.
  ///
  /// In en, this message translates to:
  /// **'Technician Name'**
  String get techName;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @completion.
  ///
  /// In en, this message translates to:
  /// **'Completion'**
  String get completion;

  /// No description provided for @workCompleted.
  ///
  /// In en, this message translates to:
  /// **'Work completed'**
  String get workCompleted;

  /// No description provided for @photoWork1.
  ///
  /// In en, this message translates to:
  /// **'Photo - Work 1'**
  String get photoWork1;

  /// No description provided for @photoWork2.
  ///
  /// In en, this message translates to:
  /// **'Photo - Work 2'**
  String get photoWork2;

  /// No description provided for @completionDate.
  ///
  /// In en, this message translates to:
  /// **'Completion Date'**
  String get completionDate;

  /// No description provided for @damageDeclaration.
  ///
  /// In en, this message translates to:
  /// **'Damage Declaration'**
  String get damageDeclaration;

  /// No description provided for @damageType.
  ///
  /// In en, this message translates to:
  /// **'Damage Type'**
  String get damageType;

  /// No description provided for @atCustomerProperty.
  ///
  /// In en, this message translates to:
  /// **'At customer property'**
  String get atCustomerProperty;

  /// No description provided for @atThirdParty.
  ///
  /// In en, this message translates to:
  /// **'At third party property'**
  String get atThirdParty;

  /// No description provided for @materialDamage.
  ///
  /// In en, this message translates to:
  /// **'Material damage'**
  String get materialDamage;

  /// No description provided for @causedByPartner.
  ///
  /// In en, this message translates to:
  /// **'Caused by partner company'**
  String get causedByPartner;

  /// No description provided for @companyLiability.
  ///
  /// In en, this message translates to:
  /// **'Company liability'**
  String get companyLiability;

  /// No description provided for @customerInjuredParty.
  ///
  /// In en, this message translates to:
  /// **'Customer / Injured Party'**
  String get customerInjuredParty;

  /// No description provided for @injuredName.
  ///
  /// In en, this message translates to:
  /// **'Injured Party Name'**
  String get injuredName;

  /// No description provided for @incidentDetails.
  ///
  /// In en, this message translates to:
  /// **'Incident Details'**
  String get incidentDetails;

  /// No description provided for @incidentDateTime.
  ///
  /// In en, this message translates to:
  /// **'Incident Date'**
  String get incidentDateTime;

  /// No description provided for @incidentTime.
  ///
  /// In en, this message translates to:
  /// **'Incident Time'**
  String get incidentTime;

  /// No description provided for @secondPersonInvolved.
  ///
  /// In en, this message translates to:
  /// **'Second person involved'**
  String get secondPersonInvolved;

  /// No description provided for @damageDescription.
  ///
  /// In en, this message translates to:
  /// **'Damage Description'**
  String get damageDescription;

  /// No description provided for @initialSituation.
  ///
  /// In en, this message translates to:
  /// **'Initial situation'**
  String get initialSituation;

  /// No description provided for @incidentSequence.
  ///
  /// In en, this message translates to:
  /// **'Incident sequence'**
  String get incidentSequence;

  /// No description provided for @affectedDevices.
  ///
  /// In en, this message translates to:
  /// **'Affected Devices'**
  String get affectedDevices;

  /// No description provided for @deviceName.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get deviceName;

  /// No description provided for @deviceBrand.
  ///
  /// In en, this message translates to:
  /// **'Device Brand'**
  String get deviceBrand;

  /// No description provided for @devicePhoto.
  ///
  /// In en, this message translates to:
  /// **'Device Photo'**
  String get devicePhoto;

  /// No description provided for @damageMinimization.
  ///
  /// In en, this message translates to:
  /// **'Damage Minimization'**
  String get damageMinimization;

  /// No description provided for @minimizationPossible.
  ///
  /// In en, this message translates to:
  /// **'Minimization possible'**
  String get minimizationPossible;

  /// No description provided for @minimizationNotes.
  ///
  /// In en, this message translates to:
  /// **'Minimization Notes'**
  String get minimizationNotes;

  /// No description provided for @insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get insurance;

  /// No description provided for @insuranceNotes.
  ///
  /// In en, this message translates to:
  /// **'Insurance Notes'**
  String get insuranceNotes;

  /// No description provided for @employeeInfo.
  ///
  /// In en, this message translates to:
  /// **'Employee Info'**
  String get employeeInfo;

  /// No description provided for @employeeName.
  ///
  /// In en, this message translates to:
  /// **'Employee Name'**
  String get employeeName;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to mam-solarbau'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Field protocol app for solar installations'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Create Protocols'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Fill out structured forms, add photos and signatures'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get onboardingDesc3;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @protocolType.
  ///
  /// In en, this message translates to:
  /// **'Protocol Type'**
  String get protocolType;

  /// No description provided for @acAcceptanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete AC acceptance checklist'**
  String get acAcceptanceSubtitle;

  /// No description provided for @workOrderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Document work orders and hours'**
  String get workOrderSubtitle;

  /// No description provided for @damageReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Report damages and incidents'**
  String get damageReportSubtitle;

  /// No description provided for @installationReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Document installation details'**
  String get installationReportSubtitle;

  /// No description provided for @recentDrafts.
  ///
  /// In en, this message translates to:
  /// **'Recent Drafts'**
  String get recentDrafts;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection required'**
  String get noInternet;

  /// No description provided for @offlineFirst.
  ///
  /// In en, this message translates to:
  /// **'Fully offline-capable'**
  String get offlineFirst;

  /// No description provided for @pdfExport.
  ///
  /// In en, this message translates to:
  /// **'PDF Export'**
  String get pdfExport;

  /// No description provided for @pdfReady.
  ///
  /// In en, this message translates to:
  /// **'PDF ready'**
  String get pdfReady;

  /// No description provided for @saveToFiles.
  ///
  /// In en, this message translates to:
  /// **'Save to Files'**
  String get saveToFiles;

  /// No description provided for @deleteDraft.
  ///
  /// In en, this message translates to:
  /// **'Delete Draft'**
  String get deleteDraft;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addItem;

  /// No description provided for @removeItem.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeItem;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @signHere.
  ///
  /// In en, this message translates to:
  /// **'Sign here'**
  String get signHere;

  /// No description provided for @confirmSignature.
  ///
  /// In en, this message translates to:
  /// **'Confirm Signature'**
  String get confirmSignature;

  /// No description provided for @clearSignature.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearSignature;

  /// No description provided for @signatureRequired.
  ///
  /// In en, this message translates to:
  /// **'Signature is required'**
  String get signatureRequired;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'BSH GmbH & Co. KG'**
  String get companyName;

  /// No description provided for @companyAddress.
  ///
  /// In en, this message translates to:
  /// **'Bamberger Str. 44, 97631 Bad Königshofen'**
  String get companyAddress;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'1.0.0'**
  String get appVersion;

  /// No description provided for @pageOf.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageOf(Object current, Object total);

  /// No description provided for @noQuestions.
  ///
  /// In en, this message translates to:
  /// **'No questions available'**
  String get noQuestions;

  /// No description provided for @fieldRequiredSingle.
  ///
  /// In en, this message translates to:
  /// **'Please answer this question'**
  String get fieldRequiredSingle;

  /// No description provided for @allQuestionsAnswered.
  ///
  /// In en, this message translates to:
  /// **'All questions answered!'**
  String get allQuestionsAnswered;

  /// No description provided for @reviewAndGenerate.
  ///
  /// In en, this message translates to:
  /// **'Review and generate your PDF'**
  String get reviewAndGenerate;

  /// No description provided for @unsavedChanges.
  ///
  /// In en, this message translates to:
  /// **'Unsaved changes'**
  String get unsavedChanges;

  /// No description provided for @leaveWithoutSaving.
  ///
  /// In en, this message translates to:
  /// **'Leave without saving?'**
  String get leaveWithoutSaving;

  /// No description provided for @saveAndLeave.
  ///
  /// In en, this message translates to:
  /// **'Save as draft'**
  String get saveAndLeave;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorGeneric;

  /// No description provided for @protocolNotInitialized.
  ///
  /// In en, this message translates to:
  /// **'Protocol not initialized'**
  String get protocolNotInitialized;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @failedToCapturePhoto.
  ///
  /// In en, this message translates to:
  /// **'Failed to capture photo'**
  String get failedToCapturePhoto;

  /// No description provided for @failedToPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image'**
  String get failedToPickImage;

  /// No description provided for @failedToSaveSignature.
  ///
  /// In en, this message translates to:
  /// **'Failed to save signature'**
  String get failedToSaveSignature;

  /// No description provided for @allDataCleared.
  ///
  /// In en, this message translates to:
  /// **'All data cleared'**
  String get allDataCleared;

  /// No description provided for @pdfPreview.
  ///
  /// In en, this message translates to:
  /// **'PDF Preview'**
  String get pdfPreview;

  /// No description provided for @openFile.
  ///
  /// In en, this message translates to:
  /// **'Open file'**
  String get openFile;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get deleteAll;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
