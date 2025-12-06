import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:smart_employee_management/controllers/leave_application_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';

class LeaveType extends StatelessWidget {
  final Map data;
  final LeaveApplicationController controller;
  final void Function()? onTap;
  const LeaveType({
    super.key,
    required this.data,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Color(
      int.parse(data['iconColor'].substring(1), radix: 16) + 0xFF000000,
    );

    return GestureDetector(
      onTap: onTap,
      child: Obx(() {
        bool isSelected = controller.selectedType.value == data['leaveTypeID'];
        return Container(
          padding: EdgeInsets.symmetric(vertical: 6),
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor.withValues(alpha: 0.05)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurStyle: BlurStyle.outer,
                blurRadius: 0.3,
                spreadRadius: 0.5,
              ),
            ],
            border: BoxBorder.all(
              color: isSelected ? AppColors.primaryColor : Colors.white,
              width: 1,
            ),
          ),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.9)
                    : color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.5,
                    blurStyle: BlurStyle.outer,
                    spreadRadius: 0.5,
                    color: color.withValues(alpha: .2),
                  ),
                ],
              ),
              child: Icon(
                getIconFromString(data["iconName"]),
                color: isSelected ? Colors.white : color,
                size: 24,
              ),
            ),
            title: Text(data['title']),
            subtitle: Text("Balance: ${data['balance']} Days"),
          ),
        );
      }),
    );
  }

  IconData getIconFromString(String iconName) {
    switch (iconName) {
      case 'Icons.bolt':
        return Icons.bolt;
      case 'Icons.thermostat':
        return Icons.thermostat;
      default:
        return Icons.campaign_outlined;
    }
  }
}
