import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onHomeTap;
  final VoidCallback? onDemoTap;
  final VoidCallback? onDashboardTap;
  final VoidCallback onProfileTap;
  final VoidCallback onMenuTap;
  final bool isUserLoggedIn;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onHomeTap,
    this.onDemoTap,
    this.onDashboardTap,
    required this.onProfileTap,
    required this.onMenuTap,
    required this.isUserLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.textSecondary,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            switch (index) {
              case 0:
                onHomeTap();
                break;
              case 1:
                // بناءً على حالة المستخدم، نحدد أي زر سيتم تفعيله
                if (!isUserLoggedIn) {
                  onDemoTap?.call(); // زر الديمو لغير المسجلين
                } else {
                  onDashboardTap?.call(); // زر الداشبورد للمسجلين
                }
                break;
              case 2:
                onProfileTap();
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            // زر ديناميكي يعتمد على حالة المستخدم
            if (!isUserLoggedIn)
              BottomNavigationBarItem(
                icon: Icon(Icons.app_registration),
                label: 'Demo',
              )
            else
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}