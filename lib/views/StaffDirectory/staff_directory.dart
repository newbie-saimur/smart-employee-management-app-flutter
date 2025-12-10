import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/controllers/staff_directory_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/SingleStaffProfile/staff_profile_screen.dart';
import 'package:smart_employee_management/views/StaffDirectory/staff_member_model.dart';

class StaffDirectoryScreen extends GetView<StaffDirectoryController> {
  const StaffDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StaffDirectoryController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
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
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
            const Text(
              'Staff Directory',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // Search & Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Input Field
                TextField(
                  onChanged: controller.updateSearch,
                  decoration: InputDecoration(
                    hintText: 'Search name, role...',
                    hintStyle: TextStyle(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.secondaryTextColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF2563EB),
                        width: 2,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 16),

                // Filter Chips
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: controller.departments.keys
                        .map(
                          (key) => _buildFilterChip(
                            key,
                            controller.departments[key]!,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          // Staff List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildEmployeeList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filterKey, String label) {
    return Obx(() {
      final isActive = controller.currentFilter.value == filterKey;
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ActionChip(
          label: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : const Color(0xFF64748B),
            ),
          ),
          backgroundColor: isActive ? const Color(0xFF1E293B) : Colors.white,
          side: BorderSide(
            color: isActive ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
          ),
          onPressed: () => controller.setFilter(filterKey),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      );
    });
  }

  Widget _buildEmployeeCard(StaffMember staff) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFFF1F5F9), width: 1),
        ),
        child: InkWell(
          onTap: () {
            Get.to(() => StaffProfileScreen(staff: staff));
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Avater Section
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: getColorFromHex(staff.color),
                  ),
                  child: Center(
                    child: Text(
                      staff.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Name & Designation
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        staff.role,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Action Button
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildActionButton(Icons.phone_outlined),
                    const SizedBox(width: 8),
                    _buildActionButton(Icons.message_outlined),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Phone & Chat Button
  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18, color: const Color(0xFF64748B)),
        onPressed: () {
          // নেভিগেশন লজিক (Call/Chat)
        },
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildEmployeeList() {
    return Obx(() {
      final groupedStaff = controller.groupedStaff;
      if (groupedStaff.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.search_off, size: 40, color: Color(0xFFA1A1AA)),
              SizedBox(height: 10),
              Text(
                'No employees found',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        );
      }

      return ListView(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        children: groupedStaff.keys.map((deptKey) {
          final staffList = groupedStaff[deptKey]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Department Name
              if (!controller.isSearchingOrFiltering)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                  child: Text(
                    controller.departments[deptKey] ?? 'Other Staff',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA1A1AA),
                      letterSpacing: 1,
                    ),
                  ),
                ),

              // Staff Card
              ...staffList.map((staff) => _buildEmployeeCard(staff)),
            ],
          );
        }).toList(),
      );
    });
  }
}
