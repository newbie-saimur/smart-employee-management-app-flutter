import 'package:flutter/material.dart';

class ChatItem {
  final String id;
  final String name;
  final String lastMessage;
  final String lastTime;
  final String type;
  final int unreadCount;
  final String avatarText;
  final bool isOnline;
  final Color avatarColor;

  ChatItem({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastTime,
    required this.type,
    this.unreadCount = 0,
    required this.avatarText,
    this.isOnline = false,
    required this.avatarColor,
  });
}

final List<ChatItem> mockChats = [
  ChatItem(
    id: "CHAT-001",
    name: "Engineering Team",
    lastMessage: "Nazmul: The report is ready.",
    lastTime: "9:32 AM",
    type: "group",
    unreadCount: 3,
    avatarText: "ENG",
    isOnline: true,
    avatarColor: const Color(0xFF2563EB),
  ),
  ChatItem(
    id: "CHAT-002",
    name: "Abdul Hamid (HR)",
    lastMessage: "Leave request approved ✅",
    lastTime: "Yesterday",
    type: "direct",
    unreadCount: 0,
    avatarText: "AH",
    isOnline: true,
    avatarColor: const Color(0xFF1E293B),
  ),
  ChatItem(
    id: "CHAT-003",
    name: "Zara Khan",
    lastMessage: "Can you check the Figma file?",
    lastTime: "Mon",
    type: "direct",
    unreadCount: 0,
    avatarText: "ZK",
    isOnline: false,
    avatarColor: const Color(0xFF7C3AED),
  ),
  ChatItem(
    id: "CHAT-004",
    name: "Finance Dept",
    lastMessage: "Payslip generated for Oct.",
    lastTime: "Oct 30",
    type: "group",
    unreadCount: 0,
    avatarText: "FIN",
    isOnline: false,
    avatarColor: const Color(0xFF0F766E),
  ),
  ChatItem(
    id: "CHAT-005",
    name: "Faria Islam (Marketing)",
    lastMessage: "Need approval for campaign budget.",
    lastTime: "10:00 AM",
    type: "direct",
    unreadCount: 1,
    avatarText: "FI",
    isOnline: true,
    avatarColor: const Color(0xFFF97316),
  ),
  ChatItem(
    id: "CHAT-006",
    name: "HR Policy Updates",
    lastMessage: "The new dress code memo is attached.",
    lastTime: "Nov 15",
    type: "group",
    unreadCount: 0,
    avatarText: "HR",
    isOnline: false,
    avatarColor: const Color(0xFFEF4444),
  ),
  ChatItem(
    id: "CHAT-007",
    name: "Karim Hassan",
    lastMessage: "I finished the QA test cases.",
    lastTime: "11:20 AM",
    type: "direct",
    unreadCount: 0,
    avatarText: "KH",
    isOnline: true,
    avatarColor: const Color(0xFF16A34A),
  ),
];
