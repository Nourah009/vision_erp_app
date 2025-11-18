import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';

class AccountDetailsPage extends StatefulWidget {
  final UserModel user;
  
  const AccountDetailsPage({super.key, required this.user});

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _joinDateController;
  late TextEditingController _employeeIdController;

  // Select option values - استخدام قيم محددة بدلاً من null
  String _selectedPosition = 'software_engineer';
  String _selectedDepartment = 'engineering';
  String _selectedEmploymentStatus = 'active_head';

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _currentLanguage = 'en';
  bool get isEnglish => _currentLanguage == 'en';

  // Options for dropdowns with consistent values
  final Map<String, String> _positionOptions = {
    'software_engineer': 'Software Engineer',
    'senior_developer': 'Senior Developer',
    'team_lead': 'Team Lead',
    'project_manager': 'Project Manager',
    'product_manager': 'Product Manager',
    'ui_ux_designer': 'UI/UX Designer',
    'qa_engineer': 'QA Engineer',
    'devops_engineer': 'DevOps Engineer',
    'system_admin': 'System Administrator',
    'data_analyst': 'Data Analyst'
  };

  final Map<String, String> _departmentOptions = {
    'engineering': 'Engineering',
    'product_development': 'Product Development',
    'quality_assurance': 'Quality Assurance',
    'design': 'Design',
    'human_resources': 'Human Resources',
    'finance': 'Finance',
    'marketing': 'Marketing',
    'sales': 'Sales',
    'customer_support': 'Customer Support',
    'operations': 'Operations'
  };

  final Map<String, String> _employmentStatusOptions = {
    'active_head': 'Active - At the head of his job',
    'active_remote': 'Active - Working remotely',
    'active_vacation': 'Active - On vacation',
    'active_sick': 'Active - On sick leave',
    'probation': 'Probation period',
    'inactive_resigned': 'Inactive - Resigned',
    'inactive_terminated': 'Inactive - Terminated',
    'inactive_retired': 'Inactive - Retired'
  };

  // Arabic translations for options
  final Map<String, String> _positionOptionsAr = {
    'software_engineer': 'مهندس برمجيات',
    'senior_developer': 'مطور أول',
    'team_lead': 'قائد فريق',
    'project_manager': 'مدير مشروع',
    'product_manager': 'مدير منتج',
    'ui_ux_designer': 'مصمم واجهات',
    'qa_engineer': 'مهندس ضمان الجودة',
    'devops_engineer': 'مهندس ديفأوبس',
    'system_admin': 'مسؤول أنظمة',
    'data_analyst': 'محلل بيانات'
  };

  final Map<String, String> _departmentOptionsAr = {
    'engineering': 'الهندسة',
    'product_development': 'تطوير المنتج',
    'quality_assurance': 'ضمان الجودة',
    'design': 'التصميم',
    'human_resources': 'الموارد البشرية',
    'finance': 'المالية',
    'marketing': 'التسويق',
    'sales': 'المبيعات',
    'customer_support': 'دعم العملاء',
    'operations': 'العمليات'
  };

  final Map<String, String> _employmentStatusOptionsAr = {
    'active_head': 'نشط - على رأس عمله',
    'active_remote': 'نشط - يعمل عن بُعد',
    'active_vacation': 'نشط - في إجازة',
    'active_sick': 'نشط - في إجازة مرضية',
    'probation': 'فترة تجريبية',
    'inactive_resigned': 'غير نشط - مستقيل',
    'inactive_terminated': 'غير نشط - مفصول',
    'inactive_retired': 'غير نشط - متقاعد'
  };

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _mobileController = TextEditingController(text: widget.user.phone ?? '+966500000000');
    _dateOfBirthController = TextEditingController(text: '1990-01-01');
    _joinDateController = TextEditingController(text: '2020-03-15');
    _employeeIdController = TextEditingController(text: 'EMP-${widget.user.id ?? '001'}');

    // Initialize dropdown values with safe defaults
    _initializeDropdownValues();
  }

  void _initializeDropdownValues() {
    // تحديد القيم الافتراضية بناءً على بيانات المستخدم
    _selectedPosition = _findMatchingPosition(widget.user.role);
    _selectedDepartment = _findMatchingDepartment(widget.user.department);
    _selectedEmploymentStatus = 'active_head'; // القيمة الافتراضية
  }

  String _findMatchingPosition(String? userRole) {
    if (userRole == null) return 'software_engineer';
    
    final role = userRole.toLowerCase();
    if (role.contains('senior') || role.contains('مطور أول')) return 'senior_developer';
    if (role.contains('lead') || role.contains('قائد')) return 'team_lead';
    if (role.contains('manager') || role.contains('مدير')) return 'project_manager';
    if (role.contains('design') || role.contains('مصمم')) return 'ui_ux_designer';
    if (role.contains('qa') || role.contains('جودة')) return 'qa_engineer';
    if (role.contains('devops')) return 'devops_engineer';
    if (role.contains('admin') || role.contains('مسؤول')) return 'system_admin';
    if (role.contains('analyst') || role.contains('محلل')) return 'data_analyst';
    
    return 'software_engineer'; // القيمة الافتراضية
  }

  String _findMatchingDepartment(String? userDepartment) {
    if (userDepartment == null) return 'engineering';
    
    final dept = userDepartment.toLowerCase();
    if (dept.contains('product') || dept.contains('منتج')) return 'product_development';
    if (dept.contains('quality') || dept.contains('جودة')) return 'quality_assurance';
    if (dept.contains('design') || dept.contains('تصميم')) return 'design';
    if (dept.contains('human') || dept.contains('بشرية')) return 'human_resources';
    if (dept.contains('finance') || dept.contains('مالية')) return 'finance';
    if (dept.contains('marketing') || dept.contains('تسويق')) return 'marketing';
    if (dept.contains('sales') || dept.contains('مبيعات')) return 'sales';
    if (dept.contains('support') || dept.contains('دعم')) return 'customer_support';
    if (dept.contains('operations') || dept.contains('عمليات')) return 'operations';
    
    return 'engineering'; // القيمة الافتراضية
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dateOfBirthController.dispose();
    _joinDateController.dispose();
    _employeeIdController.dispose();
    super.dispose();
  }

  double _responsiveValue(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200 && desktop != null) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  Future<void> _selectDate(BuildContext context, String field) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      final formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      setState(() {
        if (field == 'dob') {
          _dateOfBirthController.text = formattedDate;
        } else if (field == 'join') {
          _joinDateController.text = formattedDate;
        }
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.secondaryColor,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                isEnglish ? 'Success' : 'تم بنجاح',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isEnglish 
                  ? 'Your account details have been updated successfully!'
                  : 'تم تحديث تفاصيل حسابك بنجاح!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isEnglish ? 'Continue' : 'متابعة',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEnglish ? 'Update Profile Picture' : 'تحديث صورة الملف الشخصي',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildImageSourceOption(
                icon: Icons.camera_alt,
                title: isEnglish ? 'Take Photo' : 'التقاط صورة',
                onTap: () {
                  Navigator.pop(context);
                  // Implement camera functionality
                },
              ),
              const SizedBox(height: 12),
              _buildImageSourceOption(
                icon: Icons.photo_library,
                title: isEnglish ? 'Choose from Gallery' : 'اختر من المعرض',
                onTap: () {
                  Navigator.pop(context);
                  // Implement gallery functionality
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  isEnglish ? 'Cancel' : 'إلغاء',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Cairo'),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Colors.grey[50],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;
    final appLocalizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          appLocalizations.accountDetails,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              ),
            )
          else
            IconButton(
              icon: Icon(Icons.save, color: AppColors.secondaryColor),
              onPressed: _saveChanges,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
            vertical: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16),
          ),
          child: Column(
            children: [
              // Enhanced Profile Section
              _buildEnhancedProfileSection(context),
              SizedBox(height: _responsiveValue(context, mobile: 32, tablet: 36, desktop: 40)),
              
              // Personal Information Card
              _buildInfoCard(
                title: isEnglish ? 'Personal Information' : 'المعلومات الشخصية',
                icon: Icons.person_outline,
                child: _buildPersonalInfoForm(context),
              ),
              
              SizedBox(height: _responsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),
              
              // Work Information Card
              _buildInfoCard(
                title: isEnglish ? 'Work Information' : 'معلومات العمل',
                icon: Icons.work_outline,
                child: _buildWorkInfoForm(context),
              ),
              
              SizedBox(height: _responsiveValue(context, mobile: 32, tablet: 36, desktop: 40)),
              
              // Action Buttons
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedProfileSection(BuildContext context) {
    final currentPosition = isEnglish 
        ? _positionOptions[_selectedPosition]!
        : _positionOptionsAr[_selectedPosition]!;
    
    final currentDepartment = isEnglish 
        ? _departmentOptions[_selectedDepartment]!
        : _departmentOptionsAr[_selectedDepartment]!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor.withOpacity(0.9),
            AppColors.accentBlue.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: _responsiveValue(context, mobile: 100, tablet: 120, desktop: 140),
                height: _responsiveValue(context, mobile: 100, tablet: 120, desktop: 140),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: _responsiveValue(context, mobile: 50, tablet: 60, desktop: 70),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: _responsiveValue(context, mobile: 0, tablet: 5, desktop: 10),
                child: GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: Container(
                    width: _responsiveValue(context, mobile: 36, tablet: 40, desktop: 44),
                    height: _responsiveValue(context, mobile: 36, tablet: 40, desktop: 44),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.primaryColor,
                      size: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
          Text(
            widget.user.username,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 20, tablet: 22, desktop: 24),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: _responsiveValue(context, mobile: 4, tablet: 6, desktop: 8)),
          Text(
            '$currentPosition • $currentDepartment',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isEnglish ? 'Employee ID: ${_employeeIdController.text}' : 'رقم الموظف: ${_employeeIdController.text}',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: _responsiveValue(context, mobile: 12, tablet: 13, desktop: 14),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // Card Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoForm(BuildContext context) {
    return Column(
      children: [
        _buildEnhancedFormField(
          context: context,
          label: isEnglish ? 'Full Name' : 'الاسم الكامل',
          controller: _nameController,
          icon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return isEnglish ? 'Please enter your name' : 'يرجى إدخال الاسم';
            }
            return null;
          },
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildEnhancedFormField(
          context: context,
          label: isEnglish ? 'Email Address' : 'البريد الإلكتروني',
          controller: _emailController,
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return isEnglish ? 'Please enter your email' : 'يرجى إدخال البريد الإلكتروني';
            }
            if (!value.contains('@')) {
              return isEnglish ? 'Please enter a valid email' : 'يرجى إدخال بريد إلكتروني صحيح';
            }
            return null;
          },
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildEnhancedFormField(
          context: context,
          label: isEnglish ? 'Mobile Number' : 'رقم الجوال',
          controller: _mobileController,
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return isEnglish ? 'Please enter your mobile number' : 'يرجى إدخال رقم الجوال';
            }
            return null;
          },
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildDateField(
          context: context,
          label: isEnglish ? 'Date of Birth' : 'تاريخ الميلاد',
          controller: _dateOfBirthController,
          onTap: () => _selectDate(context, 'dob'),
        ),
      ],
    );
  }

  Widget _buildWorkInfoForm(BuildContext context) {
    return Column(
      children: [
        // Position Dropdown
        _buildDropdownField(
          context: context,
          label: isEnglish ? 'Position' : 'المنصب',
          value: _selectedPosition,
          items: isEnglish ? _positionOptions : _positionOptionsAr,
          onChanged: (String? newValue) {
            setState(() {
              _selectedPosition = newValue!;
            });
          },
          icon: Icons.work_outline,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        
        // Department Dropdown
        _buildDropdownField(
          context: context,
          label: isEnglish ? 'Department' : 'القسم',
          value: _selectedDepartment,
          items: isEnglish ? _departmentOptions : _departmentOptionsAr,
          onChanged: (String? newValue) {
            setState(() {
              _selectedDepartment = newValue!;
            });
          },
          icon: Icons.business_outlined,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        
        // Employee ID (Read-only)
        _buildEnhancedFormField(
          context: context,
          label: isEnglish ? 'Employee ID' : 'رقم الموظف',
          controller: _employeeIdController,
          icon: Icons.badge_outlined,
          readOnly: true,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        
        // Employment Status Dropdown
        _buildDropdownField(
          context: context,
          label: isEnglish ? 'Employment Status' : 'حالة التوظيف',
          value: _selectedEmploymentStatus,
          items: isEnglish ? _employmentStatusOptions : _employmentStatusOptionsAr,
          onChanged: (String? newValue) {
            setState(() {
              _selectedEmploymentStatus = newValue!;
            });
          },
          icon: Icons.assignment_turned_in_outlined,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        
        // Join Date
        _buildDateField(
          context: context,
          label: isEnglish ? 'Join Date' : 'تاريخ الانضمام',
          controller: _joinDateController,
          onTap: () => _selectDate(context, 'join'),
        ),
      ],
    );
  }

  Widget _buildEnhancedFormField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            validator: validator,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
              color: readOnly ? Colors.grey : AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                vertical: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: 18,
                ),
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required String value,
    required Map<String, String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButtonFormField<String>(
              value: value,
              items: items.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(
                    entry.value,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: _responsiveValue(context, mobile: 8, tablet: 10, desktop: 12),
                  vertical: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.primaryColor,
              ),
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
              vertical: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                ),
                SizedBox(width: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)),
                Expanded(
                  child: Text(
                    controller.text.isEmpty 
                      ? (isEnglish ? 'Select date' : 'اختر التاريخ')
                      : controller.text,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
                      color: controller.text.isEmpty 
                        ? Colors.grey 
                        : AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: AppColors.primaryColor),
            ),
            child: Text(
              isEnglish ? 'Cancel' : 'إلغاء',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(width: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
        // Save Button
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    isEnglish ? 'Save Changes' : 'حفظ التغييرات',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}