import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/controllers/bottom_navigation_bar_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/HomeScreen/home_screen.dart';
import 'package:smart_employee_management/views/MyProfile/my_profile.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({super.key});

  static List<Widget> screens = [
    HomeScreen(),
    Center(child: Text('Chat')),
    Center(child: Text('Resources')),
    MyProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationBarController());
    return Obx(
      () => Scaffold(
        body: screens[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            controller.currentIndex.value = value;
          },
          currentIndex: controller.currentIndex.value,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.secondaryTextColor,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: "Resources",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
