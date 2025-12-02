import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/Purchasing_page.dart';
import 'package:vision_erp_app/screens/app/accounting_page.dart';
import 'package:vision_erp_app/screens/app/analysis_and_report_page.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/app/crm_page.dart';
import 'package:vision_erp_app/screens/app/fixed_assets_page.dart';
import 'package:vision_erp_app/screens/app/human_resources.dart';
import 'package:vision_erp_app/screens/app/human_resources_overview_page.dart';
import 'package:vision_erp_app/screens/app/inventory_page.dart';
import 'package:vision_erp_app/screens/app/manufacturing_page.dart';
import 'package:vision_erp_app/screens/app/materials_warehouses_page.dart';
import 'package:vision_erp_app/screens/app/projects_page.dart';
import 'package:vision_erp_app/screens/app/quality_control_page.dart';
import 'package:vision_erp_app/screens/app/sale_page.dart';
import 'package:vision_erp_app/screens/app/vat_page.dart';
import 'package:vision_erp_app/screens/app/website_page.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart' ;
import 'package:vision_erp_app/services/auth_service.dart';

class RecommendationsSection extends StatelessWidget {
  final Function(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  })
  responsiveValue;

  const RecommendationsSection({super.key, required this.responsiveValue});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    
    // List of all 14 categories with their icons
    final List<Map<String, dynamic>> categories = [
      {'title': isEnglish ? 'Human Resources' : 'الموارد البشرية', 'icon': Icons.people},
      {'title': isEnglish ? 'Materials and\nwarehouse' : 'المواد\nوالمستودعات', 'icon': Icons.warehouse},
      {'title': isEnglish ? 'Fixed assets' : 'الأصول الثابتة', 'icon': Icons.business},
      {'title': isEnglish ? 'Customer\nRelations' : 'علاقات\nالعملاء', 'icon': Icons.person},
      {'title': isEnglish ? 'Analysis and\nreports' : 'التحليل\nوالتقارير', 'icon': Icons.analytics},
      {'title': isEnglish ? 'Value Added\nTax' : 'ضريبة القيمة\nالمضافة', 'icon': Icons.attach_money},
      {'title': isEnglish ? 'Projects' : 'المشاريع', 'icon': Icons.assignment},
      {'title': isEnglish ? 'Website' : 'الموقع الإلكتروني', 'icon': Icons.language},
      {'title': isEnglish ? 'Manufacturing' : 'التصنيع', 'icon': Icons.build},
      {'title': isEnglish ? 'Sales' : 'المبيعات', 'icon': Icons.shopping_cart},
      {'title': isEnglish ? 'Purchasing' : 'المشتريات', 'icon': Icons.shopping_bag},
      {'title': isEnglish ? 'Accounting' : 'المحاسبة', 'icon': Icons.account_balance},
      {'title': isEnglish ? 'Inventory' : 'المخزون', 'icon': Icons.inventory},
      {'title': isEnglish ? 'Quality\nControl' : 'مراقبة\nالجودة', 'icon': Icons.verified},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.recommendationsForYou,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: responsiveValue(
                context,
                mobile: 18,
                tablet: 20,
                desktop: 22,
              ),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16),

          // Horizontal scrolling categories
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    right: index == categories.length - 1 ? 0 : 12,
                    left: index == 0 ? 0 : 0,
                  ),
                  child: _buildCategoryBox(
                    context,
                    categories[index]['title'],
                    categories[index]['icon'] as IconData,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBox(BuildContext context, String title, IconData icon) {
   return GestureDetector(
    onTap: () async {
      final isLoggedIn = await AuthService.isUserLoggedIn();
      
      if (title.contains('Human Resources') || title.contains('الموارد البشرية')) {
        if (isLoggedIn) {
          // جلب بيانات المستخدم الحالي
          final user = await AuthService.getCurrentUser();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HumanResourcesPage(user: user),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HumanResourcesOverviewPage(),
            ),
          );
        }
      } else if (title.contains('Materials and\nwarehouse') || title.contains('المواد\nوالمستودعات')) {
        // Navigate to Materials and Warehouse Page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MaterialsWarehousesPage()),
        );
      } else if (title.contains('Fixed assets') || title.contains('الأصول الثابتة')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FixedAssetsPage()),
        );
      } else if (title.contains('Customer\nRelations') || title.contains('علاقات\nالعملاء')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomerRelationsPage()),
          );
        } else if (title.contains('Analysis and\nreports') || title.contains('التحليل\nوالتقارير')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AnalysisReportsPage()),
        );
      } else if (title.contains('Value Added\nTax') || title.contains('ضريبة القيمة\nالمضافة')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ValueAddedTaxPage()),
        );
      } else if (title.contains('Projects') || title.contains('المشاريع')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProjectsPage()),
        );
      } else if (title.contains('Website') || title.contains('الموقع الإلكتروني')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WebsitePage()),
        );
      } else if (title.contains('Manufacturing') || title.contains('التصنيع')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ManufacturingPage()),
        );
      } else if (title.contains('Sale') || title.contains('المبيعات')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SalePage()),
        );
      } else if (title.contains('Purchasing') || title.contains('المشتريات')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PurchasePage()),
        );
      } else if (title.contains('Accounting') || title.contains('المحاسبة')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccountingPage()),
        );
      } else if (title.contains('Inventory') || title.contains('المخزون')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InventoryPage()),
        );
      } else if (title.contains('Quality\nControl') || title.contains('مراقبة\nالجودة')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QualityControlPage()),
        );
      }
    },
    child: Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}
}