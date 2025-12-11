import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/controllers/resources_controller.dart';
import 'package:smart_employee_management/views/CourseDetailsScreen/course_details_screen.dart';
import 'package:smart_employee_management/views/NavBarView/nav_bar_view.dart';
import 'package:smart_employee_management/views/Resources/resources_model.dart';

class ResourcesScreen extends GetView<ResourcesController> {
  const ResourcesScreen({super.key});

  Future<bool> _onWillPop() async {
    Get.offAll(() => NavBarView());
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ResourcesController());

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
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
                onPressed: () => _onWillPop(),
              ),
              const SizedBox(width: 8),
              const Text(
                'Knowledge Base',
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
            // FILTER TABS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('all', 'All'),
                    _buildFilterChip('courses', 'Training'),
                    _buildFilterChip('docs', 'Documents'),
                  ],
                ),
              ),
            ),

            // CONTENT FEED
            Expanded(
              child: Obx(() {
                return ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  children: [
                    if (controller.activeTab.value != 'docs' &&
                        controller.filteredCourses.isNotEmpty)
                      _buildCourseSection(controller.filteredCourses),

                    if (controller.activeTab.value != 'courses' &&
                        controller.filteredDocuments.isNotEmpty)
                      _buildDocumentSection(controller.filteredDocuments),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filterKey, String label) {
    return Obx(() {
      final isActive = controller.activeTab.value == filterKey;
      return Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 8, top: 6),
        child: ActionChip(
          label: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isActive ? Colors.white : const Color(0xFF64748B),
            ),
          ),
          backgroundColor: isActive ? const Color(0xFF1E293B) : Colors.white,
          side: BorderSide(
            color: isActive ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
          ),
          onPressed: () => controller.filterContent(filterKey),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      );
    });
  }

  Widget _buildSectionHeader(String title, {double topPadding = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0, bottom: 12, top: topPadding),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFFA1A1AA),
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildCourseSection(List<Course> courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('My Learning'),
        ...courses.map(_buildCourseCard),
      ],
    );
  }

  Widget _buildDocumentSection(List<Document> documents) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Documents', topPadding: 16),
        ...documents.map(_buildDocumentCard),
      ],
    );
  }

  Widget _buildCourseCard(Course course) {
    final Color courseColor = getColorFromHex(course.colorHex);
    final isCompleted = course.status == 'Completed';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 4,
            ),
          ],
        ),
        child: Opacity(
          opacity: isCompleted ? 0.7 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: courseColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: courseColor.withValues(alpha: .2),
                      ),
                    ),
                    child: Text(
                      course.status,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: courseColor,
                      ),
                    ),
                  ),
                  // Audience Badge
                  Row(
                    children: [
                      Icon(
                        course.audience == 'Engineering'
                            ? Icons.code_outlined
                            : Icons.public,
                        size: 14,
                        color: const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        course.audience.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Text(
                course.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              Text(
                course.subtitle,
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),

              if (!isCompleted)
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: course.progress,
                        backgroundColor: const Color(0xFFF1F5F9),
                        color: courseColor,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {
                        Get.to(CourseDetailsScreen());
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: courseColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Resume',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentCard(Document doc) {
    final audienceColor = doc.audience == 'Eng. Only'
        ? const Color(0xFF2563EB)
        : const Color(0xFF64748B);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon/Avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(doc.icon, color: const Color(0xFF64748B), size: 20),
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
                        doc.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: audienceColor.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: audienceColor.withValues(alpha: .2),
                          ),
                        ),
                        child: Text(
                          doc.audience,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: audienceColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${doc.category} • ${doc.fileSize}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),

            // Download Button
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.download_outlined,
                color: Color(0xFFCBD5E1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
