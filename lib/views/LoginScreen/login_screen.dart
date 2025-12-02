import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/NavBarView/nav_bar_view.dart';
import 'package:smart_employee_management/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo Section
                    Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            blurStyle: BlurStyle.outer,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/hexagon.svg',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Welcome Message Section
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Enter your credentials to access your workspace.",
                      style: TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 24),

                    // Login Input Fields Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EMPLOYEE ID OR EMAIL",
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(
                              color: AppColors.borderColor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.loginFormFillColor,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "e.g. EMP-1024",
                              prefixIcon: Icon(
                                Icons.person,
                                color: AppColors.hintTextColor,
                              ),
                              contentPadding: EdgeInsets.only(top: 14),
                              hintStyle: TextStyle(
                                color: AppColors.hintTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // Password Section
                        Text(
                          "PASSWORD",
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(
                              color: AppColors.borderColor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.loginFormFillColor,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "••••••••",
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: AppColors.hintTextColor,
                              ),
                              suffixIcon: Icon(
                                Icons.visibility,
                                color: AppColors.hintTextColor,
                              ),
                              contentPadding: EdgeInsets.only(top: 14),
                              hintStyle: TextStyle(
                                color: AppColors.hintTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),

                    // Remember Me section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (value) {},
                              visualDensity: VisualDensity.compact,
                              activeColor: AppColors.primaryColor,
                            ),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                color: AppColors.secondaryTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            title: "Sign In",
                            onTap: () => Get.offAll(NavBarView()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            height: 2,
                            color: AppColors.borderColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "QUICK ACCESS",
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Divider(
                            height: 2,
                            color: AppColors.borderColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // Biometric Login Section
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: BoxBorder.all(
                          width: 3,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Icon(
                        Icons.fingerprint,
                        size: 40,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Tap for Biometric Login",
                        style: TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copyright,
                  size: 10,
                  color: AppColors.secondaryTextColor,
                ),
                Text(
                  " 2025 Smart Employee Hub - Version 1.0",
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
