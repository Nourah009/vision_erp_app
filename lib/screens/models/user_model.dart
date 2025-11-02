// models/user_model.dart
class UserModel {
  final String username;
  final String role;
  final String department;
  final String? email;
  final String? phone;

  UserModel({
    required this.username,
    required this.role,
    required this.department,
    this.email,
    this.phone,
  });

  // Create from login - أكثر مرونة
  factory UserModel.fromLogin(String username) {
    // يمكن جلب هذه البيانات من API أو قاعدة بيانات لاحقاً
    // حالياً نستخدم بيانات افتراضية بناءً على اسم المستخدم
    return UserModel(
      username: username,
      role: _getRoleFromUsername(username),
      department: _getDepartmentFromUsername(username),
      email: '$username@visionerp.com',
      phone: '+966 55 123 4567',
    );
  }

  // دالة مساعدة لتحديد الدور بناءً على اسم المستخدم
  static String _getRoleFromUsername(String username) {
    if (username.toLowerCase().contains('admin')) {
      return 'System Administrator';
    } else if (username.toLowerCase().contains('manager')) {
      return 'Manager';
    } else if (username.toLowerCase().contains('sales')) {
      return 'Sales Representative';
    } else {
      return 'Employee';
    }
  }

  // دالة مساعدة لتحديد القسم بناءً على اسم المستخدم
  static String _getDepartmentFromUsername(String username) {
    if (username.toLowerCase().contains('sales')) {
      return 'Sales Department';
    } else if (username.toLowerCase().contains('hr')) {
      return 'Human Resources';
    } else if (username.toLowerCase().contains('it')) {
      return 'IT Department';
    } else if (username.toLowerCase().contains('finance')) {
      return 'Finance Department';
    } else {
      return 'General Department';
    }
  }

  // Convert to map for storage
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'role': role,
      'department': department,
      'email': email,
      'phone': phone,
    };
  }

  // Create from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      role: map['role'] ?? 'Employee',
      department: map['department'] ?? 'General Department',
      email: map['email'],
      phone: map['phone'],
    );
  }
}