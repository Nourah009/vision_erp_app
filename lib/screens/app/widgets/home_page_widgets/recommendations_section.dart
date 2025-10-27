import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class RecommendationsSection extends StatelessWidget {
  final Function(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) responsiveValue;

  const RecommendationsSection({
    Key? key,
    required this.responsiveValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of all 14 categories with their icons
    final List<Map<String, dynamic>> categories = [
      {'title': 'Human Resources', 'icon': Icons.people},
      {'title': 'Materials and\nwarehouse', 'icon': Icons.warehouse},
      {'title': 'Fixed assets', 'icon': Icons.business},
      {'title': 'Customer\nRelations', 'icon': Icons.person},
      {'title': 'Analysis and\nreports', 'icon': Icons.analytics},
      {'title': 'Value Added\nTax', 'icon': Icons.attach_money},
      {'title': 'Projects', 'icon': Icons.assignment},
      {'title': 'Website', 'icon': Icons.language},
      {'title': 'Manufacturing', 'icon': Icons.build},
      {'title': 'Sales', 'icon': Icons.shopping_cart},
      {'title': 'Purchasing', 'icon': Icons.shopping_bag},
      {'title': 'Accounting', 'icon': Icons.account_balance},
      {'title': 'Inventory', 'icon': Icons.inventory},
      {'title': 'Quality\nControl', 'icon': Icons.verified},
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
            'Recommendations for you',
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
    return Container(
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
    );
  }
}