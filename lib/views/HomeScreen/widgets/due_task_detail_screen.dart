import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/views/NavBarView/nav_bar_view.dart';

const Color _kDarkSlate = Color(0xFF1E293B);
const Color _kMutedText = Color(0xFF64748B);
const Color _kLightBackground = Color(0xFFF8FAFC);

class DueTaskDetailScreen extends StatelessWidget {
  final Map taskData;
  const DueTaskDetailScreen({super.key, required this.taskData});

  Color _getPriorityColor(String priority) {
    if (priority == "High") return const Color(0xFFE53935);
    if (priority == "Medium") return const Color(0xFFFFB300);
    return const Color(0xFF673AB7);
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: _kMutedText),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA1A1AA),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: _kDarkSlate,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color priorityColor = _getPriorityColor(taskData['priority']);

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
              'Task Details',
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: priorityColor.withValues(alpha: .5),
                  width: 2,
                ),
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Priority: ${taskData['priority'].toUpperCase()}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    taskData['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _kDarkSlate,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    taskData['description'],
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: _kMutedText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Key Details Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .03),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    Icons.calendar_today_outlined,
                    'Due Date',
                    '${taskData['month']} ${taskData['dateNumber']}, ${taskData['time']}',
                  ),
                  const Divider(
                    color: Color(0xFFF1F5F9),
                    height: 10,
                    thickness: 1,
                  ),
                  _buildDetailRow(
                    Icons.upload_file_outlined,
                    'Submission To',
                    '${taskData['submitTo']['name']} (${taskData['submitTo']['designation']})',
                  ),
                  const Divider(
                    color: Color(0xFFF1F5F9),
                    height: 10,
                    thickness: 1,
                  ),
                  _buildDetailRow(
                    Icons.access_time,
                    'Time Remaining',
                    taskData['dueDateStatus'],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Action Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar('Action', 'Task marked as completed!');
                  Get.to(NavBarView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getPriorityColor("High"),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Mark as Complete",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
