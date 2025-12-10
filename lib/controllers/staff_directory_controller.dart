import 'package:get/get.dart';
import 'package:smart_employee_management/views/StaffDirectory/staff_member_model.dart';

class StaffDirectoryController extends GetxController {
  var searchQuery = ''.obs;
  var currentFilter = 'all'.obs;
  var filteredStaff = <StaffMember>[].obs;

  final staffData = allStaff;
  final departments = deptNames;

  @override
  void onInit() {
    _filterStaff();
    super.onInit();
  }

  void updateSearch(String query) {
    searchQuery.value = query.toLowerCase();
    _filterStaff();
  }

  void setFilter(String filter) {
    currentFilter.value = filter;
    _filterStaff();
  }

  void _filterStaff() {
    List<StaffMember> results = staffData;

    // 1. Filter by Department
    if (currentFilter.value != 'all') {
      results = results
          .where((staff) => staff.dept == currentFilter.value)
          .toList();
    }

    // 2. Filter by Search Query
    if (searchQuery.value.isNotEmpty) {
      results = results.where((staff) {
        final info = '${staff.name.toLowerCase()} ${staff.role.toLowerCase()}';
        return info.contains(searchQuery.value);
      }).toList();
    }

    // Update the observable list
    filteredStaff.value = results;
  }

  bool get isSearchingOrFiltering =>
      searchQuery.value.isNotEmpty || currentFilter.value != 'all';

  Map<String, List<StaffMember>> get groupedStaff {
    if (filteredStaff.isEmpty) return {};

    if (isSearchingOrFiltering) {
      return {'Search Results': filteredStaff};
    } else {
      Map<String, List<StaffMember>> grouped = {};
      for (var staff in filteredStaff) {
        grouped.putIfAbsent(staff.dept, () => []).add(staff);
      }
      return grouped;
    }
  }
}
