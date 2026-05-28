import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class AcProtocolPdfGenerator {
  static const _expectedFlatKeys = [
    // Customer Data
    'customerName', 'street', 'houseNumber', 'city', 'zipCode', 'email', 'phone',
    'installationDate', 'installationTime',
    'installerName', 'partnerCompany',

    // Installation Type
    'backupInstalled', 
    'inspectionCompleted', 'inspectionReason',
    'groundRodInstalled', 'privateMeterInstalled',

    'installationType', 'storageManufacturer', 'wallboxInstalled',
    'supervisorIntroduced', 'shoeCoversWorn',

    // Equipotential Bonding
    'componentsConnected',
    'eqEarthingConnected', 'eqUkConnected', 'eqDcOvervoltageConnected', 'eqInverterConnected',
    'photoBonding',

    // Meter Cabinet
    'newCabinetInstalled', 'allComponentsInstalled', 'touchProtection',
    'apzWiring', 'apzInstalled',
    'existingSystemChanges','energridInstalled',
    'photoCabinet',
    'photoNewFuse', 'photoApzCable', 'photoApzWiringMeter',
    'photoEnergrid',
    'photoPvLabel', 'photoNewCabinet', 'photoOldCabinet', 'photoSlsOrNh',
    'photoAcOvervoltage', 'photoRcd', 'photoCableRouteToNewCabinet',
    'photoApzCableInside', 'photoApzMeterConnections',

    // Meter Registration
    'newMeterType',
    'remoteControlPresent', 'photoRemoteControl',
    'removeRemoteControl',
    'meterConsolidation', 'consolidationDescription',
    'meterRemarks',
    'measurementConcept',
    'meterType', 'meterRemovalNeeded', 'meterReplacementNeeded',
    'remoteControl',
    'photoMeter', 'photoMeterReadings',

    // Heat Pump
    'heatPumpOrdered',
    'photoSubDistribution', 'photoFusesHeatPump',
    'heatPumpRequested',

    // Cable Routes
    'photoCableRoute',
    'routeOver25m', 'additionalMeters',
    'notes',
    'photoCable1', 'photoCable2', 'photoCable3', 'photoCable4',

    // Cleanliness
    'siteCleanedUp',

    // Final Acceptance
    'detailsRecorded',
    'measurementProtocol',
    'completionDate', 'completionTime',
    'remarks',
    'systemOperational', 'customerInformed', 'invoiceApproved',
    // additional info 
    'note', 'image',

    // Customer Signature
    'customerSignature', 'customerFullName',

    // Installer Signature
    'installerSignature',
  ];

static const _expectedRepeatableKeys = {
  'inverter': [
    'inverterCount', 'brand', 'model', 'serialNumber', 'networkType',
    'installedCorrectly', 'mountedOnFireproofSurface', 'normsFollowed',
    'fusesPerSpec', 'fusesRemark',
    'manufacturerStandardsFollowed',
    'photoDataplate', 'photoAcGrid', 'photoAcBackup', 'photoCommunicationPlug',
    'photoThreeCommunicationPorts', 'photoEarthingLeft', 'photoEarthingRight',
    'photoPlcOrWlanExtender', 'photoDcBatteryCables', 'photoFinalInstall',
  ],
  'battery_storage': [
    'batteryBrand', 'batteryModel', 'batterySid',
    'batteryTowers', 'batteryModulesPerTower', 'serialNumbers',
    'standardsFollowed',
    'photoQrCode', 'photoBatteryConnections', 'photoEmsNumber', 'photoAcPlugOpen',
    'photoBatteryWithoutCovers', 'photoBatteryWithCovers', 'photoBatteryFromDistance',
    'photoBatteryBase', 'photoBatteryEarthing', 'photoBatteryTowerFinal',
  ],
  'distribution_board': [
    'photoDistBoard', 'additionalDetails',
  ],
  'protection_devices': [
    'photoProtectionDevice', 'noChangesMade', 'systemStabilityTested', 'enerGridUsed',
  ],
  'existingMeters': [
    'meterNumber', 'meterType', 'photoMeter',
  ],
  'meter_registration': [
    'newMeterType', 'remoteControlPrdesent', 'photoRemoteControl',
    'removeRemoteControl', 'meterConsolidation', 'consolidationDescription',
    'meterRemarks', 'meterRemovalNeeded', 'meterReplacementNeeded',
    'photoMeterReadings', 'measurementConcept',
  ],
  'additional_info': [
    'note', 'image',
  ],
};

  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    PdfGeneratorBase.logExpectedFields(data, 'AcProtocolPdfGenerator', _expectedFlatKeys);
    PdfGeneratorBase.logExpectedRepeatableFields(repeatableData, 'AcProtocolPdfGenerator', _expectedRepeatableKeys);

    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'AC', DateTime.now(), protocolId,
    );

    return PdfGeneratorBase.createDocument(
      title: 'AC Acceptance Protocol',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: [
        _buildCustomerDataSection(data),
        _buildInstallationDetailsSection(data),
        _buildInverterSection(repeatableData),
        _buildBatteryStorageSection(repeatableData),
        // _buildEquipotentialBondingSection(data),
        _buildDistributionBoardSection(repeatableData),
        _buildMeterCabinetSection(data),
        _buildProtectionDevicesSection(repeatableData),
        _buildMeterRegistrationSection(repeatableData),
        _buildHeatPumpSection(data),
        _buildCableRoutesSection(data),
        _buildCleanlinessSection(data),
        _buildFinalAcceptanceSection(data),
        _buildRemarksSection(data),
        _buildAdditionalInfoSection(repeatableData),
        _buildSignaturesSection(data),
      ],
    );
  }

  static pw.Widget _buildCustomerDataSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Customer Data', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['customerName'])),
      PdfGeneratorBase.buildFieldRow('Street', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('House Number', PdfGeneratorBase.safeString(data['houseNumber'])),
      PdfGeneratorBase.buildFieldRow('City', PdfGeneratorBase.safeString(data['city'])),
      PdfGeneratorBase.buildFieldRow('Zip Code', PdfGeneratorBase.safeString(data['zipCode'])),
      PdfGeneratorBase.buildFieldRow('Email', PdfGeneratorBase.safeString(data['email'])),
      PdfGeneratorBase.buildFieldRow('Phone', PdfGeneratorBase.safeString(data['phone'])),
      PdfGeneratorBase.buildFieldRow('Installation Date', PdfGeneratorBase.safeString(data['installationDate'])),
      PdfGeneratorBase.buildFieldRow('Installation Time', PdfGeneratorBase.safeString(data['installationTime'])),
      PdfGeneratorBase.buildFieldRow('Installer', PdfGeneratorBase.safeString(data['installerName'])),
      PdfGeneratorBase.buildFieldRow('Partner Company', PdfGeneratorBase.safeString(data['partnerCompany'])),
    ]);
  }

  static pw.Widget _buildInstallationDetailsSection(Map<String, dynamic> data) {
    final backupInstalled = data['backupInstalled'] == true || data['backupInstalled'] == 'yes';
    final inspectionCompleted = data['inspectionCompleted'];
    final inspectionNotDone = inspectionCompleted == false ||
        inspectionCompleted == 'no' ||
        inspectionCompleted == 'not_possible';

    return PdfGeneratorBase.buildSection('Installation Details', [
      PdfGeneratorBase.buildFieldRow('Type', PdfGeneratorBase.safeString(data['installationType'])),
      PdfGeneratorBase.buildFieldRow('Storage Manufacturer', PdfGeneratorBase.safeString(data['storageManufacturer'])),
      PdfGeneratorBase.buildFieldRow('Wallbox', data['wallboxInstalled'] == true ? 'Yes' : 'No'),

      PdfGeneratorBase.buildFieldRow('Backup System Installed', backupInstalled ? 'Yes' : 'No'),
    
      PdfGeneratorBase.buildFieldRow(
        'Inspection Completed',
        inspectionCompleted == 'not_possible'
            ? 'Not Possible'
            : (inspectionCompleted == true || inspectionCompleted == 'yes' ? 'Yes' : 'No'),
      ),
      if (inspectionNotDone)
        PdfGeneratorBase.buildFieldRow('Reason for No Inspection', PdfGeneratorBase.safeString(data['inspectionReason'])),

      PdfGeneratorBase.buildFieldRow('Ground Rod Installed', _yesNo(data['groundRodInstalled'])),
      PdfGeneratorBase.buildFieldRow('Private Intermediate Meter Installed', _yesNo(data['privateMeterInstalled'])),

      PdfGeneratorBase.buildFieldRow('Briefing Conducted', data['supervisorIntroduced'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('Shoe Covers Worn', data['shoeCoversWorn'] == true ? 'Yes' : 'No'),
    ]);
  }

  static pw.Widget _buildInverterSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final inverters = repeatableData['inverter'] ?? [];
    final fields = <pw.Widget>[];
    if (inverters.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Inverter', 'No data'));
    } else {
      for (var i = 0; i < inverters.length; i++) {
        final inv = inverters[i];
        fields.add(pw.Text(
          'Inverter #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildFieldRow('Brand', PdfGeneratorBase.safeString(inv['brand'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Model', PdfGeneratorBase.safeString(inv['model'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Serial Number', PdfGeneratorBase.safeString(inv['serialNumber'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Network Type', PdfGeneratorBase.safeString(inv['networkType'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Installed Correctly', _yesNo(inv['installedCorrectly'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Mounted on Fireproof Surface', _yesNo(inv['mountedOnFireproofSurface'])));
        fields.add(PdfGeneratorBase.buildFieldRow(
          'Manufacturer Standards Followed',
          _yesNo(inv['normsFollowed'] ?? inv['manufacturerStandardsFollowed']),
        ));
     
        fields.add(PdfGeneratorBase.buildPhotoField('Data Plate', inv['photoDataplate'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('AC Grid', inv['photoAcGrid'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('AC Backup', inv['photoAcBackup'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Communication Plug', inv['photoCommunicationPlug'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Three Communication Ports', inv['photoThreeCommunicationPorts'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Earthing Left', inv['photoEarthingLeft'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Earthing Right', inv['photoEarthingRight'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('PLC / WLAN Extender', inv['photoPlcOrWlanExtender'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('DC Battery Cables', inv['photoDcBatteryCables'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Final Installation', inv['photoFinalInstall'] as String?));
        if (i < inverters.length - 1) {
          fields.add(pw.SizedBox(height: 6));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Inverter', fields);
  }

  static pw.Widget _buildBatteryStorageSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final batteries = repeatableData['battery_storage'] ?? [];
    final fields = <pw.Widget>[];
    if (batteries.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Battery Storage', 'No data'));
    } else {
      for (var i = 0; i < batteries.length; i++) {
        final battery = batteries[i];
        fields.add(pw.Text(
          'Battery Storage #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildFieldRow('Brand', PdfGeneratorBase.safeString(battery['batteryBrand'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Model', PdfGeneratorBase.safeString(battery['batteryModel'])));
        fields.add(PdfGeneratorBase.buildFieldRow('SID', PdfGeneratorBase.safeString(battery['batterySid'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Towers', PdfGeneratorBase.safeString(battery['batteryTowers'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Modules per Tower', PdfGeneratorBase.safeString(battery['batteryModulesPerTower'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Serial Numbers', PdfGeneratorBase.safeString(battery['serialNumbers'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Manufacturer Standards Followed', _yesNo(battery['standardsFollowed'])));
        
        fields.add(PdfGeneratorBase.buildPhotoField('QR Code', battery['photoQrCode'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Connections', battery['photoBatteryConnections'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('EMS Number', battery['photoEmsNumber'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('AC Plug Open', battery['photoAcPlugOpen'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Unit Without Covers', battery['photoBatteryWithoutCovers'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Unit With Covers', battery['photoBatteryWithCovers'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Unit From Distance', battery['photoBatteryFromDistance'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Battery Base Levelled', battery['photoBatteryBase'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Battery Earthing', battery['photoBatteryEarthing'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Battery Tower Final Assembly', battery['photoBatteryTowerFinal'] as String?));
        
        if (i < batteries.length - 1) {
          fields.add(pw.SizedBox(height: 6));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Battery Storage', fields);
  }

//! IDK if they needs it or not 
  // static pw.Widget _buildEquipotentialBondingSection(Map<String, dynamic> data) {
  //   return PdfGeneratorBase.buildSection('Equipotential Bonding Bar', [
  //     PdfGeneratorBase.buildFieldRow('Components Connected as Specified', _yesNo(data['componentsConnected'])),
  //     PdfGeneratorBase.buildFieldRow('Earthing Connected', _yesNo(data['eqEarthingConnected'])),
  //     PdfGeneratorBase.buildFieldRow('UK Connected', _yesNo(data['eqUkConnected'])),
  //     PdfGeneratorBase.buildFieldRow('DC Surge Protection Connected', _yesNo(data['eqDcOvervoltageConnected'])),
  //     PdfGeneratorBase.buildFieldRow('Inverter Connected', _yesNo(data['eqInverterConnected'])),
  //     PdfGeneratorBase.buildPhotoField('Photo Equipotential Bonding', data['photoBonding'] as String?),
  //   ]);
  // }

  static pw.Widget _buildDistributionBoardSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final boards = repeatableData['distribution_board'] ?? [];
    final fields = <pw.Widget>[];
    
    if (boards.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Distribution Board', 'No data'));
    } else {
      for (var i = 0; i < boards.length; i++) {
        final board = boards[i];
        fields.add(pw.Text(
          'Distribution Board #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildPhotoField('Photo', board['photoDistBoard'] as String?));
fields.add(PdfGeneratorBase.buildFieldRow('Additional Details', PdfGeneratorBase.safeString(board['additionalDetails'])
        ));        
        if (i < boards.length - 1) {
          fields.add(pw.SizedBox(height: 6));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Distribution Board', fields);
  }

  static pw.Widget _buildMeterCabinetSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Meter Cabinet', [
      PdfGeneratorBase.buildFieldRow('New Cabinet Installed', _yesNo(data['newCabinetInstalled'])),
      PdfGeneratorBase.buildFieldRow('All Components Installed', _yesNo(data['allComponentsInstalled'])),
      PdfGeneratorBase.buildFieldRow('Touch Protection', _yesNo(data['touchProtection'])),
      PdfGeneratorBase.buildPhotoField('Photo Cabinet', data['photoCabinet'] as String?),
      PdfGeneratorBase.buildFieldRow(
        'APZ Wiring Present',
        _yesNo(data['apzWiring'] ?? data['apzWiringConnected']),
      ),
      PdfGeneratorBase.buildFieldRow('APZ Installed', _yesNo(data['apzInstalled'])),
      PdfGeneratorBase.buildPhotoField('New Fuse (Readable)', data['photoNewFuse'] as String?),
      PdfGeneratorBase.buildPhotoField('Cable in APZ', data['photoApzCable'] as String?),
      PdfGeneratorBase.buildPhotoField('APZ Wiring at Meter', data['photoApzWiringMeter'] as String?),
      PdfGeneratorBase.buildFieldRow('Changes to Existing Electrical System', PdfGeneratorBase.safeString(data['existingSystemChanges'])),
      // PdfGeneratorBase.buildFieldRow(
      //   'PV Operation Does Not Affect Safe Power Supply',
      //   _yesNo(data['safeOperation'] ?? data['gridStabilityEnsured']),
      // ),
      PdfGeneratorBase.buildFieldRow('EnerGrid or Equivalent Installed', _yesNo(data['energridInstalled'])),
      PdfGeneratorBase.buildPhotoField('Photo EnerGrid', data['photoEnergrid'] as String?),
      PdfGeneratorBase.buildPhotoField('PV Label', data['photoPvLabel'] as String?),
      PdfGeneratorBase.buildPhotoField('New Cabinet', data['photoNewCabinet'] as String?),
      PdfGeneratorBase.buildPhotoField('Old Cabinet', data['photoOldCabinet'] as String?),
      PdfGeneratorBase.buildPhotoField('SLS / NH', data['photoSlsOrNh'] as String?),
      PdfGeneratorBase.buildPhotoField('AC Surge Protection', data['photoAcOvervoltage'] as String?),
      PdfGeneratorBase.buildPhotoField('RCD', data['photoRcd'] as String?),
      PdfGeneratorBase.buildPhotoField('Cable Route to New Cabinet', data['photoCableRouteToNewCabinet'] as String?),
      PdfGeneratorBase.buildPhotoField('APZ Cable Inside', data['photoApzCableInside'] as String?),
      PdfGeneratorBase.buildPhotoField('APZ Meter Connections', data['photoApzMeterConnections'] as String?),
    ]);
  }

static pw.Widget _buildProtectionDevicesSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
  final devices = repeatableData['protection_devices'] ?? [];
  final fields = <pw.Widget>[];
  
  if (devices.isEmpty) {
    fields.add(PdfGeneratorBase.buildFieldRow('New Protection Devices', 'No data'));
  } else {
    for (var i = 0; i < devices.length; i++) {
      final device = devices[i];
      fields.add(pw.Text(
        'Protection Device #${i + 1}',
        style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
      ));
      
      fields.add(PdfGeneratorBase.buildPhotoField('Photo', device['photoProtectionDevice'] as String?));
      
      // Since they are now inside the 'device' object, we access them here:
      fields.add(PdfGeneratorBase.buildFieldRow('No Changes Made', _yesNo(device['noChangesMade'])));
      fields.add(PdfGeneratorBase.buildFieldRow('System Stability Tested', _yesNo(device['systemStabilityTested'])));
      fields.add(PdfGeneratorBase.buildFieldRow('EnerGrid Used', _yesNo(device['enerGridUsed'])));
      
      if (i < devices.length - 1) {
        fields.add(pw.SizedBox(height: 10)); // Added a bit more space between devices
      }
    }
  }
  return PdfGeneratorBase.buildSection('New Protection Devices', fields);
}

static pw.Widget _buildMeterRegistrationSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final fields = <pw.Widget>[];
    final registrations = repeatableData['meter_registration'] ?? [];
    final existingMeters = repeatableData['existingMeters'] ?? [];

    // 1. Build Existing Meters (the ones already in your list)
    if (existingMeters.isNotEmpty) {
      for (var i = 0; i < existingMeters.length; i++) {
        final meter = existingMeters[i];
        fields.add(pw.Text('Existing Meter #${i + 1}', style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10)));
        fields.add(PdfGeneratorBase.buildFieldRow('Meter Number', PdfGeneratorBase.safeString(meter['meterNumber'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Purpose', PdfGeneratorBase.safeString(meter['meterType'])));
        fields.add(PdfGeneratorBase.buildPhotoField('Meter Photo', meter['photoMeter'] as String?));
      }
    }

    // 2. Build New Meter Registrations (the repeatable items from YAML)
    for (var i = 0; i < registrations.length; i++) {
      final reg = registrations[i];
      fields.add(pw.SizedBox(height: 8));
      fields.add(pw.Text('Meter Registration #${i + 1}', style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10)));
      
      fields.add(PdfGeneratorBase.buildFieldRow('New Meter Type', PdfGeneratorBase.safeString(reg['newMeterType'])));
      fields.add(PdfGeneratorBase.buildFieldRow('Remote Control Present', _yesNo(reg['remoteControlPrdesent'])));
      
      if (reg['remoteControlPrdesent'] == true || reg['remoteControlPrdesent'] == 'yes') {
        fields.add(PdfGeneratorBase.buildPhotoField('Photo Remote Control', reg['photoRemoteControl'] as String?));
      }
      
      fields.add(PdfGeneratorBase.buildFieldRow('Remove Remote Control', _yesNo(reg['removeRemoteControl'])));
      fields.add(PdfGeneratorBase.buildFieldRow('Meter Consolidation', _yesNo(reg['meterConsolidation'])));
      
      if (reg['meterConsolidation'] == true || reg['meterConsolidation'] == 'yes') {
        fields.add(PdfGeneratorBase.buildFieldRow('Consolidation Description', PdfGeneratorBase.safeString(reg['consolidationDescription'])));
      }
      
      fields.add(PdfGeneratorBase.buildFieldRow('Remarks', PdfGeneratorBase.safeString(reg['meterRemarks'])));
      fields.add(PdfGeneratorBase.buildFieldRow('Removal Required', _yesNo(reg['meterRemovalNeeded'])));
      fields.add(PdfGeneratorBase.buildFieldRow('Replacement Required', _yesNo(reg['meterReplacementNeeded'])));
      fields.add(PdfGeneratorBase.buildPhotoField('Meter Readings', reg['photoMeterReadings'] as String?));
      fields.add(PdfGeneratorBase.buildFieldRow('Measurement Concept', PdfGeneratorBase.safeString(reg['measurementConcept'])));
    }

    return PdfGeneratorBase.buildSection('Meter Registration (IBN)', fields);
  }

  static pw.Widget _buildHeatPumpSection(Map<String, dynamic> data) {
    final ordered = data['heatPumpOrdered'] ?? data['heatPumpRequested'];
    final isOrdered = ordered == true || ordered == 'yes';
    return PdfGeneratorBase.buildSection('Heat Pump Order', [
      PdfGeneratorBase.buildFieldRow('Heat Pump Ordered from MAM Solarbau', _yesNo(ordered)),
      if (isOrdered) ...[
        PdfGeneratorBase.buildPhotoField('Sub-Distribution / ZK Integration', data['photoSubDistribution'] as String?),
        PdfGeneratorBase.buildPhotoField('Heat Pump Fuses (Readable)', data['photoFusesHeatPump'] as String?),
      ],
    ]);
  }

  static pw.Widget _buildCableRoutesSection(Map<String, dynamic> data) {
    final over25m = data['routeOver25m'] == true || data['routeOver25m'] == 'yes';
    return PdfGeneratorBase.buildSection('Cable Routes', [
      PdfGeneratorBase.buildPhotoField('Full AC Cable Route', data['photoCableRoute'] as String?),
      PdfGeneratorBase.buildFieldRow('Cable Route Over 25m', _yesNo(data['routeOver25m'])),
      if (over25m)
        PdfGeneratorBase.buildFieldRow('Additional Meters Installed', PdfGeneratorBase.safeString(data['additionalMeters'])),
      PdfGeneratorBase.buildFieldRow('Notes', PdfGeneratorBase.safeString(data['notes'])),
      PdfGeneratorBase.buildPhotoField('Cable 1', data['photoCable1'] as String?),
      PdfGeneratorBase.buildPhotoField('Cable 2', data['photoCable2'] as String?),
      PdfGeneratorBase.buildPhotoField('Cable 3', data['photoCable3'] as String?),
      PdfGeneratorBase.buildPhotoField('Cable 4', data['photoCable4'] as String?),
    ]);
  }

  static pw.Widget _buildCleanlinessSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Cleanliness', [
      PdfGeneratorBase.buildFieldRow(
        'Waste Removed in Own Vehicle, Site Left Clean',
        _yesNo(data['siteCleanedUp']),
      ),
    ]);
  }

  static pw.Widget _buildFinalAcceptanceSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Final Acceptance', [
      PdfGeneratorBase.buildFieldRow('All Details Recorded and Discussed with Customer', _yesNo(data['detailsRecorded'])),
      // PdfGeneratorBase.buildFieldRow('Measurement Protocol Attached', PdfGeneratorBase.safeString(data['measurementProtocol'])),
      PdfGeneratorBase.buildFieldRow('Completion Date', PdfGeneratorBase.safeString(data['completionDate'])),
      PdfGeneratorBase.buildFieldRow('Completion Time', PdfGeneratorBase.safeString(data['completionTime'])),
      PdfGeneratorBase.buildFieldRow('System Operational', _yesNo(data['systemOperational'])),
      PdfGeneratorBase.buildFieldRow('Customer Briefed', _yesNo(data['customerInformed'])),
      PdfGeneratorBase.buildFieldRow('Invoice Approved', _yesNo(data['invoiceApproved'])),
    ]);
  }

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Remarks', [
      PdfGeneratorBase.buildFieldRow('Remarks', PdfGeneratorBase.safeString(data['remarksGeneral'])),
    ]);
  }

static pw.Widget _buildAdditionalInfoSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
  final infoList = repeatableData['additional_info'] ?? [];
  final fields = <pw.Widget>[];

  if (infoList.isEmpty) {
    fields.add(PdfGeneratorBase.buildFieldRow('Additional Info', 'No data'));
  } else {
    for (var i = 0; i < infoList.length; i++) {
      final item = infoList[i];
      fields.add(pw.Text(
        'Additional Info #${i + 1}',
        style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
      ));
      
      fields.add(PdfGeneratorBase.buildFieldRow('Note', PdfGeneratorBase.safeString(item['note'])));
      fields.add(PdfGeneratorBase.buildPhotoField('Image', item['image'] as String?));
      
      if (i < infoList.length - 1) {
        fields.add(pw.SizedBox(height: 6));
      }
    }
  }
  return PdfGeneratorBase.buildSection('Additional Info', fields);
}


  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Signatures', [
      PdfGeneratorBase.buildFieldRow('Customer Full Name', PdfGeneratorBase.safeString(data['customerFullName'])),
      PdfGeneratorBase.buildSignatureField('Customer / Representative Signature', data['customerSignature'] as String?),
      PdfGeneratorBase.buildDisplayTextField(
        'The plant operator and installation company declare that the above-mentioned system is technically ready for operation within the meaning of § 3 No. 30 EEG (2021) on the date on which the AC and DC acceptance protocols are signed.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'The objection period is 14 days; after this period the acceptance protocol is considered confirmed.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'The executing electrical installer confirms with their signature that the electrical system has been installed, measured and accepted in accordance with the currently applicable DIN-VDE standards as well as TAB and TAR.',
      ),
      PdfGeneratorBase.buildSignatureField('Electrician / On-Site Partner Signature', data['installerSignature'] as String?),
    ]);
  }

  /// Helper: converts bool, 'yes'/'no', or null to 'Yes' / 'No'
  static String _yesNo(dynamic value) {
    if (value == true || value == 'yes') return 'Yes';
    if (value == false || value == 'no') return 'No';
    if (value == 'not_possible') return 'Not Possible';
    return '-';
  }
}