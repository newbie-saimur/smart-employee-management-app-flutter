import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

const Color _kPrimaryBlue = Color(0xFF2563EB);
const Color _kDarkSlate = Color(0xFF1E293B);
const Color _kMutedText = Color(0xFF64748B);
const Color _kLightBackground = Color(0xFFF8FAFC);

class MeetingDetailScreen extends StatelessWidget {
  final Map meetingData;
  const MeetingDetailScreen({super.key, required this.meetingData});

  void _launchMeetingLink(String? url) async {
    if (url == null) {
      Get.snackbar(
        'Info',
        'Meeting link is not provided.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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
    final bool isLinkAvailable =
        meetingData['link'] != null && meetingData['link'].isNotEmpty;

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
              'Meeting Details',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Meeting Title Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _kPrimaryBlue.withValues(alpha: .5),
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
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _kPrimaryBlue.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Upcoming Meeting',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _kPrimaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    meetingData['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _kDarkSlate,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meetingData['description'],
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
              padding: const EdgeInsets.all(24),
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
                    'Date & Time',
                    '${meetingData['month']} ${meetingData['dateNumber']}, ${meetingData['time']}',
                  ),
                  const Divider(
                    color: Color(0xFFF1F5F9),
                    height: 10,
                    thickness: 1,
                  ),
                  _buildDetailRow(
                    Icons.videocam_outlined,
                    'Platform',
                    meetingData['meetingPlatform'],
                  ),
                  const Divider(
                    color: Color(0xFFF1F5F9),
                    height: 10,
                    thickness: 1,
                  ),
                  _buildDetailRow(
                    Icons.person_outline,
                    'Organizer',
                    '${meetingData['organizedBy']['name']} (${meetingData['organizedBy']['designation']})',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Action Button (Join Meeting)
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: isLinkAvailable
                    ? () => _launchMeetingLink(meetingData['link'])
                    : null,
                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                label: Text(
                  isLinkAvailable ? "Join Meeting" : "No Link Available",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPrimaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
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
