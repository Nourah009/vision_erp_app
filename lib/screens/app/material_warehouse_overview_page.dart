import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';

class MaterialsWarehouseOverviewPage extends StatelessWidget {
  const MaterialsWarehouseOverviewPage({super.key});

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
          isEnglish ? 'Materials & Warehouse' : 'المواد والمستودعات',
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
            _buildOverviewSection(
              isEnglish
                  ? 'Materials & Warehouse System Overview'
                  : 'نظرة عامة على نظام المواد والمستودعات',
              isEnglish
                  ? 'A comprehensive inventory and materials management system designed to help organizations efficiently track stock levels, control warehouse operations, manage material movement, and ensure accurate real-time inventory visibility.'
                  : 'نظام متكامل لإدارة المخزون والمواد يساعد المؤسسات على تتبّع مستويات المخزون، والتحكم في عمليات المستودعات، وإدارة حركة المواد، وضمان رؤية دقيقة ومحدّثة للمخزون.',
              screenWidth,
            ),

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
            _buildFeaturesList(isEnglish, screenWidth),

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
            _buildModulesGrid(isEnglish, screenWidth),

            SizedBox(height: screenWidth > 600 ? 40 : 30),
            
            // Login Note
            _buildLoginNote(isEnglish, screenWidth),
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
        color: Colors.orange.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withOpacity(0.2)),
      ),
      child: screenWidth > 600
          ? Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.warehouse, color: Colors.white, size: 40),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Materials & Warehouse' : 'المواد والمستودعات',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isEnglish
                            ? 'Smart Inventory & Materials Management System'
                            : 'نظام ذكي لإدارة المخزون والمواد',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          color: Colors.orange.shade700,
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
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.warehouse, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Materials & Warehouse' : 'المواد والمستودعات',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isEnglish
                            ? 'Smart Inventory & Materials Management System'
                            : 'نظام ذكي لإدارة المخزون والمواد',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildOverviewSection(String title, String content, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.inventory,
              color: Colors.orange,
              size: screenWidth > 600 ? 28 : 24,
            ),
            SizedBox(width: screenWidth > 600 ? 16 : 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 22 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
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
            content,
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

  Widget _buildFeaturesList(bool isEnglish, double screenWidth) {
    final features = isEnglish
        ? [
            {'icon': Icons.storage, 'text': 'Real-time Stock Level Tracking'},
            {'icon': Icons.qr_code_scanner, 'text': 'Barcode & QR-Code Scanning'},
            {'icon': Icons.autorenew, 'text': 'Automated Stock Replenishment'},
            {'icon': Icons.location_on, 'text': 'Warehouse Location Management'},
            {'icon': Icons.compare_arrows, 'text': 'Material IN/OUT/Transfer'},
            {'icon': Icons.calculate, 'text': 'Inventory Valuation & Costing'},
          ]
        : [
            {'icon': Icons.storage, 'text': 'تتبع مستويات المخزون لحظياً'},
            {'icon': Icons.qr_code_scanner, 'text': 'فحص المخزون بالباركود وQR'},
            {'icon': Icons.autorenew, 'text': 'إعادة طلب المخزون تلقائياً'},
            {'icon': Icons.location_on, 'text': 'إدارة مواقع المستودعات'},
            {'icon': Icons.compare_arrows, 'text': 'حركة المواد (دخول/خروج/تحويل)'},
            {'icon': Icons.calculate, 'text': 'تقييم المخزون واحتساب التكلفة'},
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
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  features[index]['icon'] as IconData,
                  color: Colors.orange,
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

  Widget _buildModulesGrid(bool isEnglish, double screenWidth) {
    final modules = isEnglish
        ? [
            'Stock Overview',
            'Warehouse Management',
            'Material Requests',
            'Purchase Replenishment',
            'Item Master Data',
            'Stock Movements',
            'Inventory Adjustments',
            'Reporting & Analytics',
          ]
        : [
            'نظرة عامة على المخزون',
            'إدارة المستودعات',
            'طلبات المواد',
            'إعادة تزويد المخزون',
            'بيانات الأصناف',
            'حركات المخزون',
            'تعديلات الجرد',
            'التقارير والتحليلات',
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
          Colors.orange,
          Colors.green,
          Colors.blue,
          Colors.purple,
          Colors.red,
          Colors.teal,
          Colors.indigo,
          Colors.cyan,
        ];

        final icons = [
          Icons.storage,
          Icons.warehouse,
          Icons.request_page,
          Icons.shopping_cart,
          Icons.inventory_2,
          Icons.compare_arrows,
          Icons.tune,
          Icons.analytics,
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

  Widget _buildLoginNote(bool isEnglish, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth > 600 ? 24 : 20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.orange,
                size: screenWidth > 600 ? 24 : 20,
              ),
              SizedBox(width: screenWidth > 600 ? 12 : 10),
              Text(
                isEnglish ? 'Note' : 'ملاحظة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 18 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth > 600 ? 12 : 10),
          Text(
            isEnglish
                ? 'Login is required to access full warehouse features including detailed inventory control, stock transfer operations, and material request approvals.'
                : 'يتطلب تسجيل الدخول للوصول إلى جميع ميزات المستودعات بما في ذلك التحكم التفصيلي بالمخزون، وعمليات تحويل المخزون، والموافقة على طلبات المواد.',
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