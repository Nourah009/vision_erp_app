import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/shared_preferences_service.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
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

  void _skipToHome(BuildContext context) async {
    // Mark intro as shown
    await SharedPreferencesService.setIntroShown();
    
    print('Intro skipped - user will not see intro pages again');
    
    // Navigate to home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              // Swiped right - do nothing or go back if needed
            } else if (details.primaryVelocity! < 0) {
              // Swiped left - go to next page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IntroPage2()),
              );
            }
          },
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
              children: [
                // Skip Button - Top Right
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: _responsiveValue(
                        context,
                        mobile: 10,
                        tablet: 15,
                        desktop: 20,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () => _skipToHome(context),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: _responsiveValue(
                            context,
                            mobile: 16,
                            tablet: 18,
                            desktop: 20,
                          ),
                          fontWeight: FontWeight.normal,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
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
                        mobile: 90,
                        tablet: 100,
                        desktop: 110,
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

                // Navigation Arrows - Bottom
                Padding(
                  padding: EdgeInsets.only(
                    bottom: _responsiveValue(
                      context,
                      mobile: 30,
                      tablet: 40,
                      desktop: 50,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Empty container for left side (to balance layout)
                      Container(
                        width: _responsiveValue(
                          context,
                          mobile: 40,
                          tablet: 50,
                          desktop: 60,
                        ),
                      ),
                      
                      // Forward Arrow - Right side only
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const IntroPage2()),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryColor,
                          size: _responsiveValue(
                            context,
                            mobile: 24,
                            tablet: 28,
                            desktop: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}