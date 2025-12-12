import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/controllers/notification_controller.dart';
import 'package:smart_employee_management/views/NotificationDetailScreen/alert_detail_screen.dart';
import 'package:smart_employee_management/views/NotificationDetailScreen/notice_detail_screen.dart';
import 'package:smart_employee_management/views/NotificationScreen/notification_model.dart';

const Color _kPrimaryBlue = Color(0xFF2563EB);
const Color _kDarkSlate = Color(0xFF1E293B);
const Color _kMutedText = Color(0xFF64748B);
const Color _kLightBackground = Color(0xFFF8FAFC);
const Color _kUnreadDot = Color(0xFF2563EB);

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());

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
              'Inbox',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _kDarkSlate,
              ),
            ),
            const Spacer(),
            // Mark all read button
            TextButton(
              onPressed: controller.markAllRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kPrimaryBlue,
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _buildTabSelector(),
          ),
        ),
      ),

      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            if (controller.activeTab.value == 'alerts')
              ...controller.alerts.map(_buildUserAlertCard),

            if (controller.activeTab.value == 'notices')
              ...controller.notices.map(_buildCompanyNoticeCard),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(
        () => Row(
          children: [
            _buildTabButton('alerts', 'My Alerts'),
            _buildTabButton('notices', 'Notice Board'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String key, String label) {
    final isActive = controller.activeTab.value == key;
    return Expanded(
      child: InkWell(
        onTap: () => controller.switchTab(key),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? _kDarkSlate : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .1),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : _kMutedText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserAlertCard(UserAlert alert) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: alert.isUnread ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: alert.isUnread
                ? const Color(0xFFDBEAFE)
                : const Color(0xFFF1F5F9),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .03),
              blurRadius: 4,
            ),
          ],
        ),
        child: InkWell(
          onTap: () => Get.to(AlertDetailScreen(alert: alert)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: alert.iconColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(alert.icon, color: alert.iconColor, size: 22),
              ),
              const SizedBox(width: 12),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          alert.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _kDarkSlate,
                          ),
                        ),
                        Text(
                          alert.time,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFFA1A1AA),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.message,
                      style: TextStyle(fontSize: 12, color: _kMutedText),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Unread Dot
              if (alert.isUnread)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: _kUnreadDot,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyNoticeCard(CompanyNotice notice) {
    Color borderColor;
    Color badgeColor;
    Color badgeBg;

    switch (notice.category) {
      case 'Critical':
        borderColor = Colors.red.shade500;
        badgeColor = Colors.red.shade600;
        badgeBg = Colors.red.shade50;
        break;
      case 'HR Policy':
        borderColor = _kPrimaryBlue;
        badgeColor = _kPrimaryBlue;
        badgeBg = _kPrimaryBlue.withValues(alpha: .1);
        break;
      case 'Event':
        borderColor = Colors.green.shade500;
        badgeColor = Colors.green.shade600;
        badgeBg = Colors.green.shade50;
        break;
      default:
        borderColor = Colors.grey.shade300;
        badgeColor = _kMutedText;
        badgeBg = Colors.grey.shade100;
        break;
    }

    // Critical notices have a special left border and darker shadow
    final bool isCritical = notice.category == 'Critical';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: isCritical
              ? Border(left: BorderSide(color: borderColor, width: 4))
              : Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isCritical ? 0.1 : 0.03),
              blurRadius: 5,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Get.to(NoticeDetailScreen(notice: notice));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      notice.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: badgeColor,
                      ),
                    ),
                  ),
                  Text(
                    notice.time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFA1A1AA),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notice.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _kDarkSlate,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notice.snippet,
                style: TextStyle(fontSize: 13, color: _kMutedText),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              if (notice.attachment != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.attach_file,
                        color: Color(0xFFA1A1AA),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        notice.attachment!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _kMutedText,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
