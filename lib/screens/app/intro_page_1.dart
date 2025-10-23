import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'intro_page_2.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  // Responsive value calculator
  double _responsiveValue(BuildContext context, 
      {required double mobile, double? tablet, double? desktop}) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= 1200 && desktop != null) {
      return desktop;
    } else if (width >= 600 && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IntroPage2()),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: _responsiveValue(
                context,
                mobile: 20,
                tablet: 40,
                desktop: 60,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image - Responsive sizing
                Container(
                  width: _responsiveValue(
                    context,
                    mobile: 250,
                    tablet: 300,
                    desktop: 350,
                  ),
                  height: _responsiveValue(
                    context,
                    mobile: 250,
                    tablet: 300,
                    desktop: 350,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'lib/assets/images/intro_page_1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                SizedBox(height: _responsiveValue(
                  context,
                  mobile: 40,
                  tablet: 50,
                  desktop: 60,
                )),
                
                // Title - Responsive font size
                Text(
                  'Welcome to Vision ERP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: _responsiveValue(
                      context,
                      mobile: 24,
                      tablet: 28,
                      desktop: 32,
                    ),
                    color: AppColors.primaryColor,
                  ),
                ),
                
                SizedBox(height: _responsiveValue(
                  context,
                  mobile: 20,
                  tablet: 25,
                  desktop: 30,
                )),
                
                // Description - Responsive font size
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _responsiveValue(
                      context,
                      mobile: 10,
                      tablet: 20,
                      desktop: 30,
                    ),
                  ),
                  child: Text(
                    'Discover the power of integrated business management with Vision ERP. Streamline your operations and boost productivity.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: _responsiveValue(
                        context,
                        mobile: 14,
                        tablet: 16,
                        desktop: 18,
                      ),
                      fontWeight: FontWeight.normal,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
                
                // Added space between text and circles
              SizedBox(height: _responsiveValue(
                context,
                mobile: 90,  // Increased from 40 to 50
                tablet: 100,  // Increased from 50 to 60
                desktop: 110, // Increased from 60 to 70
              )),
                
                // Page Indicator Circles
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // First circle - Orange (current page)
                    Container(
                      width: _responsiveValue(
                        context,
                        mobile: 8,
                        tablet: 10,
                        desktop: 12,
                      ),
                      height: _responsiveValue(
                        context,
                        mobile: 8,
                        tablet: 10,
                        desktop: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor, // Orange
                        shape: BoxShape.circle,
                      ),
                    ),
                    
                    SizedBox(width: _responsiveValue(
                      context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 12,
                    )),
                    
                    // Second circle - Gray
                    Container(
                      width: _responsiveValue(
                        context,
                        mobile: 8,
                        tablet: 10,
                        desktop: 12,
                      ),
                      height: _responsiveValue(
                        context,
                        mobile: 8,
                        tablet: 10,
                        desktop: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor, // Gray
                        shape: BoxShape.circle,
                      ),
                    ),
                    
                    SizedBox(width: _responsiveValue(
                      context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 12,
                    )),
                    
                    // Third circle - Gray
                    Container(
                      width: _responsiveValue(
                        context,
                        mobile: 8,
                        tablet: 10,
                        desktop: 12,
                      ),
                      height: _responsiveValue(
                        context,
                        mobile: 8,
                        tablet: 10,
                        desktop: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor, // Gray
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}