import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';
import 'package:vision_erp_app/services/localization_service.dart';

class AccountingOverviewPage extends StatelessWidget {
  const AccountingOverviewPage({super.key});

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
          isEnglish ? 'Accounting' : 'المحاسبة',
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
                  child: Icon(Icons.account_balance, color: Colors.white, size: 40),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Accounting' : 'المحاسبة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isEnglish ? 'Financial Management System' : 'نظام إدارة المالية',
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
                  child: Icon(Icons.account_balance, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Accounting' : 'المحاسبة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isEnglish ? 'Financial Management System' : 'نظام إدارة المالية',
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
              Icons.info,
              color: Colors.green,
              size: screenWidth > 600 ? 28 : 24,
            ),
            SizedBox(width: screenWidth > 600 ? 16 : 12),
            Text(
              isEnglish ? 'Accounting System Overview' : 'نظرة عامة على النظام المحاسبي',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: screenWidth > 600 ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
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
                ? 'Complete financial accounting system designed to manage all financial transactions, maintain accurate general ledger, handle accounts payable and receivable, process payroll, and generate Powerful financial reports with real-time insights.'
                : 'نظام محاسبي مالي متكامل مصمم لإدارة جميع المعاملات المالية، والحفاظ على دفتر الأستاذ العام الدقيق، ومعالجة الحسابات الدائنة والمدينة، ومعالجة الرواتب، وإنشاء تقارير مالية شاملة مع رؤى آنية.',
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
            {'icon': Icons.receipt_long, 'text': 'General Ledger Management'},
            {'icon': Icons.account_balance_wallet, 'text': 'Accounts Payable & Receivable'},
            {'icon': Icons.attach_money, 'text': 'Automated Payroll Processing'},
            {'icon': Icons.bar_chart, 'text': 'Financial Reporting & Analytics'},
            {'icon': Icons.account_balance, 'text': 'Budget & Cost Control'},
            {'icon': Icons.assessment, 'text': 'Tax Calculation & Compliance'},
          ]
        : [
            {'icon': Icons.receipt_long, 'text': 'إدارة الدفتر العام'},
            {'icon': Icons.account_balance_wallet, 'text': 'الحسابات الدائنة والمدينة'},
            {'icon': Icons.attach_money, 'text': 'معالجة الرواتب الآلية'},
            {'icon': Icons.bar_chart, 'text': 'التقارير المالية والتحليلات'},
            {'icon': Icons.account_balance, 'text': 'السيطرة على الميزانية والتكاليف'},
            {'icon': Icons.assessment, 'text': 'حساب الضرائب والامتثال'},
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
            'General Ledger',
            'Accounts Payable',
            'Accounts Receivable',
            'Payroll System',
            'Fixed Assets',
            'Budget Planning',
            'Financial Reports',
            'Tax Management',
          ]
        : [
            'الدفتر العام',
            'الحسابات الدائنة',
            'الحسابات المدينة',
            'نظام الرواتب',
            'الأصول الثابتة',
            'تخطيط الميزانية',
            'التقارير المالية',
            'إدارة الضرائب',
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
          Colors.purple,
          Colors.orange,
          Colors.teal,
          Colors.indigo,
          Colors.pink,
          Colors.cyan,
        ];

        final icons = [
          Icons.book,
          Icons.money_off,
          Icons.money,
          Icons.payments,
          Icons.business,
          Icons.pie_chart,
          Icons.analytics,
          Icons.receipt,
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
                ? 'Login is required to access full accounting features including financial reports, payroll processing, budget management, and tax calculations.'
                : 'يتطلب تسجيل الدخول للوصول إلى جميع ميزات المحاسبة بما في ذلك التقارير المالية، ومعالجة الرواتب، وإدارة الميزانية، وحسابات الضرائب.',
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