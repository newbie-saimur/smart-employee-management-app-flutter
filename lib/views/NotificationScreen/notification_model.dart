import 'package:flutter/material.dart';

Color _getColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

class UserAlert {
  final String id;
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color iconColor;
  final bool isUnread;

  UserAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconColor,
    this.isUnread = false,
  });
}

class CompanyNotice {
  final String id;
  final String title;
  final String snippet;
  final String category; // Critical, HR Policy, Event, Holiday
  final String time;
  final bool isPinned;
  final String? attachment;

  CompanyNotice({
    required this.id,
    required this.title,
    required this.snippet,
    required this.category,
    required this.time,
    this.isPinned = false,
    this.attachment,
  });
}

final List<UserAlert> mockAlerts = [
  UserAlert(
    id: 'A-001',
    title: 'Leave Approved',
    message:
        'Your Casual Leave for Dec 16-18 has been approved by Abdul Hamid.',
    time: '2m ago',
    icon: Icons.check_circle_outline,
    iconColor: const Color(0xFF0F766E),
    isUnread: true,
  ),
  UserAlert(
    id: 'A-002',
    title: 'Login Attempt',
    message: 'New login detected from Chrome on Windows.',
    time: 'Yesterday',
    icon: Icons.person_add_alt_1_outlined,
    iconColor: _getColor("2563EB"),
    isUnread: false,
  ),
  UserAlert(
    id: 'A-003',
    title: 'Expense Paid',
    message: 'Your expense claim for Travel (৳5,500) has been reimbursed.',
    time: 'Nov 20',
    icon: Icons.receipt_outlined,
    iconColor: _getColor("F97316"),
    isUnread: true,
  ),
];

final List<CompanyNotice> mockNotices = [
  CompanyNotice(
    id: 'N-001',
    title: 'Server Maintenance',
    snippet:
        'HR Portal will be down for scheduled maintenance on Tuesday, Dec 16 from 10:00 PM to 02:00 AM.',
    category: 'Critical',
    time: '2 hours ago',
    isPinned: true,
  ),
  CompanyNotice(
    id: 'N-002',
    title: 'New WFH Guidelines',
    snippet:
        'We have updated the remote work policy for Q4. Employees can now avail 2 days of remote work per week...',
    category: 'HR Policy',
    time: 'Yesterday',
    isPinned: false,
  ),
  CompanyNotice(
    id: 'N-003',
    title: 'Annual Sports Day 🏏',
    snippet: 'Registration is open for the Annual Cricket Tournament.',
    category: 'Event',
    time: 'Nov 18',
    isPinned: false,
    attachment: 'Form.pdf',
  ),
];
