// screens/app/about_us_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
          isEnglish ? 'About Vision ERP' : 'عن Vision ERP',
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
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            _buildHeroSection(context, isEnglish),
            
            const SizedBox(height: 40),
            
            // Company Overview
            _buildSection(
              context,
              Icons.business,
              isEnglish ? 'Company Overview' : 'نظرة عامة على الشركة',
              isEnglish
                  ? 'Vision ERP is a comprehensive enterprise resource planning system designed to improve organizational efficiency and streamline operations across all departments. Our platform integrates various business functions into a unified system.'
                  : 'Vision ERP هو نظام شامل لتخطيط موارد المؤسسات مصمم لتحسين الكفاءة التنظيمية وتبسيط العمليات عبر جميع الأقسام. تدمج منصتنا وظائف الأعمال المختلفة في نظام موحد.',
            ),
            
            const SizedBox(height: 32),
            
            // Mission & Vision Row
            Row(
              children: [
                Expanded(
                  child: _buildMissionVisionCard(
                    context,
                    Icons.flag,
                    isEnglish ? 'Our Mission' : 'رسالتنا',
                    isEnglish
                        ? 'To deliver high-quality services and innovative digital solutions that empower business growth, enhance productivity, and drive digital transformation.'
                        : 'تقديم خدمات عالية الجودة وحلول رقمية مبتكرة تمكن نمو الأعمال وتعزز الإنتاجية وتدفع التحول الرقمي.',
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMissionVisionCard(
                    context,
                    Icons.visibility,
                    isEnglish ? 'Our Vision' : 'رؤيتنا',
                    isEnglish
                        ? 'To be a leading provider of modern ERP solutions that simplify workflows, enhance productivity, and transform businesses through cutting-edge technology.'
                        : 'أن نكون المزود الرائد لحلول ERP الحديثة التي تبسط سير العمل وتعزز الإنتاجية وتحول الأعمال من خلال التكنولوجيا المتطورة.',
                    Colors.orange,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Core Values
            _buildCoreValuesSection(context, isEnglish),
            
            const SizedBox(height: 32),
            
            // Team Section
            _buildTeamSection(context, isEnglish),
            
            const SizedBox(height: 32),
            
            // Technology Stack
            _buildTechnologySection(context, isEnglish),
            
            const SizedBox(height: 32),
            
            // Contact Information
            _buildContactSection(context, isEnglish),
            
            const SizedBox(height: 32),
            
            // Version & Legal
            _buildFooterSection(context, isEnglish),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isEnglish) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor.withOpacity(0.15),
            AppColors.secondaryColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor,
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 40,
            ),
          ),
          
          const SizedBox(height: 20),
          
          Text(
            'Vision ERP',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              letterSpacing: 0.5,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            isEnglish 
                ? 'Enterprise Resource Planning'
                : 'تخطيط موارد المؤسسات',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, IconData icon, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Text(
          content,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildMissionVisionCard(BuildContext context, IconData icon, String title, String content, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            content,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoreValuesSection(BuildContext context, bool isEnglish) {
    final coreValues = isEnglish
        ? [
            {'value': 'Integrity', 'icon': Icons.verified_user, 'color': Colors.green},
            {'value': 'Transparency', 'icon': Icons.visibility, 'color': Colors.blue},
            {'value': 'Innovation', 'icon': Icons.auto_awesome, 'color': Colors.purple},
            {'value': 'Customer Focus', 'icon': Icons.people, 'color': Colors.orange},
            {'value': 'Teamwork', 'icon': Icons.handshake, 'color': Colors.teal},
            {'value': 'Excellence', 'icon': Icons.star, 'color': Colors.red},
          ]
        : [
            {'value': 'النزاهة', 'icon': Icons.verified_user, 'color': Colors.green},
            {'value': 'الشفافية', 'icon': Icons.visibility, 'color': Colors.blue},
            {'value': 'الابتكار', 'icon': Icons.auto_awesome, 'color': Colors.purple},
            {'value': 'التركيز على العميل', 'icon': Icons.people, 'color': Colors.orange},
            {'value': 'العمل الجماعي', 'icon': Icons.handshake, 'color': Colors.teal},
            {'value': 'التميز', 'icon': Icons.star, 'color': Colors.red},
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.psychology,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              isEnglish ? 'Core Values' : 'القيم الأساسية',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.4,
          ),
          itemCount: coreValues.length,
          itemBuilder: (context, index) {
            return _buildValueCard(
              context,
              coreValues[index]['value'] as String,
              coreValues[index]['icon'] as IconData,
              coreValues[index]['color'] as Color,
            );
          },
        ),
      ],
    );
  }

  Widget _buildValueCard(BuildContext context, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(BuildContext context, bool isEnglish) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.people,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              isEnglish ? 'Our Team' : 'فريقنا',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              Text(
                isEnglish 
                    ? 'Developed and maintained by the Vision ERP Development Team'
                    : 'تم التطوير والصيانة بواسطة فريق تطوير Vision ERP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isEnglish
                    ? 'A dedicated team of developers, designers, and business analysts committed to delivering exceptional ERP solutions.'
                    : 'فريق مخصص من المطورين والمصممين ومحللي الأعمال ملتزم بتقديم حلول ERP استثنائية.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTechnologySection(BuildContext context, bool isEnglish) {
    final technologies = [
      {'name': 'Flutter', 'icon': Icons.mobile_friendly, 'color': Colors.blue},
      {'name': 'Dart', 'icon': Icons.code, 'color': Colors.blueAccent},
      {'name': 'REST API', 'icon': Icons.cloud, 'color': Colors.green},
      {'name': 'Firebase', 'icon': Icons.local_fire_department, 'color': Colors.orange},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.architecture,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              isEnglish ? 'Technology Stack' : 'التقنيات المستخدمة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              Text(
                isEnglish
                    ? 'Built with modern technologies for optimal performance'
                    : 'مبني بتقنيات حديثة لأداء مثالي',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: technologies.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: (tech['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (tech['color'] as Color).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          tech['icon'] as IconData,
                          color: tech['color'] as Color,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          tech['name'] as String,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: tech['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context, bool isEnglish) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.contact_mail,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              isEnglish ? 'Contact Information' : 'معلومات الاتصال',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        _buildContactItem(
          context,
          Icons.email,
          isEnglish ? 'Email' : 'البريد الإلكتروني',
          'info@visionerp.com',
          Colors.blue,
        ),
        
        const SizedBox(height: 12),
        
        _buildContactItem(
          context,
          Icons.phone,
          isEnglish ? 'Phone' : 'الهاتف',
          '+966 12 345 6789',
          Colors.green,
        ),
        
        const SizedBox(height: 12),
        
        _buildContactItem(
          context,
          Icons.language,
          isEnglish ? 'Website' : 'الموقع الإلكتروني',
          'www.visionerp.com',
          Colors.purple,
        ),
        
        const SizedBox(height: 12),
        
        _buildContactItem(
          context,
          Icons.location_on,
          isEnglish ? 'Address' : 'العنوان',
          isEnglish 
              ? 'Riyadh, Saudi Arabia'
              : 'الرياض، المملكة العربية السعودية',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection(BuildContext context, bool isEnglish) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor.withOpacity(0.1),
            AppColors.secondaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Vision ERP',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            isEnglish
                ? 'Version 1.4.2 – Last updated October 2025'
                : 'الإصدار 1.4.2 – آخر تحديث أكتوبر 2025',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            '© 2025 Vision ERP. ${isEnglish ? 'All rights reserved.' : 'جميع الحقوق محفوظة.'}',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}