import 'package:get/get.dart';

class PayslipController extends GetxController {
  var isVisible = true.obs;
  var monthIndex = 0.obs;

  toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  nextMonth() {
    if (monthIndex.value > 0) monthIndex.value--;
  }

  previousMonth() {
    if (monthIndex.value < 10) monthIndex.value++;
  }
}
