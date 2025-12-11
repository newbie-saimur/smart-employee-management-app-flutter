import 'package:flutter/material.dart';

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

class Course {
  final String title;
  final String subtitle;
  final String status;
  final String audience;
  final double progress;
  final String colorHex;

  Course({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.audience,
    required this.progress,
    required this.colorHex,
  });
}

class Document {
  final String title;
  final String category;
  final String fileSize;
  final String audience;
  final IconData icon;

  Document({
    required this.title,
    required this.category,
    required this.fileSize,
    required this.audience,
    required this.icon,
  });
}

final List<Course> mockCourses = [
  Course(
    title: "Flutter Advanced Patterns",
    subtitle: "Module 1 of 14 • Due Jan 30, 2026",
    status: "In Progress",
    audience: "Engineering",
    progress: 0.072,
    colorHex: "2563EB",
  ),
  Course(
    title: "Cyber Security Basics",
    subtitle: "Finished on Oct 15",
    status: "Completed",
    audience: "All Staff",
    progress: 1.0,
    colorHex: "059669",
  ),
];

final List<Document> mockDocuments = [
  Document(
    title: "Employee Handbook",
    category: "General",
    fileSize: "2.5 MB",
    audience: "General",
    icon: Icons.book_outlined,
  ),
  Document(
    title: "Health Insurance Policy",
    category: "Legal",
    fileSize: "1.0 MB",
    audience: "Legal",
    icon: Icons.shield_outlined,
  ),
  Document(
    title: "API Documentation",
    category: "Tech",
    fileSize: "v2.4",
    audience: "Eng. Only",
    icon: Icons.code_outlined,
  ),
];
