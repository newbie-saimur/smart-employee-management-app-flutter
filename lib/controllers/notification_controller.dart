import 'package:get/get.dart';
import 'package:smart_employee_management/views/NotificationScreen/notification_model.dart';

class NotificationController extends GetxController {
  var activeTab = 'alerts'.obs;

  // Data sources
  final RxList<UserAlert> alerts = mockAlerts.obs;
  final RxList<CompanyNotice> notices = mockNotices.obs;

  void switchTab(String tab) {
    activeTab.value = tab;
  }

  // Logic to mark all alerts as read
  void markAllRead() {
    alerts.assignAll(
      alerts
          .map(
            (alert) => UserAlert(
              id: alert.id,
              title: alert.title,
              message: alert.message,
              time: alert.time,
              icon: alert.icon,
              iconColor: alert.iconColor,
              isUnread: false,
            ),
          )
          .toList(),
    );

    // Sort to put read items below
    alerts.sort((a, b) => a.isUnread ? -1 : 1);
  }
}
