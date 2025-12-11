import 'package:get/get.dart';
import 'package:smart_employee_management/views/Resources/resources_model.dart';

class ResourcesController extends GetxController {
  var activeTab = 'all'.obs; // 'all', 'courses', 'docs'

  final List<Course> allCourses = mockCourses;
  final List<Document> allDocuments = mockDocuments;

  void filterContent(String type) {
    activeTab.value = type;
  }

  List<Course> get filteredCourses {
    if (activeTab.value == 'docs') {
      return [];
    }
    return allCourses;
  }

  List<Document> get filteredDocuments {
    if (activeTab.value == 'courses') {
      return [];
    }
    return allDocuments;
  }
}
