import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';
import 'package:vision_erp_app/services/localization_service.dart';

class InventoryOverviewPage extends StatelessWidget {
  const InventoryOverviewPage({super.key});

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
          isEnglish ? 'Inventory' : 'المخزون',
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
                  child: const Icon(Icons.inventory, color: Colors.white, size: 40),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Inventory' : 'المخزون',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isEnglish ? 'Inventory Management System' : 'نظام إدارة المخزون',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          color: Colors.orange[700],
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
                  child: const Icon(Icons.inventory, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Inventory' : 'المخزون',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isEnglish ? 'Inventory Management System' : 'نظام إدارة المخزون',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          color: Colors.orange[700],
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
              color: Colors.orange,
              size: screenWidth > 600 ? 28 : 24,
            ),
            SizedBox(width: screenWidth > 600 ? 16 : 12),
            Text(
              isEnglish ? 'Inventory System Overview' : 'نظرة عامة على نظام المخزون',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: screenWidth > 600 ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
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
                ? 'Comprehensive inventory management system designed to track, manage, and optimize stock levels across multiple warehouses with real-time visibility, automated reordering, and detailed reporting for efficient inventory control and cost optimization.'
                : 'نظام شامل لإدارة المخزون مصمم لتتبع وإدارة وتحسين مستويات المخزون عبر مستودعات متعددة مع رؤية آنية، وإعادة الطلب التلقائي، وتقارير مفصلة للتحكم الفعال في المخزون وتحسين التكاليف.',
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
            {'icon': Icons.storage, 'text': 'Real-time Stock Tracking'},
            {'icon': Icons.qr_code_scanner, 'text': 'Barcode Scanning'},
            {'icon': Icons.autorenew, 'text': 'Automated Reordering'},
            {'icon': Icons.location_on, 'text': 'Warehouse Location Management'},
            {'icon': Icons.compare_arrows, 'text': 'Stock Transfers & Movements'},
            {'icon': Icons.analytics, 'text': 'Inventory Analytics & Reports'},
          ]
        : [
            {'icon': Icons.storage, 'text': 'تتبع المخزون الآني'},
            {'icon': Icons.qr_code_scanner, 'text': 'فحص الباركود'},
            {'icon': Icons.autorenew, 'text': 'إعادة الطلب التلقائي'},
            {'icon': Icons.location_on, 'text': 'إدارة مواقع المستودعات'},
            {'icon': Icons.compare_arrows, 'text': 'تحويلات وحركات المخزون'},
            {'icon': Icons.analytics, 'text': 'تحليلات وتقارير المخزون'},
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

  Widget _buildModulesGrid(BuildContext context, bool isEnglish, double screenWidth) {
    final modules = isEnglish
        ? [
            'Stock Management',
            'Warehouse Control',
            'Inventory Tracking',
            'Stock Transfers',
            'Reorder Management',
            'Inventory Reports',
            'Barcode System',
            'Inventory Analytics',
          ]
        : [
            'إدارة المخزون',
            'التحكم بالمستودعات',
            'تتبع المخزون',
            'تحويلات المخزون',
            'إدارة إعادة الطلب',
            'تقارير المخزون',
            'نظام الباركود',
            'تحليلات المخزون',
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
          Colors.blue,
          Colors.green,
          Colors.purple,
          Colors.red,
          Colors.teal,
          Colors.indigo,
          Colors.pink,
        ];

        final icons = [
          Icons.storage,
          Icons.warehouse,
          Icons.track_changes,
          Icons.compare_arrows,
          Icons.add_shopping_cart,
          Icons.analytics,
          Icons.qr_code,
          Icons.timeline,
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

  Widget _buildStatisticsSection(BuildContext context, bool isEnglish, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth > 600 ? 24 : 20),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: Colors.orange,
                size: screenWidth > 600 ? 28 : 24,
              ),
              SizedBox(width: screenWidth > 600 ? 16 : 12),
              Text(
                isEnglish ? 'Inventory Statistics' : 'إحصائيات المخزون',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenWidth > 600 ? 22 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
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
                isEnglish ? 'Total Items' : 'إجمالي الأصناف',
                '1,250',
                Colors.orange,
                screenWidth,
              ),
              _buildStatItem(
                context,
                isEnglish ? 'Low Stock' : 'مخزون منخفض',
                '42',
                Colors.red,
                screenWidth,
              ),
              _buildStatItem(
                context,
                isEnglish ? 'In Stock' : 'متوفر',
                '1,180',
                Colors.green,
                screenWidth,
              ),
              _buildStatItem(
                context,
                isEnglish ? 'Out of Stock' : 'نفذ من المخزون',
                '28',
                Colors.grey,
                screenWidth,
              ),
            ],
          ),
          SizedBox(height: screenWidth > 600 ? 20 : 16),
          Container(
            padding: EdgeInsets.all(screenWidth > 600 ? 16 : 12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEnglish ? 'Total Inventory Value' : 'القيمة الإجمالية للمخزون',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: screenWidth > 600 ? 15 : 14,
                    color: Colors.orange[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  isEnglish ? 'SAR 1,250,000' : '١،٢٥٠،٠٠٠ ريال',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: screenWidth > 600 ? 16 : 15,
                    color: Colors.orange,
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
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              child: Text(
                isEnglish ? 'Add Item' : 'إضافة صنف',
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
                foregroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.orange),
                ),
                elevation: 2,
              ),
              child: Text(
                isEnglish ? 'View Inventory' : 'عرض المخزون',
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
                ? 'Login is required to access full inventory features including stock management, warehouse control, inventory tracking, and comprehensive reporting.'
                : 'يتطلب تسجيل الدخول للوصول إلى جميع ميزات المخزون بما في ذلك إدارة المخزون، والتحكم بالمستودعات، وتتبع المخزون، والتقارير الشاملة.',
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