// human_resources_overview_page.dart - نسخة مبسطة
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/providers/theme_notifier.dart';
import 'package:vision_erp_app/services/localization_service.dart';

class HumanResourcesOverviewPage extends StatelessWidget {
  const HumanResourcesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;
    final localizationService = Provider.of<LocalizationService>(context);
    final isEnglish = localizationService.isEnglish();

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEnglish ? 'Human Resources' : 'الموارد البشرية',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section - مبسطة
            _buildSimpleHeroSection(context, isEnglish),
            
            const SizedBox(height: 30),
            
            // HR Overview
            _buildSimpleSection(
              Icons.business_center,
              isEnglish ? 'HR System Overview' : 'نظرة عامة على النظام',
              isEnglish
                  ? 'Complete Human Resources management system designed to streamline all HR operations including employee management, attendance tracking, payroll processing, and performance evaluation.'
                  : 'نظام متكامل لإدارة الموارد البشرية مصمم لتبسيط جميع العمليات بما في ذلك إدارة الموظفين، تتبع الحضور، معالجة الرواتب، وتقييم الأداء.',
            ),
            
            const SizedBox(height: 30),
            
            // Key Features
            Text(
              isEnglish ? 'Key Features' : 'الميزات الرئيسية',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            
            const SizedBox(height: 15),
            
            _buildFeaturesList(context, isEnglish),
            
            const SizedBox(height: 30),
            
            // Modules
            Text(
              isEnglish ? 'Available Modules' : 'الوحدات المتاحة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            
            const SizedBox(height: 15),
            
            _buildModulesGrid(context, isEnglish),
            
            const SizedBox(height: 30),
            
            // Login Note
            _buildLoginNote(context, isEnglish),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleHeroSection(BuildContext context, bool isEnglish) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.people,
              color: Colors.white,
              size: 36,
            ),
          ),
          
          const SizedBox(width: 20),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEnglish ? 'Human Resources' : 'الموارد البشرية',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                
                const SizedBox(height: 6),
                
                Text(
                  isEnglish 
                      ? 'Employee Management System'
                      : 'نظام إدارة الموظفين',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleSection(IconData icon, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesList(BuildContext context, bool isEnglish) {
    final features = isEnglish
        ? [
            {'icon': Icons.person, 'text': 'Employee Database Management'},
            {'icon': Icons.access_time, 'text': 'Attendance & Time Tracking'},
            {'icon': Icons.attach_money, 'text': 'Automated Payroll Processing'},
            {'icon': Icons.work, 'text': 'Recruitment & Hiring Process'},
            {'icon': Icons.assessment, 'text': 'Performance Evaluation'},
            {'icon': Icons.school, 'text': 'Training & Development'},
          ]
        : [
            {'icon': Icons.person, 'text': 'إدارة قاعدة بيانات الموظفين'},
            {'icon': Icons.access_time, 'text': 'تتبع الحضور والوقت'},
            {'icon': Icons.attach_money, 'text': 'معالجة الرواتب الآلية'},
            {'icon': Icons.work, 'text': 'التوظيف وعملية التعيين'},
            {'icon': Icons.assessment, 'text': 'تقييم الأداء'},
            {'icon': Icons.school, 'text': 'التدريب والتطوير'},
          ];

    return Column(
      children: features.map((feature) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 15),
              
              Expanded(
                child: Text(
                  feature['text'] as String,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildModulesGrid(BuildContext context, bool isEnglish) {
    final modules = isEnglish
        ? [
            'Employee Profiles',
            'Attendance System',
            'Leave Management',
            'Payroll System',
            'Recruitment Portal',
            'Training Center',
            'Performance Reviews',
            'HR Analytics',
          ]
        : [
            'ملفات الموظفين',
            'نظام الحضور',
            'إدارة الإجازات',
            'نظام الرواتب',
            'بوابة التوظيف',
            'مركز التدريب',
            'تقييمات الأداء',
            'تحليلات الموارد البشرية',
          ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: modules.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _getModuleColor(index).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _getModuleColor(index).withOpacity(0.3),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getModuleIcon(index),
                color: _getModuleColor(index),
                size: 22,
              ),
              const SizedBox(height: 8),
              Text(
                modules[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _getModuleColor(index),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginNote(BuildContext context, bool isEnglish) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.blueGrey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                isEnglish ? 'Note' : 'ملاحظة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          Text(
            isEnglish
                ? 'Login required to access full HR features including employee management, attendance tracking, and payroll processing.'
                : 'يتطلب تسجيل الدخول للوصول إلى جميع ميزات الموارد البشرية بما في ذلك إدارة الموظفين، تتبع الحضور، ومعالجة الرواتب.',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: Colors.blueGrey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // Helper functions for module styling
  IconData _getModuleIcon(int index) {
    final icons = [
      Icons.person_outline,
      Icons.access_time,
      Icons.beach_access,
      Icons.payments,
      Icons.work_outline,
      Icons.school_outlined,
      Icons.assessment_outlined,
      Icons.analytics_outlined,
    ];
    return icons[index % icons.length];
  }

  Color _getModuleColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.cyan,
    ];
    return colors[index % colors.length];
  }
}