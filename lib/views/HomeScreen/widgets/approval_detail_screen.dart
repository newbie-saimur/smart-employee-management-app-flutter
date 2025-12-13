import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/views/NavBarView/nav_bar_view.dart';

const Color _kPrimaryBlue = Color(0xFF2563EB);
const Color _kDarkSlate = Color(0xFF1E293B);
const Color _kMutedText = Color(0xFF64748B);
const Color _kLightBackground = Color(0xFFF8FAFC);
const Color _kWarningOrange = Color(0xFFF97316);
const Color _kSuccessGreen = Color(0xFF0F766E);

class ApprovalDetailScreen extends StatelessWidget {
  final Map approvalData;
  const ApprovalDetailScreen({super.key, required this.approvalData});

  Color _getTypeAccentColor(String requestType) {
    if (requestType.contains("Leave")) return const Color(0xFF4CAF50);
    if (requestType.contains("Pay Slip")) return _kPrimaryBlue;
    return _kWarningOrange;
  }

  Widget _buildDetailRow(String label, String value, {bool isStrong = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: _kMutedText)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                color: _kDarkSlate,
                fontWeight: isStrong ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String requestType = approvalData['requestType'];
    final String requestedByName = approvalData['requestedBy']['name'];
    final Color accentColor = _getTypeAccentColor(requestType);
    final details = approvalData['details'] ?? {};

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
              'Request Review',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _kDarkSlate,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                'PENDING',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Requestor Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
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
                  Text(
                    requestType,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    requestedByName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _kDarkSlate,
                    ),
                  ),
                  Text(
                    approvalData['requestedBy']['designation'],
                    style: const TextStyle(fontSize: 14, color: _kMutedText),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFFF1F5F9), height: 1),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    'Department',
                    approvalData['department'],
                    isStrong: true,
                  ),
                  _buildDetailRow(
                    'Submitted On',
                    approvalData['submissionDate'].split(' ')[0],
                    isStrong: false,
                  ),
                ],
              ),
            ),

            // Contextual Details Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request Details'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA1A1AA),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Dynamic Fields based on Request Type
                  if (requestType.contains("Leave")) ...[
                    _buildDetailRow(
                      'Leave Type',
                      details['leaveType'] ?? 'N/A',
                      isStrong: true,
                    ),
                    _buildDetailRow(
                      'Duration',
                      '${details['durationDays']} Days',
                      isStrong: true,
                    ),
                    _buildDetailRow(
                      'Dates',
                      '${details['startDate']} to ${details['endDate']}',
                      isStrong: false,
                    ),
                    const Divider(color: Color(0xFFF1F5F9), height: 16),
                    _buildDetailRow(
                      'Balance Before',
                      '${details['balanceBefore']} Days',
                      isStrong: false,
                    ),
                    _buildDetailRow(
                      'Handover To',
                      details['handoverTo']['name'] ?? 'N/A',
                      isStrong: false,
                    ),
                  ] else if (requestType.contains("Pay Slip")) ...[
                    _buildDetailRow(
                      'Access Type',
                      details['accessType'] ?? 'N/A',
                      isStrong: true,
                    ),
                    _buildDetailRow(
                      'Affected Month',
                      details['affectedMonth'] ?? 'N/A',
                      isStrong: false,
                    ),
                  ] else if (requestType.contains("General")) ...[
                    _buildDetailRow(
                      'Requested Item',
                      details['item'] ?? 'N/A',
                      isStrong: true,
                    ),
                  ],

                  const Divider(color: Color(0xFFF1F5F9), height: 16),

                  // Reason Section
                  const Text(
                    'Reason',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _kDarkSlate,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    details['reason'] ?? 'No reason provided.',
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: _kMutedText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),

      // Bottom Action Bar for Manager
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          MediaQuery.of(context).padding.bottom + 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Rejected',
                      '$requestType rejected.',
                      backgroundColor: Colors.red.shade100,
                    );
                    Get.to(NavBarView());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.red),
                    ),
                    elevation: 1,
                  ),
                  child: const Text(
                    "Reject",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Approved',
                      '$requestType approved!',
                      backgroundColor: Colors.green.shade100,
                    );
                    Get.to(NavBarView());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kSuccessGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Approve",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
