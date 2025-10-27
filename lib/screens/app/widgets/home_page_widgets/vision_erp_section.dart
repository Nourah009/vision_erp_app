import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class VisionERPSection extends StatelessWidget {
  final Function(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  })
  responsiveValue;

  const VisionERPSection({super.key, required this.responsiveValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.accentBlue],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vision ERP',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: responsiveValue(
                context,
                mobile: 20,
                tablet: 24,
                desktop: 28,
              ),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Integrating every department for seamless data flow and clarity',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: responsiveValue(
                context,
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
              fontWeight: FontWeight.normal,
              color: Colors.white,
              height: 1.4,
            ),
          ),

          // Divider line
          Container(
            margin: EdgeInsets.symmetric(
              vertical: responsiveValue(
                context,
                mobile: 12,
                tablet: 14,
                desktop: 16,
              ),
            ),
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),

          // Date and Time row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date on the left
              Text(
                'Sunday, 12 June',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: responsiveValue(
                    context,
                    mobile: 14,
                    tablet: 16,
                    desktop: 18,
                  ),
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
