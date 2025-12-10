import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/AttendanceScreen/attendance_screen.dart';
import 'package:smart_employee_management/views/PaySlipScreen/payslip_screen.dart';
import 'package:smart_employee_management/views/StaffDirectory/staff_directory.dart';

class DashboardQuickAccess extends StatelessWidget {
  const DashboardQuickAccess({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> quickAccessItems = [
      {"img": Icons.people, "title": "Directory", "color": Color(0xFF638FF0)},
      {
        "img": Icons.receipt_long,
        "title": "Payslip",
        "color": Color(0xFF249E93),
      },
      {
        "img": Icons.edit_calendar_rounded,
        "title": "Attend.",
        "color": Color(0xFFB167F8),
      },
      {"img": Icons.grid_view, "title": "More", "color": Color(0xFFA7B4C5)},
    ];
    return GridView.builder(
      padding: EdgeInsets.only(top: 12),
      shrinkWrap: true,
      itemCount: 4,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) {
        final data = quickAccessItems[index];
        return GestureDetector(
          onTap: () {
            data['title'] == "Directory"
                ? Get.to(StaffDirectoryScreen())
                : data['title'] == "Payslip"
                ? Get.to(PayslipScreen())
                : data['title'] == "Attend."
                ? Get.to(AttendanceScreen())
                : null;
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: Colors.black12,
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: Icon(data['img'], color: data['color'], size: 24),
              ),
              SizedBox(height: 6),
              Text(
                data['title'],
                style: TextStyle(color: AppColors.secondaryTextColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
