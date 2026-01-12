// models/quality_control_model.dart
class InspectionModel {
  final String id;
  final String itemName;
  final String lotNumber;
  final String orderNumber;
  final String inspector;
  final String warehouse;
  String status; // Pending, Passed, Failed, WaitingApproval
  final String inspectionType; // Incoming, InProcess, Final, Random, Supplier
  final DateTime date;
  int passedItems;
  int failedItems;
  final int totalItems;
  final String? imageUrl;
  final List<String> defects;
  final String? notes;

  InspectionModel({
    required this.id,
    required this.itemName,
    required this.lotNumber,
    required this.orderNumber,
    required this.inspector,
    required this.warehouse,
    required this.status,
    required this.inspectionType,
    required this.date,
    this.passedItems = 0,
    this.failedItems = 0,
    this.totalItems = 0,
    this.imageUrl,
    this.defects = const [],
    this.notes,
  });

  factory InspectionModel.fromJson(Map<String, dynamic> json) {
    return InspectionModel(
      id: json['id'],
      itemName: json['itemName'],
      lotNumber: json['lotNumber'],
      orderNumber: json['orderNumber'],
      inspector: json['inspector'],
      warehouse: json['warehouse'],
      status: json['status'],
      inspectionType: json['inspectionType'],
      date: DateTime.parse(json['date']),
      passedItems: json['passedItems'] ?? 0,
      failedItems: json['failedItems'] ?? 0,
      totalItems: json['totalItems'] ?? 0,
      imageUrl: json['imageUrl'],
      defects: List<String>.from(json['defects'] ?? []),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemName': itemName,
      'lotNumber': lotNumber,
      'orderNumber': orderNumber,
      'inspector': inspector,
      'warehouse': warehouse,
      'status': status,
      'inspectionType': inspectionType,
      'date': date.toIso8601String(),
      'passedItems': passedItems,
      'failedItems': failedItems,
      'totalItems': totalItems,
      'imageUrl': imageUrl,
      'defects': defects,
      'notes': notes,
    };
  }
}

class DefectReport {
  final String id;
  final String inspectionId;
  final String defectType; // Minor, Major, Critical
  final String description;
  final String rootCause;
  final List<String> images;
  final String correctiveAction;
  final String assignedTo;
  final DateTime dueDate;
  final String status; // Open, InProgress, Resolved, Closed
  final String? linkedOrder;
  final String? batchNumber;

  DefectReport({
    required this.id,
    required this.inspectionId,
    required this.defectType,
    required this.description,
    required this.rootCause,
    this.images = const [],
    required this.correctiveAction,
    required this.assignedTo,
    required this.dueDate,
    this.status = 'Open',
    this.linkedOrder,
    this.batchNumber,
  });

  factory DefectReport.fromJson(Map<String, dynamic> json) {
    return DefectReport(
      id: json['id'],
      inspectionId: json['inspectionId'],
      defectType: json['defectType'],
      description: json['description'],
      rootCause: json['rootCause'],
      images: List<String>.from(json['images'] ?? []),
      correctiveAction: json['correctiveAction'],
      assignedTo: json['assignedTo'],
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'] ?? 'Open',
      linkedOrder: json['linkedOrder'],
      batchNumber: json['batchNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inspectionId': inspectionId,
      'defectType': defectType,
      'description': description,
      'rootCause': rootCause,
      'images': images,
      'correctiveAction': correctiveAction,
      'assignedTo': assignedTo,
      'dueDate': dueDate.toIso8601String(),
      'status': status,
      'linkedOrder': linkedOrder,
      'batchNumber': batchNumber,
    };
  }
}

class QCPlan {
  final String id;
  final String productName;
  final String productCode;
  final List<ChecklistItem> checklist;
  final Map<String, dynamic> measurementRules;
  final String samplingMethod; // Fixed, Percentage, Statistical
  final double toleranceLevel;
  final String inspectorLevel;
  final DateTime createdDate;
  final DateTime? expiryDate;

  QCPlan({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.checklist,
    this.measurementRules = const {},
    this.samplingMethod = 'Fixed',
    this.toleranceLevel = 1.0,
    this.inspectorLevel = 'Standard',
    required this.createdDate,
    this.expiryDate,
  });
}

class ChecklistItem {
  final String id;
  final String description;
  final String type; // Visual, Measurement, Functional, Packaging
  final String? unit;
  final double? minValue;
  final double? maxValue;
  final bool isMandatory;

  ChecklistItem({
    required this.id,
    required this.description,
    required this.type,
    this.unit,
    this.minValue,
    this.maxValue,
    this.isMandatory = true,
  });
}

class QualityAlert {
  final String id;
  final String type;
  final String title;
  final String message;
  final DateTime date;
  final String severity; // Low, Medium, High, Critical
  final bool isRead;

  QualityAlert({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.date,
    this.severity = 'Medium',
    this.isRead = false,
  });
}