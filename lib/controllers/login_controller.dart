import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      // Check device support first
      final bool isDeviceSupported = await auth.isDeviceSupported();
      if (!isDeviceSupported) {
        Get.snackbar('Error', 'Device does not support biometrics');
        return;
      }

      final bool canAuthenticate = await auth.canCheckBiometrics;
      if (!canAuthenticate) {
        Get.snackbar('Error', 'No biometrics enrolled on this device');
        return;
      }

      // Authenticate
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Scan fingerprint to login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: false,
        ),
      );

      if (didAuthenticate) {
        isValidUser.value = true;
        Get.offAll(NavBarView());
      }
    } on PlatformException catch (e) {
      // print('PlatformException code: ${e.code}, message: ${e.message}');

      if (e.code == 'NotAvailable') {
        Get.snackbar('Error', 'Biometric authentication is not available');
      } else if (e.code == 'NotEnrolled') {
        Get.snackbar(
          'Error',
          'No biometrics enrolled. Please set up fingerprint in Settings',
        );
      } else if (e.code == 'LockedOut' || e.code == 'PermanentlyLockedOut') {
        Get.snackbar('Error', 'Too many attempts. Try PIN/password');
      } else if (e.code == 'no_fragment_activity' ||
          e.code == 'auth_in_progress') {
        // Restart the app to fix fragment activity issue
        Get.snackbar(
          'Info',
          'Please restart the app and try biometric login again',
          duration: Duration(seconds: 4),
        );
      } else {
        Get.snackbar('Error', 'Biometric error. Try restarting the app');
      }
    } catch (e) {
      Get.snackbar('Error', 'Please restart app and try again');
    }
  }
}
