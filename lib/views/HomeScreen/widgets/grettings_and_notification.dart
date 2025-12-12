import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/NotificationScreen/notification_screen.dart';

class GrettingsAndNotification extends StatelessWidget {
  const GrettingsAndNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning,",
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              "Saimur Rahman",
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Get.to(NotificationScreen()),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.outer,
                  blurRadius: 0.01,
                  spreadRadius: 0.2,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () => Get.to(NotificationScreen()),
                  icon: Icon(Icons.notifications_none),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
