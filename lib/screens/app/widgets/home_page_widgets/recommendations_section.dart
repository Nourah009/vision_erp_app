import 'package:flutter/material.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/Purchasing_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/accounting_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/analysis_and_report_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/crm_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/fixed_assets_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/human_resources.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/inventory_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/manufacturing_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/materials_warehouses_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/projects_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/quality_control_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/sale_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/vat_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/after_loging/website_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/Manufacturing_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/accounting_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/analysis_report_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/customer_relation_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/fixed_assets_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/human_resources_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/inventory_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/material_warehouse_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/projects_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/purchasing_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/quality_control_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/sales_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/vat_overview_page.dart';
import 'package:vision_erp_app/screens/app/home_page_sections/recommandation_section/before_loging/website_overview_page.dart';
import 'package:vision_erp_app/screens/app/sidebar_menu_sections/app_localizations.dart';
import 'package:vision_erp_app/services/auth_service.dart';

class RecommendationsSection extends StatelessWidget {
  final Function(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) responsiveValue;

  const RecommendationsSection({super.key, required this.responsiveValue});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

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
              fontSize: responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: index == categories.length - 1 ? 0 : 12),
                  child: _buildCategoryBox(
                    context,
                    categories[index]['title'],
                    categories[index]['icon'],
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

        // Human Resources
        if (title.contains('Human Resources') || title.contains('الموارد البشرية')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => HumanResourcesPage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HumanResourcesOverviewPage()));
          }
        }

        // Materials and warehouse
        else if (title.contains('Materials') || title.contains('المواد')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialsWarehousesPage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MaterialsWarehouseOverviewPage()));
          }
        }

        // Fixed Assets
        else if (title.contains('Fixed assets') || title.contains('الأصول')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => FixedAssetsPage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FixedAssetsOverviewPage()));
          }
        }

        else if (title.contains('Customer') || title.contains('علاقات')) {
          if (isLoggedIn) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerRelationsPage()));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerRelationsOverviewPage()));
          }
        }

        else if (title.contains('Analysis') || title.contains('التحليل')) {
          if (isLoggedIn) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalysisReportsPage()));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalysisReportsOverviewPage()));
          }
        }

        // VAT — FIXED (NO user PARAMETER)
        else if (title.contains('Value Added') || title.contains('القيمة')) {
          if (isLoggedIn) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ValueAddedTaxPage()));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ValueAddedTaxOverviewPage()));
          }
        }

        // Projects
        else if (title.contains('Projects') || title.contains('المشاريع')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectsPage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectsOverviewPage()));
          }
        }

        // Website
        else if (title.contains('Website') || title.contains('الموقع')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => WebsitePage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const WebsiteOverviewPage()));
          }
        }

        // Manufacturing
        else if (title.contains('Manufacturing') || title.contains('التصنيع')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => ManufacturingPage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ManufacturingOverviewPage()));
          }
        }

        // Sales
        else if (title.contains('Sales') || title.contains('المبيعات')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => SalePage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SalesOverviewPage()));
          }
        }

        // Purchasing
        else if (title.contains('Purchasing') || title.contains('المشتريات')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => PurchasePage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PurchasingOverviewPage()));
          }
        }

        // Accounting
        else if (title.contains('Accounting') || title.contains('المحاسبة')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => AccountingPage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountingOverviewPage()));
          }
        }

        // Inventory
        else if (title.contains('Inventory') || title.contains('المخزون')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => InventoryPage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const InventoryOverviewPage()));
          }
        }

        // Quality Control
        else if (title.contains('Quality') || title.contains('الجودة')) {
          if (isLoggedIn) {
            final user = await AuthService.getCurrentUser();
            Navigator.push(context, MaterialPageRoute(builder: (context) => QualityControlPage(user: user)));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const QualityControlOverviewPage()));
          }
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
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
