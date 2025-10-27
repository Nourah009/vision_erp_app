import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class PlanPricingSection extends StatelessWidget {
  final Function(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) responsiveValue;

  const PlanPricingSection({
    super.key,
    required this.responsiveValue,
  });

  @override
  Widget build(BuildContext context) {
    // List of pricing plans
    final List<Map<String, dynamic>> plans = [
      {
        'title': 'Master',
        'subtitle': 'Ideal for small projects',
        'price': 'Free',
        'features': [
          'Unlimited personal files',
          'Email support',
          'CSV data export',
          'Basic analytics dashboard',
          '1,000 API calls per month',
        ],
        'isPopular': false,
        'buttonText': 'Get started',
        'buttonColor': AppColors.secondaryColor,
      },
      {
        'title': 'Project plan',
        'subtitle': 'All starter features +',
        'price': '',
        'features': [
          'Up to 5 user accounts',
          'Team collaboration tools',
          'Custom dashboards',
          'Multiple data export formats',
          'Basic custom integrations',
        ],
        'isPopular': true,
        'buttonText': 'Select plan',
        'buttonColor': AppColors.primaryColor,
      },
      {
        'title': 'Organization',
        'subtitle': 'For fast-growing businesses',
        'price': '\$30 /per user',
        'features': [
          'All professional features +',
          'Enterprise security suite',
          'Single Sign-On (SSO)',
          'Custom contract terms',
          'Dedicated phone support',
          'Custom integration support',
          'Compliance tools',
        ],
        'isPopular': false,
        'buttonText': 'Select plan',
        'buttonColor': AppColors.secondaryColor,
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plan and Pricing title - centered
          Center(
            child: Text(
              'Plan and Pricing',
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
          ),
          SizedBox(
            height: responsiveValue(
              context,
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
          ),

          // Horizontal scrolling plans
          SizedBox(
            height: responsiveValue(
              context,
              mobile: 380,
              tablet: 350,
              desktop: 320,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plans.length,
              itemBuilder: (context, index) {
                return Container(
                  width: responsiveValue(
                    context,
                    mobile: 280,
                    tablet: 300,
                    desktop: 320,
                  ),
                  margin: EdgeInsets.only(
                    right: index == plans.length - 1 ? 0 : 16,
                    left: index == 0 ? 0 : 0,
                  ),
                  child: _buildPlanCard(context, plans[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, Map<String, dynamic> plan) {
    return Container(
      padding: EdgeInsets.all(
        responsiveValue(context, mobile: 12, tablet: 14, desktop: 16),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: plan['isPopular']
              ? AppColors.primaryColor
              : AppColors.primaryColor.withOpacity(0.2),
          width: plan['isPopular'] ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: plan['isPopular']
            ? AppColors.primaryColor.withOpacity(0.05)
            : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular badge - centered at top
          if (plan['isPopular'])
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveValue(
                    context,
                    mobile: 6,
                    tablet: 8,
                    desktop: 10,
                  ),
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'MOST POPULAR PLAN',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: responsiveValue(
                      context,
                      mobile: 8,
                      tablet: 9,
                      desktop: 10,
                    ),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          if (plan['isPopular']) SizedBox(height: 8),

          // Plan title
          Text(
            plan['title'],
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: responsiveValue(
                context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: 4),

          // Plan subtitle
          Text(
            plan['subtitle'],
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: responsiveValue(
                context,
                mobile: 12,
                tablet: 13,
                desktop: 14,
              ),
              color: AppColors.textSecondary,
            ),
          ),

          SizedBox(height: 8),

          // Price
          if (plan['price'].isNotEmpty)
            Text(
              plan['price'],
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: responsiveValue(
                  context,
                  mobile: 14,
                  tablet: 15,
                  desktop: 16,
                ),
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),

          SizedBox(height: 12),

          // Features list
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var feature in plan['features'])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColors.primaryColor,
                          size: 12,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: responsiveValue(
                                context,
                                mobile: 11,
                                tablet: 12,
                                desktop: 13,
                              ),
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 12),

          // Select plan button
          SizedBox(
            width: double.infinity,
            height: responsiveValue(
              context,
              mobile: 36,
              tablet: 40,
              desktop: 44,
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: plan['buttonColor'],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                plan['buttonText'],
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: responsiveValue(
                    context,
                    mobile: 12,
                    tablet: 13,
                    desktop: 14,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}