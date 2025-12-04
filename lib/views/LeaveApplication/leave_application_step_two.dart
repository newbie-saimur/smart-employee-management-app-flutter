import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:smart_employee_management/controllers/leave_application_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/NavBarView/nav_bar_view.dart';
import 'package:smart_employee_management/widgets/custom_button.dart';

class LeaveApplicationStepTwo extends StatelessWidget {
  const LeaveApplicationStepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveApplicationController controller =
        Get.find<LeaveApplicationController>();

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.currentStep.value = 1;
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    leading: GestureDetector(
                      onTap: () => Get.to(NavBarView()),
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    title: Column(
                      spacing: 4,
                      children: [
                        Text(
                          "New Request",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            "Step ${controller.currentStep.value} of 3",
                            style: TextStyle(
                              color: AppColors.secondaryTextColor,
                              fontSize: 12,
                            ),
                          );
                        }),
                      ],
                    ),
                    centerTitle: true,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      var size = MediaQuery.sizeOf(context).width;
                      size = controller.currentStep.value == 1
                          ? size * 0.33
                          : controller.currentStep.value == 2
                          ? size * 0.66
                          : size;
                      return AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeInOut,
                        height: 4,
                        width: size,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),

                  // Reason Section
                  _buildReasonSection(controller),
                  SizedBox(height: 30),

                  // Handover Section
                  _buildHandoverSection(controller),
                  SizedBox(height: 30),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: "Back",
                      onTap: () => controller.previousStep(),
                      color: AppColors.primaryTextColor,
                      backgroundColor: AppColors.secondaryTextColor.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 5,
                    child: CustomButton(
                      title: "Next Step",
                      onTap: () {
                        if (controller.isStep2Valid.value) {
                          controller.nextStep();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReasonSection(LeaveApplicationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "REASON",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryTextColor,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 140,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            maxLines: null,
            controller: controller.reasonController,
            minLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: 'Describe why you need this leave...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintStyle: TextStyle(color: AppColors.secondaryTextColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHandoverSection(LeaveApplicationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "HANDOVER TASKS TO",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryTextColor,
          ),
        ),
        SizedBox(height: 8),
        Obx(
          () => DropdownButtonFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person_outline,
                color: AppColors.secondaryTextColor,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primaryColor.withValues(alpha: 0.7),
                  width: 2,
                ),
              ),
              hintText: "Select Colleague",
            ),
            initialValue: controller.selectedHandoverColleague.value,
            onChanged: (newValue) {
              controller.selectedHandoverColleague.value = newValue;
            },
            items: controller.colleaguesList
                .map((name) => DropdownMenuItem(value: name, child: Text(name)))
                .toList(),
          ),
        ),
      ],
    );
  }
}
