import 'package:flutter/material.dart';
import 'package:get/get.dart';

// --- MOCK DATABASE DATA (JSON Simulation) ---
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
  // --- DYNAMIC USER DATA (Rx Variables) ---
  var userName = 'Loading...'.obs;
  var userRole = 'Loading...'.obs;
  var userId = 'N/A'.obs;
  var userInitials = ''.obs;
  var userColorHex = '94A3B8'.obs; // Default grey color

  final String logoutLink = '/login_screen';

  // Mock login state: এই ID টি প্রমাণ করবে কোন ইউজার লগইন করেছে।
  final String _currentLoggedInId = "EMP-2024";

  // --- PREFERENCES STATE ---
  var isNotificationActive = true.obs;

  @override
  void onInit() {
    loadUserProfile(_currentLoggedInId);
    super.onInit();
  }

  // --- DATA LOADING LOGIC (Simulating API/Database Call) ---
  void loadUserProfile(String loggedInId) {
    final userData = _mockUsers.firstWhereOrNull(
      (user) => user['id'] == loggedInId,
    );

    if (userData != null) {
      // ডেটা পেলে Observable Properties আপডেট করা
      userName.value = userData['name']!;
      userRole.value = userData['role']!;
      userId.value = userData['id']!;
      userInitials.value = userData['initials']!;
      userColorHex.value = userData['colorHex']!;
      debugPrint("Profile loaded for: ${userName.value}");
    } else {
      // ফলব্যাক (Fallback) যদি ইউজার না পাওয়া যায়
      userName.value = 'Guest User';
      userRole.value = 'Unknown Role';
      userId.value = '000';
    }
  }

  // --- LOGIC ---
  void toggleNotifications() {
    isNotificationActive.value = !isNotificationActive.value;
    // Future logic: Send API call to update server preference
    if (isNotificationActive.value) {
      debugPrint("Notifications ON");
    } else {
      debugPrint("Notifications OFF");
    }
  }

  void navigateToPersonalInfo() {
    // Logic to navigate to Personal Info Edit Screen
    debugPrint("Navigating to Personal Info");
  }

  void handleLogout() {
    // Logic to clear user session and navigate to Login
    debugPrint("Logging out user: ${userName.value}");
    Get.offAllNamed(logoutLink);
  }
}
