import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class TaskScheduleSection extends StatelessWidget {
  final Function(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) responsiveValue;

  const TaskScheduleSection({
    super.key,
    required this.responsiveValue,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    
    final List<Map<String, dynamic>> tasks = [
      {
        'title': appLocalizations.visualAuditoryCheck,
        'description': appLocalizations.visualAuditoryDesc,
        'time': '10:00 AM',
        'status': 'done',
      },
      {
        'title': appLocalizations.feelTheAuthor,
        'description': appLocalizations.feelTheAuthorDesc,
        'time': '12:00 PM',
        'status': 'in-progress',
      },
      {
        'title': appLocalizations.checkControlSetting,
        'description': appLocalizations.checkControlDesc,
        'time': '07:00 PM',
        'status': 'todo',
      },
      {
        'title': appLocalizations.checkExteriorVents,
        'description': appLocalizations.checkExteriorDesc,
        'time': '07:00 PM',
        'status': 'todo',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.taskSchedule,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: responsiveValue(
                context,
                mobile: 18,
                tablet: 20,
                desktop: 22,
              ),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16),

          // Task List - Each task in separate white box
          Column(
            children: [
              for (var task in tasks)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(
                    responsiveValue(
                      context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left side - Task details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              task['title'],
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: responsiveValue(
                                  context,
                                  mobile: 14,
                                  tablet: 16,
                                  desktop: 18,
                                ),
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(height: 4),

                            // Description
                            Text(
                              task['description'],
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: responsiveValue(
                                  context,
                                  mobile: 12,
                                  tablet: 14,
                                  desktop: 16,
                                ),
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 8),

                            // Time
                            Text(
                              task['time'],
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: responsiveValue(
                                  context,
                                  mobile: 12,
                                  tablet: 13,
                                  desktop: 14,
                                ),
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 12),

                      // Right side - Status indicator
                      _buildTaskStatus(task['status'], context),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskStatus(String status, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'done':
        statusColor = Colors.green;
        statusText = appLocalizations.done;
        statusIcon = Icons.check_circle;
        break;
      case 'in-progress':
        statusColor = Colors.orange;
        statusText = appLocalizations.inProgress;
        statusIcon = Icons.access_time;
        break;
      case 'todo':
        statusColor = Colors.grey;
        statusText = appLocalizations.toDo;
        statusIcon = Icons.radio_button_unchecked;
        break;
      default:
        statusColor = Colors.grey;
        statusText = appLocalizations.toDo;
        statusIcon = Icons.radio_button_unchecked;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 16),
          SizedBox(width: 4),
          Text(
            statusText,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}