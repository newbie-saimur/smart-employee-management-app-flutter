import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/views/NavBarView/nav_bar_view.dart';
import 'package:smart_employee_management/views/NotificationScreen/notification_model.dart';

// --- Color Constants based on V2 Theme ---
const Color _kPrimaryBlue = Color(0xFF2563EB);
const Color _kDarkSlate = Color(0xFF1E293B);
const Color _kMutedText = Color(0xFF64748B);
const Color _kLightBackground = Color(0xFFF8FAFC);

class AlertDetailScreen extends StatelessWidget {
  final UserAlert alert;

  const AlertDetailScreen({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    // Determine the color for the main alert card border
    final Color cardBorderColor = alert.iconColor.withValues(alpha: .5);

    return Scaffold(
      backgroundColor: _kLightBackground,
      appBar: AppBar(
        backgroundColor: _kLightBackground,
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF64748B),
                size: 28,
              ),
              onPressed: () => Get.back(),
            ),
            const SizedBox(width: 8),
            const Text(
              'Alert Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _kDarkSlate,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: cardBorderColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        alert.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _kDarkSlate,
                        ),
                      ),
                      Text(
                        alert.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFA1A1AA),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Main Message
                  Text(
                    alert.message,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: _kMutedText,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Status Indicator
                  Row(
                    children: [
                      Icon(
                        alert.isUnread
                            ? Icons.visibility_off_outlined
                            : Icons.check_circle_outline,
                        size: 16,
                        color: alert.isUnread ? _kPrimaryBlue : Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        alert.isUnread ? 'Unread' : 'Acknowledged',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: alert.isUnread ? _kPrimaryBlue : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 2. Action/Contextual Information
            if (alert.title.contains('Leave Approved'))
              _buildContextCard(
                icon: Icons.calendar_today_outlined,
                title: 'Next Step',
                description:
                    'Your leave is confirmed. Check your remaining balance on the Dashboard.',
                actionText: 'View Dashboard',
                actionOnTap: () {
                  Get.to(NavBarView());
                },
              ),

            if (alert.title.contains('Login Attempt'))
              _buildContextCard(
                icon: Icons.security_outlined,
                title: 'Security Notice',
                description:
                    'If this was not you, please change your password immediately.',
                actionText: 'Change Password',
                actionOnTap: () {
                  Get.to(NavBarView());
                },
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildContextCard({
    required IconData icon,
    required String title,
    required String description,
    required String actionText,
    required VoidCallback actionOnTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .03), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: _kPrimaryBlue),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kDarkSlate,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: _kMutedText),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: actionOnTap,
            child: Text(
              actionText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: _kPrimaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
