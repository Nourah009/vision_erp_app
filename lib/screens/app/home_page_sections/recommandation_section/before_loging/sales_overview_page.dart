import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/providers/theme_notifier.dart';
import 'package:vision_erp_app/services/localization_service.dart';

class SalesOverviewPage extends StatelessWidget {
  const SalesOverviewPage({super.key});

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
          isEnglish ? 'Sales' : 'المبيعات',
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
            
            // Modules Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? 8 : 0),
              child: Text(
                isEnglish ? 'Available Modules' : 'الوحدات المتاحة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 24 : 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            
            SizedBox(height: screenWidth > 600 ? 20 : 15),
            
            // Modules Grid
            _buildModulesGrid(context, isEnglish, screenWidth),
            
            SizedBox(height: screenWidth > 600 ? 40 : 30),
            
            // Sales Metrics Section
            _buildMetricsSection(context, isEnglish, screenWidth),
            
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
        color: Colors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: screenWidth > 600
          ? Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.shopping_cart, color: Colors.white, size: 40),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Sales' : 'المبيعات',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isEnglish ? 'Sales & Revenue Management System' : 'نظام إدارة المبيعات والإيرادات',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          color: Colors.green[700],
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
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.shopping_cart, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Sales' : 'المبيعات',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isEnglish ? 'Sales & Revenue Management System' : 'نظام إدارة المبيعات والإيرادات',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          color: Colors.green[700],
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
              Icons.trending_up,
              color: Colors.green,
              size: screenWidth > 600 ? 28 : 24,
            ),
            SizedBox(width: screenWidth > 600 ? 16 : 12),
            Text(
              isEnglish ? 'Sales System Overview' : 'نظرة عامة على نظام المبيعات',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: screenWidth > 600 ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
                ? 'Complete Sales Management system designed to optimize the entire sales lifecycle from lead generation to revenue realization. Features include customer relationship management, sales pipeline tracking, order processing, quotation management, invoicing, and Powerful sales analytics for revenue growth and customer satisfaction.'
                : 'نظام متكامل لإدارة المبيعات مصمم لتحسين دورة حياة المبيعات الكاملة من توليد العملاء المحتملين إلى تحقيق الإيرادات. يتضمن ميزات إدارة علاقات العملاء، وتتبع مسار المبيعات، ومعالجة الطلبات، وإدارة العروض، والفواتير، وتحليلات المبيعات الشاملة لنمو الإيرادات ورضا العملاء.',
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
            {'icon': Icons.leaderboard, 'text': 'Sales Pipeline & Funnel Management'},
            {'icon': Icons.person_pin, 'text': 'Customer Relationship Management'},
            {'icon': Icons.receipt_long, 'text': 'Quotation & Order Processing'},
            {'icon': Icons.timeline, 'text': 'Sales Forecasting & Analytics'},
            {'icon': Icons.discount, 'text': 'Pricing & Promotion Management'},
            {'icon': Icons.attach_money, 'text': 'Revenue & Performance Tracking'},
          ]
        : [
            {'icon': Icons.leaderboard, 'text': 'إدارة مسار المبيعات'},
            {'icon': Icons.person_pin, 'text': 'إدارة علاقات العملاء'},
            {'icon': Icons.receipt_long, 'text': 'معالجة العروض والطلبات'},
            {'icon': Icons.timeline, 'text': 'التنبؤ بالمبيعات والتحليلات'},
            {'icon': Icons.discount, 'text': 'إدارة التسعير والعروض'},
            {'icon': Icons.attach_money, 'text': 'تتبع الإيرادات والأداء'},
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
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  features[index]['icon'] as IconData,
                  color: Colors.green,
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

  Widget _buildModulesGrid(BuildContext context, bool isEnglish, double screenWidth) {
    final modules = isEnglish
        ? [
            'Leads Management',
            'Sales Pipeline',
            'Quotations',
            'Sales Orders',
            'Invoicing',
            'Customer Portal',
            'Sales Reports',
            'Commission Tracking',
          ]
        : [
            'إدارة العملاء المحتملين',
            'مسار المبيعات',
            'العروض',
            'طلبات المبيعات',
            'الفواتير',
            'بوابة العملاء',
            'تقارير المبيعات',
            'تتبع العمولات',
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
      itemCount: modules.length,
      itemBuilder: (context, index) {
        final colors = [
          Colors.green,
          Colors.blue,
          Colors.orange,
          Colors.purple,
          Colors.red,
          Colors.teal,
          Colors.indigo,
          Colors.cyan,
        ];

        final icons = [
          Icons.people,
          Icons.timeline,
          Icons.description,
          Icons.shopping_bag,
          Icons.receipt,
          Icons.laptop,
          Icons.analytics,
          Icons.monetization_on,
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
                  modules[index],
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

  Widget _buildMetricsSection(BuildContext context, bool isEnglish, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth > 600 ? 24 : 20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights,
                color: Colors.green,
                size: screenWidth > 600 ? 28 : 24,
              ),
              SizedBox(width: screenWidth > 600 ? 16 : 12),
              Text(
                isEnglish ? 'Sales Performance' : 'أداء المبيعات',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 22 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth > 600 ? 20 : 16),
          Wrap(
            spacing: screenWidth > 600 ? 40 : 24,
            runSpacing: screenWidth > 600 ? 20 : 16,
            children: [
              _buildStatItem(
                context,
                isEnglish ? 'Monthly Revenue' : 'الإيراد الشهري',
                'SAR 1.2M',
                Colors.green,
                screenWidth,
              ),
              _buildStatItem(
                context,
                isEnglish ? 'Active Leads' : 'عملاء محتملين نشطين',
                '156',
                Colors.blue,
                screenWidth,
              ),
              _buildStatItem(
                context,
                isEnglish ? 'Conversion Rate' : 'معدل التحويل',
                '24%',
                Colors.orange,
                screenWidth,
              ),
              _buildStatItem(
                context,
                isEnglish ? 'Orders' : 'الطلبات',
                '342',
                Colors.purple,
                screenWidth,
              ),
            ],
          ),
          SizedBox(height: screenWidth > 600 ? 20 : 16),
          Container(
            padding: EdgeInsets.all(screenWidth > 600 ? 16 : 12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEnglish ? 'Yearly Target' : 'الهدف السنوي',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: screenWidth > 600 ? 15 : 14,
                    color: Colors.green[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  isEnglish ? 'SAR 15M' : '١٥ مليون ريال',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: screenWidth > 600 ? 16 : 15,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              child: Text(
                isEnglish ? 'Create Lead' : 'إنشاء عميل محتمل',
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
                foregroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.green),
                ),
                elevation: 2,
              ),
              child: Text(
                isEnglish ? 'View Sales Dashboard' : 'عرض لوحة المبيعات',
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
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.green,
                size: screenWidth > 600 ? 24 : 20,
              ),
              SizedBox(width: screenWidth > 600 ? 12 : 10),
              Text(
                isEnglish ? 'Note' : 'ملاحظة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 18 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth > 600 ? 12 : 10),
          Text(
            isEnglish
                ? 'Login is required to access full sales features including lead management, sales pipeline tracking, quotation creation, order processing, sales analytics, and commission tracking.'
                : 'يتطلب تسجيل الدخول للوصول إلى جميع ميزات المبيعات بما في ذلك إدارة العملاء المحتملين، وتتبع مسار المبيعات، وإنشاء العروض، ومعالجة الطلبات، وتحليلات المبيعات، وتتبع العمولات.',
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