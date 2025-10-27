import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class DemoSystemPage extends StatelessWidget {
  const DemoSystemPage({super.key});

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

  // Function to launch external URL
  Future<void> _launchDemoSystem(BuildContext context) async {
    const url = 'https://test.visioncit.com/';
    
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print('Error launching URL: $e');
      _showErrorDialog(
        context, 
        'Cannot open the demo system at this time. '
        'Please make sure you have a browser installed and try again.\n\n'
        'You can also manually visit: $url'
      );
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                'Unable to Open',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(
              fontFamily: 'Cairo',
              color: AppColors.textPrimary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          'Demo System',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: _responsiveValue(
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          _responsiveValue(context, mobile: 20, tablet: 30, desktop: 40),
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: _responsiveValue(
                context,
                mobile: 400,
                tablet: 500,
                desktop: 600,
              ),
            ),
            child: Column(
              children: [
                // Live System Login Title
                Text(
                  'Live System Login',
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
                  mobile: 30,
                  tablet: 40,
                  desktop: 50,
                )),
                
                // Credentials Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    _responsiveValue(context, mobile: 20, tablet: 25, desktop: 30),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Credentials Title
                      Center(
                        child: Text(
                          'Credentials',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: _responsiveValue(
                              context,
                              mobile: 20,
                              tablet: 22,
                              desktop: 24,
                            ),
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: _responsiveValue(
                        context,
                        mobile: 25,
                        tablet: 30,
                        desktop: 35,
                      )),
                      
                      // System URL Section
                      _buildCredentialItem(
                        context,
                        title: 'System URL',
                        value: 'sys.visioncit.com',
                        icon: Icons.language,
                      ),
                      
                      SizedBox(height: _responsiveValue(
                        context,
                        mobile: 20,
                        tablet: 25,
                        desktop: 30,
                      )),
                      
                      // Username Section
                      _buildCredentialItem(
                        context,
                        title: 'Username',
                        value: 'sysadmin01',
                        icon: Icons.person,
                      ),
                      
                      SizedBox(height: _responsiveValue(
                        context,
                        mobile: 20,
                        tablet: 25,
                        desktop: 30,
                      )),
                      
                      // Password Section
                      _buildCredentialItem(
                        context,
                        title: 'Password',
                        value: '2367',
                        icon: Icons.lock,
                        isPassword: true,
                      ),
                      
                      SizedBox(height: _responsiveValue(
                        context,
                        mobile: 30,
                        tablet: 35,
                        desktop: 40,
                      )),
                      
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: _responsiveValue(
                          context,
                          mobile: 50,
                          tablet: 55,
                          desktop: 60,
                        ),
                        child: ElevatedButton(
                          onPressed: () => _launchDemoSystem(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.open_in_new,
                                size: _responsiveValue(
                                  context,
                                  mobile: 18,
                                  tablet: 20,
                                  desktop: 22,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Go to Demo System',
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
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: _responsiveValue(
                        context,
                        mobile: 15,
                        tablet: 20,
                        desktop: 25,
                      )),
                      
                      // Info Text
                      Center(
                        child: Text(
                          'You will be redirected to the external demo system',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: _responsiveValue(
                              context,
                              mobile: 12,
                              tablet: 13,
                              desktop: 14,
                            ),
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: _responsiveValue(
                  context,
                  mobile: 30,
                  tablet: 40,
                  desktop: 50,
                )),
                
                // Additional Info Section - RETURNED BACK
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    _responsiveValue(context, mobile: 15, tablet: 20, desktop: 25),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primaryColor,
                        size: _responsiveValue(
                          context,
                          mobile: 24,
                          tablet: 28,
                          desktop: 32,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Demo System Information',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: _responsiveValue(
                            context,
                            mobile: 16,
                            tablet: 18,
                            desktop: 20,
                          ),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'This demo system contains sample data for demonstration purposes. You can explore the features but changes will not be saved.',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: _responsiveValue(
                            context,
                            mobile: 12,
                            tablet: 13,
                            desktop: 14,
                          ),
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
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

  Widget _buildCredentialItem(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      padding: EdgeInsets.all(
        _responsiveValue(context, mobile: 15, tablet: 18, desktop: 20),
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: _responsiveValue(
              context,
              mobile: 40,
              tablet: 45,
              desktop: 50,
            ),
            height: _responsiveValue(
              context,
              mobile: 40,
              tablet: 45,
              desktop: 50,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: _responsiveValue(
                context,
                mobile: 18,
                tablet: 20,
                desktop: 22,
              ),
            ),
          ),
          
          SizedBox(width: _responsiveValue(
            context,
            mobile: 15,
            tablet: 18,
            desktop: 20,
          )),
          
          // Title and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(
                      context,
                      mobile: 14,
                      tablet: 15,
                      desktop: 16,
                    ),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(
                      context,
                      mobile: 16,
                      tablet: 17,
                      desktop: 18,
                    ),
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                    letterSpacing: isPassword ? 1.5 : 0.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}