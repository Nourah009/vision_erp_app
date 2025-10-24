import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/shared_preferences_service.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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

 void _getStarted(BuildContext context) async {
  // Mark intro as shown - THIS IS CRITICAL
  await SharedPreferencesService.setIntroShown();
  
  print('Intro completed - user will not see intro pages again');
  
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
              // Swiped right - go back to previous page
              Navigator.pop(context);
            } else if (details.primaryVelocity! < 0) {
              // Swiped left - do nothing (last page)
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
                // Back Button - Top Left
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: _responsiveValue(
                        context,
                        mobile: 10,
                        tablet: 15,
                        desktop: 20,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                        size: _responsiveValue(
                          context,
                          mobile: 24,
                          tablet: 28,
                          desktop: 32,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                            'lib/assets/images/intro_page_3.png',
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
                        'Ready to Start?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: _responsiveValue(
                            context,
                            mobile: 24,
                            tablet: 28,
                            desktop: 32,
                          ),
                          fontWeight: FontWeight.bold,
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
                          'Join thousands of businesses that trust VisionERP for their daily operations.',
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
                          // First circle - Gray
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
                          
                          // Third circle - Orange (current page)
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
                        ],
                      ),
                      
                      // Increased space between circles and button to move button down
                      SizedBox(height: _responsiveValue(
                        context,
                        mobile: 50,
                        tablet: 60,
                        desktop: 70,
                      )),
                      
                      // Get Started Button - Orange color
                      SizedBox(
                        width: _responsiveValue(
                          context,
                          mobile: 300,
                          tablet: 350,
                          desktop: 400,
                        ),
                        height: _responsiveValue(
                          context,
                          mobile: 50,
                          tablet: 55,
                          desktop: 60,
                        ),
                        child: ElevatedButton(
                          onPressed: () => _getStarted(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor, // Orange color
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: _responsiveValue(
                                context,
                                mobile: 16,
                                tablet: 18,
                                desktop: 20,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Skip Button - Bottom Middle
                Padding(
                  padding: EdgeInsets.only(
                    bottom: _responsiveValue(
                      context,
                      mobile: 30,
                      tablet: 40,
                      desktop: 50,
                    ),
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