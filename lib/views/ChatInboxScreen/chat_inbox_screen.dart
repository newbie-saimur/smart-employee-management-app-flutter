import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/controllers/chat_inbox_controller.dart';
import 'package:smart_employee_management/views/ChatDetailsScreen/chat_details_screen.dart';
import 'package:smart_employee_management/views/ChatInboxScreen/chat_model.dart';

const Color _kPrimaryBlue = Color(0xFF2563EB);
const Color _kDarkSlate = Color(0xFF1E293B);
const Color _kMutedText = Color(0xFF64748B);
const Color _kReadText = Color(0xFF94A3B8);

class ChatInboxScreen extends GetView<ChatInboxController> {
  const ChatInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatInboxController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _kDarkSlate,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(
                    () => Text(
                      'You have ${controller.filteredChats.where((c) => c.unreadCount > 0).length} unread conversations',
                      style: const TextStyle(fontSize: 12, color: _kMutedText),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: _kPrimaryBlue,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 90,
      ),

      body: Column(
        children: [
          // SEARCH & FILTER
          _buildSearchAndFilter(),

          // CHAT LIST
          Expanded(
            child: Obx(() {
              if (controller.filteredChats.isEmpty) {
                return _buildNoResults();
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: controller.filteredChats.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: 4,
                      ),
                      child: Text(
                        'Recent',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _kReadText,
                          letterSpacing: 0.8,
                        ),
                      ),
                    );
                  }
                  final chat = controller.filteredChats[index - 1];
                  return _buildChatItem(context, chat);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Search Input
          TextField(
            onChanged: controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'Search messages...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFFA1A1AA)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: _kPrimaryBlue, width: 2),
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _kDarkSlate,
            ),
          ),
          const SizedBox(height: 16),

          // Filter Chips
          Obx(
            () => Row(
              children: [
                _buildFilterChip('all', 'All Chats'),
                _buildFilterChip('group', 'Groups'),
                _buildFilterChip('direct', 'Direct'),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filterKey, String label) {
    final isActive = controller.currentFilter.value == filterKey;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ActionChip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.white : _kMutedText,
          ),
        ),
        backgroundColor: isActive ? _kDarkSlate : Colors.white,
        side: BorderSide(
          color: isActive ? _kDarkSlate : const Color(0xFFE2E8F0),
        ),
        onPressed: () => controller.setFilter(filterKey),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, ChatItem chat) {
    final bool isUnread = chat.unreadCount > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
          ],
        ),
        child: InkWell(
          onTap: () {
            Get.to(ChatDetailsScreen(chatItem: chat));
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Avatar/Icon
                _buildAvatar(chat),
                const SizedBox(width: 16),

                // Details (Name and Last Message)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isUnread
                              ? FontWeight.bold
                              : FontWeight.w600,
                          color: _kDarkSlate,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        chat.lastMessage,
                        style: TextStyle(
                          fontSize: 12,
                          color: isUnread ? _kDarkSlate : _kMutedText,
                          fontWeight: isUnread
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Time and Unread Count
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      chat.lastTime,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isUnread
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isUnread ? _kPrimaryBlue : _kReadText,
                      ),
                    ),
                    if (isUnread)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _kPrimaryBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          chat.unreadCount.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(ChatItem chat) {
    Widget avatarContent;

    if (chat.type == 'group') {
      avatarContent = Icon(
        Icons.group_outlined,
        size: 28,
        color: chat.avatarColor,
      );
    } else {
      avatarContent = Text(
        chat.avatarText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      );
    }

    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: chat.type == 'group'
                ? chat.avatarColor.withOpacity(0.1)
                : chat.avatarColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Center(child: avatarContent),
        ),
        if (chat.isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.green.shade500,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.message_outlined, size: 40, color: Color(0xFFA1A1AA)),
          SizedBox(height: 10),
          Text(
            'No conversations found',
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
}
