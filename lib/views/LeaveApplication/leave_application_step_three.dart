import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:smart_employee_management/controllers/leave_application_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/NavBarView/nav_bar_view.dart';
import 'package:smart_employee_management/widgets/custom_button.dart';

class LeaveApplicationStepThree extends StatelessWidget {
  const LeaveApplicationStepThree({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveApplicationController controller =
        Get.find<LeaveApplicationController>();

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.currentStep.value = 2;
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
                        duration: Duration(milliseconds: 700),
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

                  // Draft Request Section
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.5,
                          blurStyle: BlurStyle.outer,
                          spreadRadius: 0.5,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "DRAFT REQUEST",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "${_formatDate(controller.selectedStartDate.value)} - ${_formatDate(controller.selectedEndDate.value)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${controller.selectedLeaveTitle}  •  ${controller.durationDays.value} Days",
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          height: 60,
                          color: AppColors.borderColor.withValues(alpha: 0.5),
                        ),

                        _buildReasonField(controller),
                        SizedBox(height: 24),
                        _buildHandoverField(controller),
                        SizedBox(height: 24),
                        _buildApproverField(),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "By submitting, this request will be sent to your reporting manager for approval.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondaryTextColor.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                  ),
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
                      title: "Submit Request",
                      onTap: () {
                        Get.snackbar(
                          'Request Submitted!',
                          'Your leave application has been successfully sent to your manager, Saimur Rahman, for approval.',
                          icon: const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.green.shade600,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 4),
                          borderRadius: 8,
                          margin: const EdgeInsets.all(10),
                        );
                        Get.to(NavBarView());
                      },
                      backgroundColor: Color(0xFF0D9488),
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

  Container _buildApproverField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(right: 12, left: 12),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            size: 28,
            color: AppColors.primaryTextColor.withValues(alpha: 0.6),
          ),
        ),
        title: Text(
          "APPROVER",
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "Saimur Rahman",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "Manager",
            style: TextStyle(
              color: AppColors.primaryColor.withValues(alpha: 0.8),
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  Row _buildHandoverField(LeaveApplicationController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.group_outlined,
            size: 32,
            color: AppColors.primaryTextColor.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HANDOVER TO",
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                controller.selectedHandoverColleague.value ??
                    "No Handover Colleague Selected",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildReasonField(LeaveApplicationController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notes_rounded,
            size: 32,
            color: AppColors.primaryTextColor.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "REASON",
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),

              Container(
                constraints: const BoxConstraints(maxHeight: 100),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    controller.reasonController.text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '...';
    return DateFormat('MMM dd').format(date);
  }
}
