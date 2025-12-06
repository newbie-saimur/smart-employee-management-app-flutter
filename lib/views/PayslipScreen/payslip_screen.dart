import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/controllers/payslip_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/utils/pdf_generator.dart';
import 'package:smart_employee_management/widgets/custom_button.dart';

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payslipData = [
      {
        "salaryMonth": "November 2025",
        "disbursementDate": "Nov 28, 2025",
        "netPay": "85,400",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "1,500",
          "providentFund": "100",
          "totalDeductions": "1,600",
        },
      },
      {
        "salaryMonth": "October 2025",
        "disbursementDate": "Oct 28, 2025",
        "netPay": "85,500",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "1,400",
          "providentFund": "100",
          "totalDeductions": "1,500",
        },
      },
      {
        "salaryMonth": "September 2025",
        "disbursementDate": "Sep 28, 2025",
        "netPay": "85,450",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "1,450",
          "providentFund": "100",
          "totalDeductions": "1,550",
        },
      },
      {
        "salaryMonth": "August 2025",
        "disbursementDate": "Aug 28, 2025",
        "netPay": "85,600",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "1,300",
          "providentFund": "100",
          "totalDeductions": "1,400",
        },
      },
      {
        "salaryMonth": "July 2025",
        "disbursementDate": "Jul 28, 2025",
        "netPay": "85,700",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "1,200",
          "providentFund": "100",
          "totalDeductions": "1,300",
        },
      },
      {
        "salaryMonth": "June 2025",
        "disbursementDate": "Jun 28, 2025",
        "netPay": "85,850",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "1,050",
          "providentFund": "100",
          "totalDeductions": "1,150",
        },
      },
      {
        "salaryMonth": "May 2025",
        "disbursementDate": "May 28, 2025",
        "netPay": "85,900",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "1,000",
          "providentFund": "100",
          "totalDeductions": "1,100",
        },
      },
      {
        "salaryMonth": "April 2025",
        "disbursementDate": "Apr 28, 2025",
        "netPay": "86,000",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "900",
          "providentFund": "100",
          "totalDeductions": "1,000",
        },
      },
      {
        "salaryMonth": "March 2025",
        "disbursementDate": "Mar 28, 2025",
        "netPay": "85,900",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "1,000",
          "providentFund": "100",
          "totalDeductions": "1,100",
        },
      },
      {
        "salaryMonth": "February 2025",
        "disbursementDate": "Feb 28, 2025",
        "netPay": "86,100",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "800",
          "providentFund": "100",
          "totalDeductions": "900",
        },
      },
      {
        "salaryMonth": "January 2025",
        "disbursementDate": "Jan 28, 2025",
        "netPay": "86,000",
        "earnings": {
          "basicSalary": "50,000",
          "houseRent": "25,000",
          "medicalAllowance": "5,000",
          "conveyance": "7,000",
          "totalEarnings": "87,000",
        },
        "deductions": {
          "taxTDS": "900",
          "providentFund": "100",
          "totalDeductions": "1,000",
        },
      },
    ];
    final PayslipController payslipController = Get.put(PayslipController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Salary Slip",
          style: TextStyle(color: AppColors.primaryTextColor),
        ),
        actions: [
          Obx(() {
            var currentMonth = payslipController.monthIndex.value;
            final Map<String, dynamic> data = payslipData[currentMonth];

            return GestureDetector(
              onTap: () async {
                try {
                  await PdfGenerator.generatePayslip(data);
                  Get.snackbar(
                    'Success',
                    'Payslip downloaded successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } catch (e) {
                  Get.snackbar(
                    'Error',
                    'Failed to download payslip: $e',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Icon(
                Icons.file_download_outlined,
                color: AppColors.secondaryTextColor,
              ),
            );
          }),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 20,
            children: [
              Obx(() {
                var currentMonth = payslipController.monthIndex.value;
                final Map<String, dynamic> data = payslipData[currentMonth];
                final Map<String, dynamic> earningsData = data['earnings'];
                final Map<String, dynamic> deductionsData = data['deductions'];

                return Column(
                  spacing: 20,
                  children: [
                    // Navigation Month Section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 0.5,
                            spreadRadius: 1,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => payslipController.previousMonth(),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "SALARY MONTH",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: AppColors.secondaryTextColor,
                                ),
                              ),
                              Text(
                                data['salaryMonth'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppColors.primaryTextColor,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => payslipController.nextMonth(),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Main Salary Card
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        color: Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8),
                                  Text(
                                    "NET PAY",
                                    style: TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () =>
                                        payslipController.toggleVisibility(),
                                    child: Icon(
                                      payslipController.isVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/taka.svg',
                                    colorFilter: ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: 40,
                                  ),
                                  Text(
                                    payslipController.isVisible.value
                                        ? data['netPay']
                                        : "*****",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 46,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Disbursed on ${data['disbursementDate']}",
                                style: TextStyle(
                                  color: AppColors.secondaryTextColor
                                      .withValues(alpha: 0.67),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          _circleStyleForCard(
                            size: 100,
                            position: "right",
                            positionValue: -50,
                            color: Color(0xFF293445),
                          ),
                          _circleStyleForCard(
                            size: 50,
                            position: "right",
                            positionValue: -25,
                            color: AppColors.secondaryTextColor.withValues(
                              alpha: 0.2,
                            ),
                          ),
                          _circleStyleForCard(
                            size: 100,
                            position: "left",
                            positionValue: -50,
                            color: Color(0xFF293445),
                          ),
                          _circleStyleForCard(
                            size: 50,
                            position: "left",
                            positionValue: -25,
                            color: AppColors.secondaryTextColor.withValues(
                              alpha: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Earning Details
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 0.5,
                            spreadRadius: 1,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          Text(
                            "Earnings",
                            style: TextStyle(
                              color: AppColors.secondaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: AppColors.borderColor.withValues(alpha: 0.4),
                          ),
                          _showSalaryDetailsRow(
                            data: earningsData,
                            title: "Basic Salary",
                            category: "basicSalary",
                            isVisible: payslipController.isVisible.value,
                          ),
                          _showSalaryDetailsRow(
                            data: earningsData,
                            title: "House Rent",
                            category: "medicalAllowance",
                            isVisible: payslipController.isVisible.value,
                          ),
                          _showSalaryDetailsRow(
                            data: earningsData,
                            title: "Medical Allowance",
                            category: "houseRent",
                            isVisible: payslipController.isVisible.value,
                          ),
                          _showSalaryDetailsRow(
                            data: earningsData,
                            title: "Conveyance",
                            category: "conveyance",
                            isVisible: payslipController.isVisible.value,
                          ),
                          Divider(
                            height: 1,
                            color: AppColors.borderColor.withValues(alpha: 0.4),
                          ),
                          _showSalaryDetailsRow(
                            data: earningsData,
                            title: "TOTAL EARNINGS",
                            category: "totalEarnings",
                            isTotal: true,
                            isVisible: payslipController.isVisible.value,
                          ),
                        ],
                      ),
                    ),

                    // Deductions Details
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 0.5,
                            spreadRadius: 1,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          Text(
                            "DEDUCTIONS",
                            style: TextStyle(
                              color: AppColors.secondaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: AppColors.borderColor.withValues(alpha: 0.4),
                          ),
                          _showSalaryDetailsRow(
                            data: deductionsData,
                            title: "Tax (TDS)",
                            category: "taxTDS",
                            isVisible: payslipController.isVisible.value,
                          ),
                          _showSalaryDetailsRow(
                            data: deductionsData,
                            title: "Provident Fund",
                            category: "providentFund",
                            isVisible: payslipController.isVisible.value,
                          ),
                          Divider(
                            height: 1,
                            color: AppColors.borderColor.withValues(alpha: 0.4),
                          ),
                          _showSalaryDetailsRow(
                            data: deductionsData,
                            title: "TOTAL DEDUCTIONS",
                            category: "totalDeductions",
                            isTotal: true,
                            isDeductions: true,
                            isVisible: payslipController.isVisible.value,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      var currentMonth = payslipController.monthIndex.value;
                      final Map<String, dynamic> data =
                          payslipData[currentMonth];

                      return CustomButton(
                        icon: Icons.cloud_download_outlined,
                        title: "Download Payslip",
                        onTap: () async {
                          try {
                            await PdfGenerator.generatePayslip(data);
                            Get.snackbar(
                              'Success',
                              'Payslip downloaded successfully',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'Failed to download payslip: $e',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _circleStyleForCard({
    required double size,
    required String position,
    double? positionValue,
    required Color color,
  }) {
    if (position == "right") {
      return Positioned(
        top: 0,
        right: positionValue,
        bottom: 0,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      );
    } else {
      return Positioned(
        top: 0,
        left: positionValue,
        bottom: 0,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      );
    }
  }

  Row _showSalaryDetailsRow({
    required Map<String, dynamic> data,
    required String title,
    required String category,
    required bool isVisible,
    bool? isTotal,
    bool? isDeductions,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isTotal == true
                ? AppColors.secondaryTextColor
                : AppColors.primaryTextColor,
            fontWeight: isTotal == true ? FontWeight.w500 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        Text(
          isVisible ? data[category] : "*****",
          style: TextStyle(
            color: (isTotal == true && isDeductions == true)
                ? Color(0xFFE11D65)
                : isTotal == true
                ? Color(0xFF16A34A)
                : AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
