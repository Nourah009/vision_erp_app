import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) responsiveValue;
  
  final UserModel user;

  const DashboardAppBar({
    super.key,
    required this.responsiveValue,
    required this.user,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations() = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile info on LEFT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isEnglish ? 'Hello,' : 'مرحباً،',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: responsiveValue(
                    context,
                    mobile: 16,
                    tablet: 18,
                    desktop: 20,
                  ),
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                '${user.username}!', // استخدام اسم المستخدم الحقيقي
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: responsiveValue(
                    context,
                    mobile: 18,
                    tablet: 20,
                    desktop: 22,
                  ),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          // Notification icon on RIGHT
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.secondaryColor,
            ),
            onPressed: () {
              // Handle notification tap
            },
          ),
        ],
      ),
    );
  }
}