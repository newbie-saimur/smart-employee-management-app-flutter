import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/ChatInboxScreen/chat_model.dart';

const Color _kPrimaryBlue = Color(0xFF2563EB);
const Color _kDarkSlate = Color(0xFF1E293B);
const Color _kMutedText = Color(0xFF64748B);
const Color _kLightBackground = Color(0xFFF8FAFC);

class ChatMessage {
  final String senderId;
  final String text;
  final String time;
  final bool isRead;
  final String? attachmentName;
  final IconData? attachmentIcon;
  final String? attachmentSize;

  ChatMessage({
    required this.senderId,
    required this.text,
    required this.time,
    this.isRead = true,
    this.attachmentName,
    this.attachmentIcon,
    this.attachmentSize,
  });
}

final List<ChatMessage> mockMessages = [
  ChatMessage(
    senderId: 'other',
    text: "Hi Saimur, I've reviewed your leave request for next week.",
    time: "9:32 AM",
    isRead: true,
  ),
  ChatMessage(
    senderId: 'user',
    text: "Thanks, Sir! Do I need to submit any handover documents?",
    time: "9:33 AM",
    isRead: true,
  ),
  ChatMessage(
    senderId: 'other',
    text: "Yes, please fill this form.",
    time: "9:35 AM",
    isRead: true,
    attachmentName: "Handover_Form.pdf",
    attachmentIcon: Icons.description_outlined,
    attachmentSize: "1.2 MB",
  ),
  ChatMessage(
    senderId: 'user',
    text: "Got it, I'll send it by EOD today.",
    time: "9:40 AM",
    isRead: true,
  ),
  ChatMessage(
    senderId: 'other',
    text:
        "Received the acknowledgement. Please ensure the soft copy reaches me before 5 PM.",
    time: "9:45 AM",
    isRead: true,
  ),
  ChatMessage(
    senderId: 'user',
    text:
        "Understood. Should I notify you once the application is processed in the system?",
    time: "10:00 AM",
    isRead: true,
  ),
  ChatMessage(
    senderId: 'other',
    text:
        "That won't be necessary. HR will take it from here. Have a good trip!",
    time: "10:05 AM",
    isRead: true,
  ),
];

class ChatDetailsController extends GetxController {
  final ChatItem chatItem;

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxList<ChatMessage> messages = mockMessages.reversed.toList().obs;

  ChatDetailsController({required this.chatItem});

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.insert(
      0,
      ChatMessage(
        senderId: 'user',
        text: text,
        time: 'Just now',
        isRead: false,
      ),
    );

    messageController.clear();
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final String avatarText;

  const ChatBubble({
    super.key,
    required this.message,
    required this.avatarText,
  });

  Widget _buildFileAttachment() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kLightBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              message.attachmentIcon,
              color: Colors.red.shade500,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.attachmentName!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _kDarkSlate,
                  ),
                ),
                Text(
                  message.attachmentSize!,
                  style: const TextStyle(fontSize: 10, color: _kMutedText),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.download_outlined,
              color: Color(0xFF94A3B8),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSent = message.senderId == 'user';

    // Bubble Styling based on sender
    final Color bubbleColor = isSent ? _kPrimaryBlue : Colors.white;
    final Color textColor = isSent
        ? Colors.white
        : _kDarkSlate.withOpacity(0.9);
    final BorderRadius borderRadius = BorderRadius.only(
      bottomLeft: isSent ? const Radius.circular(16) : Radius.zero,
      bottomRight: isSent ? Radius.zero : const Radius.circular(16),
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isSent
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar (Received messages only)
          if (!isSent)
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8, bottom: 18),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  avatarText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          // Message Container
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Column(
              crossAxisAlignment: isSent
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: borderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.text,
                        style: TextStyle(fontSize: 14, color: textColor),
                      ),
                      if (message.attachmentName != null)
                        const SizedBox(height: 12),
                      if (message.attachmentName != null)
                        _buildFileAttachment(),
                    ],
                  ),
                ),

                // Time and Status
                Padding(
                  padding: EdgeInsets.only(
                    top: 4,
                    right: isSent ? 4 : 0,
                    left: isSent ? 0 : 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.time,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFFA1A1AA),
                        ),
                      ),
                      if (isSent) const SizedBox(width: 4),
                      if (isSent)
                        Icon(
                          message.isRead
                              ? Icons.done_all_outlined
                              : Icons.done_outlined,
                          size: 14,
                          color: message.isRead
                              ? _kPrimaryBlue
                              : const Color(0xFFA1A1AA),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatDetailsScreen extends GetView<ChatDetailsController> {
  final ChatItem chatItem;

  const ChatDetailsScreen({super.key, required this.chatItem});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatDetailsController(chatItem: chatItem));

    final chat = controller.chatItem;

    return Scaffold(
      backgroundColor: _kLightBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
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
            // User Info
            Row(
              children: [
                _buildAvatar(chat),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _kDarkSlate,
                      ),
                    ),
                    Text(
                      "${chat.type == 'direct' ? 'Manager' : 'Group'} • ${chat.isOnline ? 'Online' : 'Offline'}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: chat.isOnline ? _kPrimaryBlue : _kMutedText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            // Actions
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call_outlined, color: Color(0xFFA1A1AA)),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.videocam_outlined,
                color: Color(0xFFA1A1AA),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        toolbarHeight: 90,
      ),

      body: Column(
        children: [
          // Message List
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                reverse: true,
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                itemCount: controller.messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.messages.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.all(Radius.circular(99)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            child: Text(
                              "Today, 9:30 AM",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA1A1AA),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  final message = controller.messages[index];
                  return ChatBubble(
                    message: message,
                    avatarText: chat.avatarText,
                  );
                },
              ),
            ),
          ),

          _buildInputBar(context),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildAvatar(ChatItem chat) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              chat.avatarText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _kDarkSlate,
              ),
            ),
          ),
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

  Widget _buildInputBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle_outline,
                color: Color(0xFFA1A1AA),
              ),
            ),
            const SizedBox(width: 4),

            // Text Field
            Expanded(
              child: TextField(
                controller: controller.messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 15, color: _kDarkSlate),
              ),
            ),

            // Send Button
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: IconButton(
                onPressed: controller.sendMessage,
                icon: const Icon(Icons.send, color: Colors.white),
                style: IconButton.styleFrom(
                  backgroundColor: _kPrimaryBlue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
