import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class DashboardBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onHomeTap;
  final VoidCallback onDashboardTap;
  final VoidCallback onProfileTap;

  const DashboardBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onHomeTap,
    required this.onDashboardTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    
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
                onDashboardTap();
                break;
              case 2:
                onProfileTap();
                break;
              case 3:
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: appLocalizations.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: appLocalizations.dashboard,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: appLocalizations.profile,
            ),
          ],
        ),
      ),
    );
  }
}