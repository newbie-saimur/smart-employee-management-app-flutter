import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/LeaveApplication/leave_application_step_one.dart';
import 'package:smart_employee_management/widgets/custom_button.dart';

class CasualBalanceCard extends StatelessWidget {
  const CasualBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Casual Leave Balance",
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "07",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "/12",
                        style: TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomButton(
                  title: "+ Apply for Leave",
                  onTap: () => Get.to(LeaveApplicationStepOne()),
                ),
              ],
            ),
          ),

          // Pie Chart Section
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Color(0xFF293445),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF3F4958),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/svg/pie-chart.svg',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
