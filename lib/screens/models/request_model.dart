class RequestModel {
  final int requestId;
  final int organizationId;
  final String customerName;
  final String customerEmail;
  final String requestSubject;
  final String requestBody;
  final int serviceId;
  final int customerMobile;
  final DateTime createDateTime;
  final DateTime modifyDateTime;
  final bool isResponded;

  const RequestModel({
    required this.requestId,
    required this.organizationId,
    required this.customerName,
    required this.customerEmail,
    required this.requestSubject,
    required this.requestBody,
    required this.serviceId,
    required this.customerMobile,
    required this.createDateTime,
    required this.modifyDateTime,
    required this.isResponded,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        requestId: json['requestId'] as int? ?? 0,
        organizationId: json['organizationId'] as int? ?? 1,
        customerName: json['customerName'] as String? ?? '',
        customerEmail: json['customerEmail'] as String? ?? '',
        requestSubject: json['requestSubject'] as String? ?? '',
        requestBody: json['requestBody'] as String? ?? '',
        customerMobile: json['customerMobile'] as int? ?? 0,
        serviceId: json['serviceId'] as int? ?? 0,
        createDateTime: DateTime.tryParse(json['createDateTime'] as String? ?? '') ?? DateTime.now(),
        modifyDateTime: DateTime.tryParse(json['modifyDateTime'] as String? ?? '') ?? DateTime.now(),
        isResponded: json['isResponded'] as bool? ?? json['isResposed'] as bool? ?? false,
      );
    
  Map<String, dynamic> toJson() => {
        'requestId': requestId,
        'organizationId': organizationId,
        'customerName': customerName,
        'customerEmail': customerEmail,
        'requestSubject': requestSubject,
        'requestBody': requestBody,
        'customerMobile': customerMobile,
        'serviceId': serviceId,
        'createDateTime': createDateTime.toIso8601String(),
        'modifyDateTime': modifyDateTime.toIso8601String(),
        'isResponded': isResponded,
      };

  RequestModel copyWith({
    int? requestId,
    int? organizationId,
    String? customerName,
    String? customerEmail,
    String? requestSubject,
    String? requestBody,
    int? serviceId,
    int? customerMobile,
    DateTime? createDateTime,
    DateTime? modifyDateTime,
    bool? isResponded,
  }) {
    return RequestModel(
      requestId: requestId ?? this.requestId,
      organizationId: organizationId ?? this.organizationId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      requestSubject: requestSubject ?? this.requestSubject,
      requestBody: requestBody ?? this.requestBody,
      serviceId: serviceId ?? this.serviceId,
      customerMobile: customerMobile ?? this.customerMobile,
      createDateTime: createDateTime ?? this.createDateTime,
      modifyDateTime: modifyDateTime ?? this.modifyDateTime,
      isResponded: isResponded ?? this.isResponded,
    );
  }

  @override
  String toString() {
    return 'RequestModel(requestId: $requestId, customerName: $customerName, requestSubject: $requestSubject, isResponded: $isResponded)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RequestModel &&
      other.requestId == requestId &&
      other.organizationId == organizationId &&
      other.customerName == customerName &&
      other.customerEmail == customerEmail &&
      other.requestSubject == requestSubject &&
      other.requestBody == requestBody &&
      other.serviceId == serviceId &&
      other.customerMobile == customerMobile &&
      other.createDateTime == createDateTime &&
      other.modifyDateTime == modifyDateTime &&
      other.isResponded == isResponded;
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
      organizationId.hashCode ^
      customerName.hashCode ^
      customerEmail.hashCode ^
      requestSubject.hashCode ^
      requestBody.hashCode ^
      serviceId.hashCode ^
      customerMobile.hashCode ^
      createDateTime.hashCode ^
      modifyDateTime.hashCode ^
      isResponded.hashCode;
  }
}