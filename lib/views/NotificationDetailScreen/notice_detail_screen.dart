import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/views/NotificationScreen/notification_model.dart';

const Color _kPrimaryBlue = Color(0xFF2563EB);
const Color _kDarkSlate = Color(0xFF1E293B);
const Color _kMutedText = Color(0xFF64748B);
const Color _kArticleText = Color(0xFF334155);
const Color _kRoseRed = Color(0xFFEF4444);

class NoticeDetailScreen extends StatelessWidget {
  final CompanyNotice notice;

  const NoticeDetailScreen({super.key, required this.notice});

  Map<String, Color> _getBadgeColors(String category) {
    if (category == 'Critical') {
      return {
        'bg': Colors.red.shade50,
        'color': _kRoseRed,
        'accent': _kRoseRed,
      };
    } else if (category == 'HR Policy') {
      return {
        'bg': _kPrimaryBlue.withValues(alpha: .1),
        'color': _kPrimaryBlue,
        'accent': _kPrimaryBlue,
      };
    } else if (category == 'Event') {
      return {
        'bg': Colors.green.shade50,
        'color': Colors.green.shade600,
        'accent': Colors.green.shade600,
      };
    }
    return {
      'bg': Colors.grey.shade100,
      'color': _kMutedText,
      'accent': _kMutedText,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getBadgeColors(notice.category);

    final String fullContent = notice.category == 'Critical'
        ? '''
Dear Employees,

Please be advised that the HR Portal (Leaves, Payslips, Expenses) will undergo critical system maintenance this Friday, November 24th.

Maintenance Window
• Start: Friday 10:00 PM
• End: Saturday 02:00 AM (4 hours)
• The application will be completely inaccessible during this time.

Action Required
Please ensure all pending leave and expense applications are submitted before 9:00 PM Friday. Any unsaved data during the downtime may be lost.

Thank you for your cooperation.
— The IT and HR Teams
'''
        : '''
${notice.title} Update:

${notice.snippet}

Full details are available in the attached document. Please review the updated policies regarding remote work eligibility and submission procedures. Compliance is mandatory for Q4.
''';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              'Announcement',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metadata and Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors['bg'],
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    notice.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colors['color'],
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

            // Title
            const SizedBox(height: 16),
            Text(
              notice.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: _kDarkSlate,
              ),
            ),

            // Author/Source
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: [
                  Icon(
                    notice.category == 'Critical'
                        ? Icons.error_outline
                        : Icons.info_outline,
                    size: 16,
                    color: const Color(0xFFA1A1AA),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Issued by: ${notice.category == 'Critical' ? 'IT Department' : 'HR Team'}',
                    style: const TextStyle(fontSize: 14, color: _kMutedText),
                  ),
                ],
              ),
            ),

            // Body Content
            Text(
              fullContent,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: _kArticleText,
              ),
            ),

            // Attachment
            if (notice.attachment != null)
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_file,
                            color: colors['accent'],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            notice.attachment!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _kDarkSlate,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.download_outlined,
                          color: colors['accent'],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
