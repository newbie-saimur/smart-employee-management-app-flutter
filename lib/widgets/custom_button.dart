import 'package:flutter/material.dart';
import 'package:smart_employee_management/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon, color: Colors.white),
              if (icon != null) SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: color ?? Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
