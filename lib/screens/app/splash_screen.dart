import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/intro_page_1.dart';
import '../models/theme_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3)); // Reduced from 10 to 3 seconds
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroPage1()),
      );
    }
  }

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

    return Scaffold(
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
              // Logo - Responsive sizing
              Container(
                width: _responsiveValue(
                  context,
                  mobile: 170,
                  tablet: 200,
                  desktop: 250,
                ),
                height: _responsiveValue(
                  context,
                  mobile: 170,
                  tablet: 200,
                  desktop: 250,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'lib/assets/images/vision_erp_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              
              SizedBox(height: _responsiveValue(
                context,
                mobile: 30,
                tablet: 40,
                desktop: 50,
              )),
              
              // Tagline - Responsive font size and padding with dark blue color
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _responsiveValue(
                    context,
                    mobile: 20,
                    tablet: 40,
                    desktop: 60,
                  ),
                ),
                child: Text(
                  'Powering Digital Transformation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 18,
                    ),
                    color: AppColors.primaryColor,
                    letterSpacing: _responsiveValue(
                      context,
                      mobile: 0.8,
                      tablet: 1.0,
                      desktop: 1.2,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: _responsiveValue(
                context,
                mobile: 50,
                tablet: 60,
                desktop: 70,
              )),
            ],
          ),
        ),
      ),
    );
  }
}