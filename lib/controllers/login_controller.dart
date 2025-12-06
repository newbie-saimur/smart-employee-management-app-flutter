import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smart_employee_management/views/NavBarView/nav_bar_view.dart';

class LoginController extends GetxController {
  var employeeIdField = TextEditingController();
  var passwordField = TextEditingController();
  var isValidUser = false.obs;

  void validateLogin() {
    if ((employeeIdField.text == "emp-123" ||
            employeeIdField.text == "saimur" ||
            employeeIdField.text == "farhana" ||
            employeeIdField.text == "eyamin") &&
        passwordField.text == "admin123") {
      isValidUser.value = true;
    } else {
      isValidUser.value = false;
    }
  }

  // Local biometric authentication
  final LocalAuthentication auth = LocalAuthentication();

  // Check if device supports biometrics
  Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  // Authenticate with biometrics
  Future<void> authenticateWithBiometrics() async {
    try {
      final bool canAuthenticate = await auth.canCheckBiometrics;
      if (!canAuthenticate) {
        Get.snackbar('Error', 'Biometric not available');
        return;
      }

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (didAuthenticate) {
        isValidUser.value = true;
        Get.offAll(NavBarView());
      }
    } catch (e) {
      Get.snackbar('Error', 'Authentication failed');
    }
  }
}
