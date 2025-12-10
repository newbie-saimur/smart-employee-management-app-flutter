import 'package:flutter/material.dart';

class StaffMember {
  final String id;
  final String name;
  final String role;
  final String dept;
  final String initials;
  final String color;
  final String phone;
  final String email;
  final String reportingToName;
  final String deskLocation;

  StaffMember({
    required this.id,
    required this.name,
    required this.role,
    required this.dept,
    required this.initials,
    required this.color,
    required this.phone,
    required this.email,
    required this.reportingToName,
    required this.deskLocation,
  });
}

final List<StaffMember> allStaff = [
  StaffMember(
    id: "EMP-001",
    name: "Saimur Rahman",
    role: "Flutter Developer",
    dept: "engineering",
    initials: "SR",
    color: "2563EB",
    phone: "+8801625047922",
    email: "saimurrahmanarnob@gmail.com",
    reportingToName: "Abdul Hamid",
    deskLocation: "Level 4, Zone B",
  ),
  StaffMember(
    id: "EMP-002",
    name: "Farhana Ali",
    role: "UI/UX Designer",
    dept: "design",
    initials: "FA",
    color: "7C3AED",
    phone: "+8801643464994",
    email: "farhanaali@gmail.com",
    reportingToName: "Zara Khan",
    deskLocation: "Level 2, Zone D",
  ),
  StaffMember(
    id: "EMP-003",
    name: "Eyamin Hossain",
    role: "Marketing Lead",
    dept: "marketing",
    initials: "EH",
    color: "0F766E",
    phone: "+880-1711-234569",
    email: "eyamin.h@corp.com",
    reportingToName: "Faria Islam",
    deskLocation: "Level 3, Zone A",
  ),
  StaffMember(
    id: "EMP-004",
    name: "Rana Miah",
    role: "Content Creator",
    dept: "marketing",
    initials: "RM",
    color: "F97316",
    phone: "+880-1711-234570",
    email: "rana.m@corp.com",
    reportingToName: "Faria Islam",
    deskLocation: "Level 3, Zone A",
  ),
  StaffMember(
    id: "EMP-005",
    name: "Abdul Hamid",
    role: "HR Manager",
    dept: "hr",
    initials: "AH",
    color: "EF4444",
    phone: "+880-1711-234571",
    email: "abdul.h@corp.com",
    reportingToName: "CEO",
    deskLocation: "Executive Floor",
  ),
  StaffMember(
    id: "EMP-006",
    name: "Karim Hassan",
    role: "QA Engineer",
    dept: "engineering",
    initials: "KH",
    color: "16A34A",
    phone: "+880-1711-234572",
    email: "karim.h@corp.com",
    reportingToName: "Saimur Rahman",
    deskLocation: "Level 4, Zone C",
  ),
  StaffMember(
    id: "EMP-007",
    name: "Nadia Akhter",
    role: "Financial Analyst",
    dept: "finance",
    initials: "NA",
    color: "9333EA",
    phone: "+880-1711-234573",
    email: "nadia.a@corp.com",
    reportingToName: "Abdul Hamid",
    deskLocation: "Level 5, Zone B",
  ),
];

final Map<String, String> deptNames = {
  'all': 'All',
  'engineering': 'Engineering',
  'marketing': 'Marketing',
  'design': 'Design Team',
  'hr': 'HR',
  'finance': 'Finance',
};

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}
