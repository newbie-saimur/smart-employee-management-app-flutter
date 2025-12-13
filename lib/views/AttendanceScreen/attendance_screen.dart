import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_employee_management/controllers/attendance_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(
      AttendanceController(),
      permanent: true,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildClockInHero(controller),
                    SizedBox(height: 24),
                    _buildMonthlyStats(),
                    SizedBox(height: 24),
                    _buildRecentLogs(),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Container _buildClockInHero(AttendanceController controller) {
    final attendanceController = Get.find<AttendanceController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.cardBackgroundColor,
      ),
      child: Column(
        children: [
          Text(
            "TODAY, ${DateFormat("dd MMM").format(DateTime.now()).toUpperCase()}",
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),

          Obx(
            () => GestureDetector(
              onTap: () {
                if (controller.isClockedOut.value == false) {
                  controller.isClockedIn.value == false
                      ? controller.performCheckedIn()
                      : controller.performCheckedOut();
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Animated pulsating ring
                  Obx(
                    () => !attendanceController.isClockedIn.value
                        ? buildPulseRing(attendanceController)
                        : Container(), // Hide pulse when clocked in
                  ),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          controller.isClockedIn.value
                              ? Icons.logout
                              : Icons.fingerprint,
                          color: Colors.white,
                          size: 36,
                        ),
                        Text(
                          controller.isClockedIn.value
                              ? "CLOCK OUT"
                              : "CLOCK IN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.location_on, color: Colors.green),
              Text(
                "Inside Office Perimeter",
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          SizedBox(height: 6),
          Divider(
            color: AppColors.borderColor.withValues(alpha: 0.1),
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Check in",
                    style: TextStyle(color: AppColors.secondaryTextColor),
                  ),
                  Obx(
                    () => Text(
                      controller.clockInTime.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 24),
              Container(
                color: AppColors.borderColor.withValues(alpha: 0.1),
                width: 1,
                height: 40,
              ),
              SizedBox(width: 24),
              Column(
                children: [
                  Text(
                    "Check Out",
                    style: TextStyle(color: AppColors.secondaryTextColor),
                  ),
                  Obx(
                    () => Text(
                      controller.clockOutTime.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      backgroundColor: AppColors.backgroundColor,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_rounded,
          color: AppColors.secondaryTextColor,
        ),
      ),
      title: Text(
        "Attendance",
        style: TextStyle(color: AppColors.primaryTextColor),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: TextButton.icon(
            onPressed: () {},
            label: Text(
              "Dec 2025",
              style: TextStyle(color: AppColors.primaryColor, fontSize: 12),
            ),
            iconAlignment: IconAlignment.end,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 14,
              color: AppColors.primaryColor,
            ),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              backgroundColor: AppColors.primaryColor.withValues(alpha: 0.06),
              padding: EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyStats() {
    final monthlyStats = {
      'PRESENT': {'value': '13', 'color': Colors.blueGrey.shade800},
      'LATE': {'value': '01', 'color': Colors.red.shade500},
      'ABSENT': {'value': '00', 'color': Colors.orange.shade500},
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 14,
      children: monthlyStats.entries
          .map(
            (entry) => _buildStatCard(
              entry.key,
              entry.value['value'] as String,
              entry.value['color'] as Color,
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 0.5,
              spreadRadius: 0.5,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLogs() {
    final logsData = [
      {
        "dateNumber": 14,
        "dayName": "Sunday",
        "checkInTime": "9:00 AM",
        "checkOutTime": "6:05 PM",
        "status": "On Time",
        "statusColorHex": "#059669",
        "backgroundColorHex": "#ECFDF5",
      },
      {
        "dateNumber": 13,
        "dayName": "Saturday",
        "checkInTime": "9:45 AM",
        "checkOutTime": "6:30 PM",
        "status": "Late",
        "statusColorHex": "#E11D48",
        "backgroundColorHex": "#FFF1F2",
      },
      {
        "dateNumber": 11,
        "dayName": "Thursday",
        "checkInTime": "8:55 AM",
        "checkOutTime": "6:00 PM",
        "status": "On Time",
        "statusColorHex": "#059669",
        "backgroundColorHex": "#ECFDF5",
      },
      {
        "dateNumber": 10,
        "dayName": "Wednesday",
        "checkInTime": "9:05 AM",
        "checkOutTime": "6:10 PM",
        "status": "On Time",
        "statusColorHex": "#059669",
        "backgroundColorHex": "#ECFDF5",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RECENT LOGS",
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Column(
          spacing: 12,
          children: logsData.map((log) => _buildLogCard(log)).toList(),
        ),
        SizedBox(height: 12),
        Center(
          child: TextButton(
            onPressed: () {},
            child: Text(
              "View Full History",
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogCard(Map<String, dynamic> log) {
    final statusColor = hexToColor(log['statusColorHex']);
    final statusBackgroundColor = hexToColor(log['backgroundColorHex']);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0.3,
            spreadRadius: 0.3,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: statusBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    log['dateNumber'].toString(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    log['dayName'],
                    style: TextStyle(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${log['checkInTime']} - ${log['checkOutTime']}",
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              log['status'],
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color hexToColor(String hexCode) {
    return Color(int.parse(hexCode.substring(1), radix: 16) + 0xFF000000);
  }

  Widget buildPulseRing(AttendanceController controller) {
    // Uses the AnimatedBuilder to rebuild the widget on every animation tick
    return AnimatedBuilder(
      animation: controller.pulseController,
      builder: (context, child) {
        final animationValue = controller.scaleTween.value;

        // Calculate Opacity (fades out as it scales up: 0.7 down to 0)
        // Note: Normalizing the range (scale - 0.8) / 0.2 gives us a value from 0.0 to 1.0
        final double normalizedScale = (animationValue - 0.8) / 0.2;
        final double alphaValue = (1.0 - normalizedScale).clamp(
          0.0,
          0.7,
        ); // Opacity fades

        // Calculate Spread Radius (grows as it scales up)
        final double spreadRadius = (animationValue - 0.8) * 50;

        return Transform.scale(
          scale: animationValue, // Apply the scaling (0.8 -> 1.0)
          child: Opacity(
            opacity: alphaValue, // Apply the fading effect
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: controller.pulseBaseColor.withValues(
                      alpha: alphaValue,
                    ),
                    blurRadius: 0,
                    spreadRadius: spreadRadius,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
