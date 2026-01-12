import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/providers/theme_notifier.dart';
import 'package:vision_erp_app/services/localization_service.dart';

class CustomerRelationsOverviewPage extends StatelessWidget {
  const CustomerRelationsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;
    final localizationService = Provider.of<LocalizationService>(context);
    final isEnglish = localizationService.isEnglish();
    final screenWidth = MediaQuery.of(context).size.width;

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
          isEnglish ? 'Customer Relations' : 'علاقات العملاء',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth > 600 ? 24 : 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 600 ? 40 : 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            _buildHeroSection(context, isEnglish, screenWidth),
            
            SizedBox(height: screenWidth > 600 ? 40 : 30),
            
            // Overview Section
            _buildOverviewSection(context, isEnglish, screenWidth),
            
            SizedBox(height: screenWidth > 600 ? 40 : 30),
            
            // Key Features Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? 8 : 0),
              child: Text(
                isEnglish ? 'Key Features' : 'الميزات الرئيسية',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 24 : 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            
            SizedBox(height: screenWidth > 600 ? 20 : 15),
            
            // Features List
            _buildFeaturesList(context, isEnglish, screenWidth),
            
            SizedBox(height: screenWidth > 600 ? 40 : 30),
            
            // Communication Channels Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? 8 : 0),
              child: Text(
                isEnglish ? 'Communication Channels' : 'قنوات التواصل',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 24 : 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            
            SizedBox(height: screenWidth > 600 ? 20 : 15),
            
            // Channels Grid
            _buildChannelsGrid(context, isEnglish, screenWidth),
            
            SizedBox(height: screenWidth > 600 ? 40 : 30),
            
            // Statistics Section
            _buildStatisticsSection(context, isEnglish, screenWidth),
            
            SizedBox(height: screenWidth > 600 ? 40 : 30),
            
            // Action Buttons
            _buildActionButtons(context, isEnglish, screenWidth),
            
            SizedBox(height: screenWidth > 600 ? 40 : 30),
            
            // Login Note
            _buildLoginNote(context, isEnglish, screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isEnglish, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth > 600 ? 32 : 24),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.withOpacity(0.2)),
      ),
      child: screenWidth > 600
          ? Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.people_alt, color: Colors.white, size: 40),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Customer Relations' : 'علاقات العملاء',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isEnglish ? 'Customer Relationship Management' : 'إدارة علاقات العملاء',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          color: Colors.teal[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.people_alt, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Customer Relations' : 'علاقات العملاء',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isEnglish ? 'Customer Relationship Management' : 'إدارة علاقات العملاء',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          color: Colors.teal[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildOverviewSection(BuildContext context, bool isEnglish, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.group,
              color: Colors.teal,
              size: screenWidth > 600 ? 28 : 24,
            ),
            SizedBox(width: screenWidth > 600 ? 16 : 12),
            Text(
              isEnglish ? 'Customer Relations Overview' : 'نظرة عامة على علاقات العملاء',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: screenWidth > 600 ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth > 600 ? 16 : 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(screenWidth > 600 ? 20 : 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Text(
            isEnglish
                ? 'Powerful Customer Relationship Management (CRM) system designed to manage customer interactions, track communication history, improve customer satisfaction, and build long-term relationships through personalized service and efficient support.'
                : 'نظام شامل لإدارة علاقات العملاء (CRM) مصمم لإدارة تفاعلات العملاء، وتتبع سجل الاتصالات، وتحسين رضا العملاء، وبناء علاقات طويلة الأجل من خلال الخدمة المخصصة والدعم الفعال.',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: screenWidth > 600 ? 16 : 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesList(BuildContext context, bool isEnglish, double screenWidth) {
    final features = isEnglish
        ? [
            {'icon': Icons.person_add, 'text': 'Customer Database Management'},
            {'icon': Icons.history, 'text': 'Interaction History Tracking'},
            {'icon': Icons.support_agent, 'text': 'Support Ticket System'},
            {'icon': Icons.star, 'text': 'Customer Satisfaction Surveys'},
            {'icon': Icons.campaign, 'text': 'Marketing Campaign Management'},
            {'icon': Icons.analytics, 'text': 'Customer Analytics & Insights'},
          ]
        : [
            {'icon': Icons.person_add, 'text': 'إدارة قاعدة بيانات العملاء'},
            {'icon': Icons.history, 'text': 'تتبع تاريخ التفاعلات'},
            {'icon': Icons.support_agent, 'text': 'نظام تذاكر الدعم'},
            {'icon': Icons.star, 'text': 'استطلاعات رضا العملاء'},
            {'icon': Icons.campaign, 'text': 'إدارة الحملات التسويقية'},
            {'icon': Icons.analytics, 'text': 'تحليلات ورؤى العملاء'},
          ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      separatorBuilder: (context, index) => SizedBox(height: screenWidth > 600 ? 12 : 10),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(screenWidth > 600 ? 18 : 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
                width: screenWidth > 600 ? 48 : 40,
                height: screenWidth > 600 ? 48 : 40,
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  features[index]['icon'] as IconData,
                  color: Colors.teal,
                  size: screenWidth > 600 ? 24 : 20,
                ),
              ),
              SizedBox(width: screenWidth > 600 ? 20 : 15),
              Expanded(
                child: Text(
                  features[index]['text'] as String,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: screenWidth > 600 ? 16 : 15,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChannelsGrid(BuildContext context, bool isEnglish, double screenWidth) {
    final channels = isEnglish
        ? [
            'Email Support',
            'Phone Support',
            'Live Chat',
            'Social Media',
            'Support Tickets',
            'Video Calls',
            'WhatsApp Business',
            'Self-Service Portal',
          ]
        : [
            'الدعم عبر البريد',
            'الدعم الهاتفي',
            'الدردشة المباشرة',
            'وسائل التواصل الاجتماعي',
            'تذاكر الدعم',
            'المكالمات المرئية',
            'واتساب للأعمال',
            'بوابة الخدمة الذاتية',
          ];

    final crossAxisCount = screenWidth > 1200
        ? 4
        : screenWidth > 800
            ? 3
            : screenWidth > 600
                ? 2
                : 2;

    final childAspectRatio = screenWidth > 1200
        ? 1.8
        : screenWidth > 800
            ? 1.6
            : screenWidth > 600
                ? 1.4
                : 1.5;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: screenWidth > 600 ? 16 : 12,
        mainAxisSpacing: screenWidth > 600 ? 16 : 12,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: channels.length,
      itemBuilder: (context, index) {
        final colors = [
          Colors.teal,
          Colors.blue,
          Colors.green,
          Colors.purple,
          Colors.orange,
          Colors.indigo,
          Colors.lightGreen,
          Colors.cyan,
        ];

        final icons = [
          Icons.email,
          Icons.phone,
          Icons.chat,
          Icons.thumb_up,
          Icons.support_agent,
          Icons.video_call,
          Icons.chat_bubble,
          Icons.laptop_chromebook,
        ];

        return Container(
          padding: EdgeInsets.all(screenWidth > 600 ? 16 : 12),
          decoration: BoxDecoration(
            color: colors[index % colors.length].withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors[index % colors.length].withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: colors[index % colors.length].withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icons[index % icons.length],
                color: colors[index % colors.length],
                size: screenWidth > 600 ? 28 : 24,
              ),
              SizedBox(height: screenWidth > 600 ? 12 : 8),
              Flexible(
                child: Text(
                  channels[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: screenWidth > 600 ? 15 : 13,
                    fontWeight: FontWeight.w600,
                    color: colors[index % colors.length],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatisticsSection(BuildContext context, bool isEnglish, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth > 600 ? 24 : 20),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: Colors.teal,
                size: screenWidth > 600 ? 28 : 24,
              ),
              SizedBox(width: screenWidth > 600 ? 16 : 12),
              Text(
                isEnglish ? 'Customer Insights' : 'رؤى العملاء',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 22 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth > 600 ? 20 : 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                context,
                isEnglish ? 'Total Customers' : 'إجمالي العملاء',
                '3,215',
                Colors.teal,
                screenWidth,
              ),
              _buildStatItem(
                context,
                isEnglish ? 'Active' : 'نشط',
                '2,870',
                Colors.green,
                screenWidth,
              ),
            ],
          ),
          SizedBox(height: screenWidth > 600 ? 20 : 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                context,
                isEnglish ? 'New This Month' : 'جديد هذا الشهر',
                '145',
                Colors.blue,
                screenWidth,
              ),
              _buildStatItem(
                context,
                isEnglish ? 'Satisfaction' : 'معدل الرضا',
                '4.5/5',
                Colors.orange,
                screenWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String title, String value, Color color, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: screenWidth > 600 ? 14 : 12,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: screenWidth > 600 ? 28 : 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isEnglish, double screenWidth) {
    final buttonWidth = screenWidth > 600 ? 200.0 : 160.0;
    final buttonHeight = screenWidth > 600 ? 50.0 : 45.0;
    final fontSize = screenWidth > 600 ? 16.0 : 14.0;

    return Center(
      child: Wrap(
        spacing: screenWidth > 600 ? 20 : 16,
        runSpacing: screenWidth > 600 ? 16 : 12,
        alignment: WrapAlignment.center,
        children: [
          SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              child: Text(
                isEnglish ? 'Add Customer' : 'إضافة عميل',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.teal),
                ),
                elevation: 2,
              ),
              child: Text(
                isEnglish ? 'View All Customers' : 'عرض جميع العملاء',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginNote(BuildContext context, bool isEnglish, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth > 600 ? 24 : 20),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.teal,
                size: screenWidth > 600 ? 24 : 20,
              ),
              SizedBox(width: screenWidth > 600 ? 12 : 10),
              Text(
                isEnglish ? 'Note' : 'ملاحظة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 18 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth > 600 ? 12 : 10),
          Text(
            isEnglish
                ? 'Login is required to access full customer relations features including customer database management, communication tracking, support ticket handling, and customer analytics.'
                : 'يتطلب تسجيل الدخول للوصول إلى جميع ميزات علاقات العملاء بما في ذلك إدارة قاعدة بيانات العملاء، وتتبع الاتصالات، ومعالجة تذاكر الدعم، وتحليلات العملاء.',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: screenWidth > 600 ? 15 : 14,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}