import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/models/user_model.dart';
import 'package:vision_erp_app/core/providers/theme_notifier.dart';
import 'package:vision_erp_app/screens/app/sidebar_menu_sections/app_localizations.dart';

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

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final String _currentLanguage = 'en';
  bool get isEnglish => _currentLanguage == 'en';

  // Employee information (read-only)
  String get _employeeId => 'EMP-${widget.user.id}';
  String get _position => widget.user.role;
  String get _department => widget.user.department;
  String get _employmentStatus => isEnglish ? 'Active - At the head of his job' : 'نشط - على رأس عمله';
  String get _dateOfBirth => '1990-01-01'; // Example data
  String get _joinDate => '2020-03-15'; // Example data
  String get _gender => isEnglish ? 'Male' : 'ذكر'; // Example data
  String get _age => '34'; // Example data - calculated from date of birth

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _mobileController = TextEditingController(text: widget.user.phone ?? '+966500000000');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
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
            '$_position • $_department',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isEnglish ? 'Employee ID: $_employeeId' : 'رقم الموظف: $_employeeId',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 12, tablet: 13, desktop: 14),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: _responsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isEnglish ? 'Age: $_age' : 'العمر: $_age',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 12, tablet: 13, desktop: 14),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
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
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Full Name' : 'الاسم الكامل',
          value: _nameController.text,
          icon: Icons.person_outline,
          isEditable: true,
          controller: _nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return isEnglish ? 'Please enter your name' : 'يرجى إدخال الاسم';
            }
            return null;
          },
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Email Address' : 'البريد الإلكتروني',
          value: _emailController.text,
          icon: Icons.email_outlined,
          isEditable: true,
          controller: _emailController,
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
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Mobile Number' : 'رقم الجوال',
          value: _mobileController.text,
          icon: Icons.phone_outlined,
          isEditable: true,
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return isEnglish ? 'Please enter your mobile number' : 'يرجى إدخال رقم الجوال';
            }
            return null;
          },
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Date of Birth' : 'تاريخ الميلاد',
          value: _dateOfBirth,
          icon: Icons.cake_outlined,
          isEditable: false,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Gender' : 'الجنس',
          value: _gender,
          icon: Icons.transgender,
          isEditable: false,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Age' : 'العمر',
          value: '$_age ${isEnglish ? 'Years' : 'سنة'}',
          icon: Icons.calendar_today_outlined,
          isEditable: false,
        ),
      ],
    );
  }

  Widget _buildWorkInfoForm(BuildContext context) {
    return Column(
      children: [
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Position' : 'المنصب',
          value: _position,
          icon: Icons.work_outline,
          isEditable: false,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Department' : 'القسم',
          value: _department,
          icon: Icons.business_outlined,
          isEditable: false,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Employee ID' : 'رقم الموظف',
          value: _employeeId,
          icon: Icons.badge_outlined,
          isEditable: false,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Employment Status' : 'حالة التوظيف',
          value: _employmentStatus,
          icon: Icons.assignment_turned_in_outlined,
          isEditable: false,
        ),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
        _buildUniformField(
          context: context,
          label: isEnglish ? 'Join Date' : 'تاريخ الانضمام',
          value: _joinDate,
          icon: Icons.event_available_outlined,
          isEditable: false,
        ),
      ],
    );
  }

  Widget _buildUniformField({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
    required bool isEditable,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
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
          height: _responsiveValue(context, mobile: 56, tablet: 58, desktop: 60), // نفس الارتفاع لجميع الحقول
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          child: isEditable
              ? TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  validator: validator,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
                    color: AppColors.textPrimary,
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
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                  ),
                  child: Row(
                    children: [
                      Container(
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
                      SizedBox(width: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)),
                      Expanded(
                        child: Text(
                          value,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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