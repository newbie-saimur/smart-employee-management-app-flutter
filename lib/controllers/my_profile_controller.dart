import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/views/LoginScreen/login_screen.dart';

const List<Map<String, String>> _mockUsers = [
  {
    "id": "EMP-2024",
    "name": "Saimur Rahman",
    "role": "Flutter Developer",
    "initials": "SR",
    "colorHex": "2563EB",
  },
  {
    "id": "EMP-2025",
    "name": "Farhana Ali",
    "role": "UI/UX Designer",
    "initials": "FA",
    "colorHex": "7C3AED",
  },
  {
    "id": "EMP-2026",
    "name": "Eyamin Hossain",
    "role": "Marketing Lead",
    "initials": "EH",
    "colorHex": "0F766E",
  },
];

class MyProfileController extends GetxController {
  var userName = 'Loading...'.obs;
  var userRole = 'Loading...'.obs;
  var userId = 'N/A'.obs;
  var userInitials = ''.obs;
  var userColorHex = '94A3B8'.obs;

  final String _currentLoggedInId = "EMP-2024";

  var isNotificationActive = true.obs;

  @override
  void onInit() {
    loadUserProfile(_currentLoggedInId);
    super.onInit();
  }

  void loadUserProfile(String loggedInId) {
    final userData = _mockUsers.firstWhereOrNull(
      (user) => user['id'] == loggedInId,
    );

    if (userData != null) {
      userName.value = userData['name']!;
      userRole.value = userData['role']!;
      userId.value = userData['id']!;
      userInitials.value = userData['initials']!;
      userColorHex.value = userData['colorHex']!;
      debugPrint("Profile loaded for: ${userName.value}");
    } else {
      userName.value = 'Guest User';
      userRole.value = 'Unknown Role';
      userId.value = '000';
    }
  }

  void toggleNotifications() {
    isNotificationActive.value = !isNotificationActive.value;
    if (isNotificationActive.value) {
      debugPrint("Notifications ON");
    } else {
      debugPrint("Notifications OFF");
    }
  }

  void navigateToPersonalInfo() {
    debugPrint("Navigating to Personal Info");
  }

  void handleLogout() {
    debugPrint("Logging out user: ${userName.value}");
    Get.offAll(LoginScreen());
  }
}
