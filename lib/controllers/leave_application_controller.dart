import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/views/LeaveApplication/leave_application_step_one.dart';
import 'package:smart_employee_management/views/LeaveApplication/leave_application_step_three.dart';
import 'package:smart_employee_management/views/LeaveApplication/leave_application_step_two.dart';

class LeaveApplicationController extends GetxController {
  var currentStep = 1.obs;
  var selectedType = "CL".obs;
  var selectedLeaveTitle = "Casual Leave";

  nextStep() {
    if (currentStep.value == 1) {
      Get.to(LeaveApplicationStepTwo());
    } else {
      Get.to(LeaveApplicationStepThree());
    }
    currentStep.value = currentStep.value + 1;
  }

  previousStep() {
    if (currentStep.value == 3) {
      Get.to(LeaveApplicationStepTwo());
    } else {
      Get.to(LeaveApplicationStepOne());
    }
    currentStep.value = currentStep.value - 1;
  }

  makeSelected(String type, String title) {
    selectedType.value = type;
    selectedLeaveTitle = title;
  }

  // Duration Controller Logic
  var selectedStartDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();
  var durationDays = 0.obs;

  Future<void> selectDate(BuildContext context, bool isStart) async {
    DateTime firstDate = isStart
        ? DateTime.now()
        : (selectedStartDate.value?.add(Duration(days: 1)) ?? DateTime.now());

    DateTime initialDate = isStart
        ? (selectedStartDate.value ?? DateTime.now())
        : (selectedEndDate.value ?? firstDate);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2028),
    );

    if (picked != null) {
      if (isStart) {
        selectedStartDate.value = picked;
        if (selectedEndDate.value != null &&
            picked.isAfter(selectedEndDate.value!)) {
          selectedEndDate.value = null;
        }
      } else {
        selectedEndDate.value = picked;
      }
    }
  }

  // Calculation Logic
  bool validateDuration(int balanceLeft) {
    if (selectedStartDate.value != null && selectedEndDate.value != null) {
      final start = DateTime(
        selectedStartDate.value!.year,
        selectedStartDate.value!.month,
        selectedStartDate.value!.day,
      );
      final end = DateTime(
        selectedEndDate.value!.year,
        selectedEndDate.value!.month,
        selectedEndDate.value!.day,
      );

      final Duration difference = end.difference(start);
      int days = difference.inDays + 1;

      if (days > 0 && durationDays.value <= balanceLeft) {
        durationDays.value = days;
        return true;
      }
    }

    return false;
  }

  // Application Step 2 Controller
  final reasonController = TextEditingController();
  var selectedHandoverColleague = Rxn<String>();
  var isStep2Valid = false.obs;

  final colleaguesList = [
    "Saimur Rahman",
    "Farhana Ali",
    "Eyamin Ahammed",
    "Alex Johnson",
    "David Lee",
    "Robert Green",
  ];

  @override
  void onInit() {
    super.onInit();
    reasonController.addListener(_validateStep2);
    ever(selectedHandoverColleague, (_) => _validateStep2());
  }

  void _validateStep2() {
    isStep2Valid.value =
        reasonController.text.trim().isNotEmpty &&
        selectedHandoverColleague.value != null;
  }
}
