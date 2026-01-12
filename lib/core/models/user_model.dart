// models/user_model.dart
class UserModel {
  final String id;
  final String username;
  final String name;
  final String nameNative;
  final String nameForeign;
  final String employeeCode;
  final int? employeeId;
  final String organizationId;
  final bool isCEO;
  final String language;
  final String role;
  final String department;
  final String? email;
  final String? phone;
  final String? token;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.nameNative,
    required this.nameForeign,
    required this.employeeCode,
    this.employeeId,
    required this.organizationId,
    required this.isCEO,
    required this.language,
    required this.role,
    required this.department,
    this.email,
    this.phone,
    this.token,
  });

  // إنشاء من تسجيل الدخول مع بيانات API
  factory UserModel.fromLogin(String username) {
    return UserModel(
      id: '0',
      username: username,
      name: username,
      nameNative: username,
      nameForeign: username,
      employeeCode: '0',
      organizationId: '0',
      isCEO: false,
      language: 'en',
      role: 'Employee',
      department: 'General Department',
      email: '$username@visionerp.com',
      phone: '+966 55 123 4567',
    );
  }

  // إنشاء من بيانات API
  factory UserModel.fromApiResponse(Map<String, dynamic> apiData) {
    final employeeCode = apiData['employeeCode']?.toString() ?? '';
    return UserModel(
      id: apiData['id']?.toString() ?? '0',
      username: apiData['username'] ?? '',
      name: apiData['name'] ?? apiData['username'] ?? '',
      nameNative: apiData['nameNative'] ?? '',
      nameForeign: apiData['nameForeign'] ?? '',
      employeeCode: employeeCode,
      employeeId: int.tryParse(employeeCode),
      organizationId: apiData['organizationId']?.toString() ?? '0',
      isCEO: apiData['isCEO'] ?? false,
      language: apiData['language'] ?? 'en',
      role: apiData['isCEO'] == true ? 'CEO' : 'Employee',
      department: apiData['isCEO'] == true
          ? 'Executive Office'
          : 'Organization ${apiData['organizationId'] ?? 0}',
      email: null, // يمكن إضافته من API إذا كان متوفراً
      phone: null, // يمكن إضافته من API إذا كان متوفراً
      token: apiData['token']?.toString(),
    );
  }

  // تحويل إلى Map للتخزين
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'nameNative': nameNative,
      'nameForeign': nameForeign,
      'employeeCode': employeeCode,
      'employeeId': employeeId,
      'organizationId': organizationId,
      'isCEO': isCEO,
      'language': language,
      'role': role,
      'department': department,
      'email': email,
      'phone': phone,
      'token': token,
    };
  }

  // إنشاء من Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toString() ?? '0',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      nameNative: map['nameNative'] ?? '',
      nameForeign: map['nameForeign'] ?? '',
      employeeCode: map['employeeCode']?.toString() ?? '',
      employeeId: map['employeeId'] is int ? map['employeeId'] : int.tryParse(map['employeeCode']?.toString() ?? ''),
      organizationId: map['organizationId']?.toString() ?? '0',
      isCEO: map['isCEO'] ?? false,
      language: map['language'] ?? 'en',
      role: map['role'] ?? (map['isCEO'] == true ? 'CEO' : 'Employee'),
      department: map['department'] ?? 'General Department',
      email: map['email'],
      phone: map['phone'],
      token: map['token']?.toString(),
    );
  }

  // دالة للحصول على الاسم بناءً على اللغة
  String getNameByLanguage(String lang) {
    if (lang == 'ar' && nameNative.isNotEmpty) {
      return nameNative;
    } else if (nameForeign.isNotEmpty) {
      return nameForeign;
    }
    return name;
  }

  // دالة لمعرفة إذا كان المستخدم هو المدير التنفيذي
  bool get isAdministrator => isCEO;

  // دالة للحصول على معلومات المستخدم كـ String
  @override
  String toString() {
    return 'UserModel{username: $username, name: $name, role: $role, isCEO: $isCEO, org: $organizationId}';
  }
}