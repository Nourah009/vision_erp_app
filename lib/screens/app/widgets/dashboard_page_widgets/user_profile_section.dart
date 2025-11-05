import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/app/profile_page.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';

class UserProfileSection extends StatelessWidget {
  final Function(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) responsiveValue;
  
  final UserModel user;

  const UserProfileSection({
    super.key,
    required this.responsiveValue,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final AppLocalizations() = AppLocalizations.of(context)!;
    
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // User info on the left
          Expanded(
            child: Row(
              children: [
                // User icon
                Container(
                  width: responsiveValue(
                    context,
                    mobile: 50,
                    tablet: 60,
                    desktop: 70,
                  ),
                  height: responsiveValue(
                    context,
                    mobile: 50,
                    tablet: 60,
                    desktop: 70,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: responsiveValue(
                      context,
                      mobile: 24,
                      tablet: 28,
                      desktop: 32,
                    ),
                  ),
                ),
                SizedBox(
                  width: responsiveValue(
                    context,
                    mobile: 12,
                    tablet: 16,
                    desktop: 20,
                  ),
                ),
                // User name, job description and department
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.username, // استخدام اسم المستخدم الحقيقي
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: responsiveValue(
                            context,
                            mobile: 16,
                            tablet: 18,
                            desktop: 20,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        user.role, // استخدام الدور الحقيقي
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: responsiveValue(
                            context,
                            mobile: 14,
                            tablet: 15,
                            desktop: 16,
                          ),
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        user.department, // استخدام القسم الحقيقي
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: responsiveValue(
                            context,
                            mobile: 12,
                            tablet: 13,
                            desktop: 14,
                          ),
                          fontWeight: FontWeight.normal,
                          color: Colors.white.withOpacity(0.7),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Arrow icon on the right
          IconButton(
            onPressed: () {
              // Navigate to ProfilePage when arrow is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
              );
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: responsiveValue(
                context,
                mobile: 18,
                tablet: 20,
                desktop: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}