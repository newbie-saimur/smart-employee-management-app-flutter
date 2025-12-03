import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:smart_employee_management/controllers/dashboard_task_tab_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';

class TabButton extends StatelessWidget {
  final String title;
  final DashboardTaskTabController tabController;
  const TabButton({
    super.key,
    required this.tabController,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => title == "PENDING APPROVAL"
            ? tabController.activeApprovedRequired()
            : tabController.activeUpNext(),
        child: Container(
          padding: EdgeInsets.only(bottom: 4),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color:
                    (title == "PENDING APPROVAL"
                        ? tabController.isActiveApprovalRequired.value
                        : tabController.isActiveUpNext.value)
                    ? AppColors.primaryColor
                    : Colors.transparent,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color:
                  (title == "PENDING APPROVAL"
                      ? tabController.isActiveApprovalRequired.value
                      : tabController.isActiveUpNext.value)
                  ? AppColors.primaryTextColor
                  : AppColors.secondaryTextColor,
              fontWeight:
                  (title == "PENDING APPROVAL"
                      ? tabController.isActiveApprovalRequired.value
                      : tabController.isActiveUpNext.value)
                  ? FontWeight.bold
                  : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
