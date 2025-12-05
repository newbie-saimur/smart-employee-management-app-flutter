import 'package:get/get.dart';

class DashboardTaskTabController extends GetxController {
  RxBool isActiveUpNext = true.obs;
  RxBool isActiveApprovalRequired = false.obs;

  activeUpNext() {
    isActiveUpNext.value = true;
    isActiveApprovalRequired.value = false;
  }

  activeApprovedRequired() {
    isActiveUpNext.value = false;
    isActiveApprovalRequired.value = true;
  }
}
