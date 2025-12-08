import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:get_storage/get_storage.dart';

class AttendanceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final box = GetStorage();

  var clockInTime = "---:---".obs;
  var clockOutTime = "---:---".obs;
  var isClockedIn = false.obs;
  var isClockedOut = false.obs;

  performCheckedIn() {
    if (!isClockedIn.value) {
      box.write(
        'lastClockDate',
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
      box.write('clockInTime', DateFormat("hh:mm a").format(DateTime.now()));

      isClockedIn.value = true;
      clockInTime.value = DateFormat("hh:mm a").format(DateTime.now());
      Get.snackbar(
        'Clock In Successful',
        'You checked in at ${clockInTime.value}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  performCheckedOut() {
    if (isClockedIn.value && !isClockedOut.value) {
      box.write('clockOutTime', DateFormat("hh:mm a").format(DateTime.now()));

      isClockedOut.value = true;
      clockOutTime.value = DateFormat("hh:mm a").format(DateTime.now());
      Get.snackbar(
        'Clock Out Successful',
        'You checked out at ${clockOutTime.value}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void _loadSavedAttendance() {
    final savedDateString = box.read('lastClockDate');
    final savedInTime = box.read('clockInTime');
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (savedDateString == today && savedInTime != null) {
      clockInTime.value = savedInTime;
      isClockedIn.value = true;
      clockOutTime.value = box.read('clockOutTime') ?? "---:---";
    } else {
      _resetAttendance();
    }
  }

  void _resetAttendance() {
    clockInTime.value = "---:---";
    clockOutTime.value = "---:---";
    isClockedIn.value = false;
    box.remove('lastClockDate');
    box.remove('clockInTime');
    box.remove('clockOutTime');
  }

  late AnimationController pulseController;
  late Animation<double> scaleTween;

  final Color pulseBaseColor = AppColors.primaryColor;

  @override
  void onInit() {
    super.onInit();
    _loadSavedAttendance();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    scaleTween = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: pulseController, curve: Curves.easeOut));
  }

  @override
  void onClose() {
    pulseController.dispose();
    super.onClose();
  }
}
