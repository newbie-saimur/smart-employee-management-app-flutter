import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/HomeScreen/widgets/meeting_detail_screen.dart';

class TimelineItemsMeeting extends StatelessWidget {
  final Map data;
  const TimelineItemsMeeting({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(MeetingDetailScreen(meetingData: data)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(width: 4, color: AppColors.primaryColor),
          ),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Colors.black12,
              blurRadius: 2,
              spreadRadius: 0.5,
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFEFF6FF),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          data['month'],
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data['dateNumber'],
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: AppColors.secondaryTextColor,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "${data['time']}  •  ${data['meetingPlatform']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondaryTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: AppColors.borderColor,
            ),
          ],
        ),
      ),
    );
  }
}
