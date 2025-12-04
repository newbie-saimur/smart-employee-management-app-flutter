import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:smart_employee_management/controllers/leave_application_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/LeaveApplication/widgets/leave_type.dart';
import 'package:smart_employee_management/views/NavBarView/nav_bar_view.dart';
import 'package:smart_employee_management/widgets/custom_button.dart';

class LeaveApplicationStepOne extends StatelessWidget {
  const LeaveApplicationStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveApplicationController controller = Get.put(
      LeaveApplicationController(),
      permanent: true,
    );

    final List<Map> leaveTypes = [
      {
        "leaveTypeID": "CL",
        "title": "Casual Leave",
        "balance": 10,
        "unit": "Days",
        "description": "For unplanned personal or family matters.",
        "iconName": "Icons.bolt",
        "iconColor": "#4C70F7",
      },
      {
        "leaveTypeID": "SL",
        "title": "Sick Leave",
        "balance": 14,
        "unit": "Days",
        "description": "For employee illness or medical appointments.",
        "iconName": "Icons.thermostat",
        "iconColor": "#99D39C",
      },
      {
        "leaveTypeID": "EL",
        "title": "Emergency Leave",
        "balance": 3,
        "unit": "Days",
        "description": "For immediate, unavoidable critical situations.",
        "iconName": "Icons.medical_services",
        "iconColor": "#F56262",
      },
    ];

    return Scaffold(
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

                // Select Leave Type
                Text(
                  "SELECT TYPE",
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  itemBuilder: (context, index) {
                    final data = leaveTypes[index];
                    return LeaveType(
                      data: data,
                      controller: controller,
                      onTap: () => controller.makeSelected(
                        data['leaveTypeID'],
                        data['title'],
                      ),
                    );
                  },
                ),

                // Duration Section
                Text(
                  "DURATION",
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    // --- Start Date Field ---
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectDate(context, true),
                        child: Obx(
                          () => _buildDateField(
                            context,
                            'Start Date',
                            controller.selectedStartDate.value,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // --- End Date Field ---
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectDate(context, false),
                        child: Obx(
                          () => _buildDateField(
                            context,
                            'End Date',
                            controller.selectedEndDate.value,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Next Step",
                    onTap: () {
                      bool valid = controller.validateDuration(
                        leaveTypes[controller.selectedType.value == "CL"
                            ? 0
                            : controller.selectedType.value == "SL"
                            ? 1
                            : 2]['balance'],
                      );
                      if (valid) {
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
    );
  }

  Widget _buildDateField(BuildContext context, String label, DateTime? date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "  $label",
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date == null
                    ? 'MM/DD/YYYY'
                    : DateFormat('MM/dd/yyyy').format(date),
                style: TextStyle(
                  fontSize: 16,
                  color: date == null
                      ? AppColors.secondaryTextColor
                      : Colors.black54,
                ),
              ),
              const Icon(Icons.calendar_today, size: 20, color: Colors.blue),
            ],
          ),
        ),
      ],
    );
  }
}
