import 'package:flutter/material.dart';
import 'package:smart_employee_management/controllers/gemini_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == Sender.user;
    final isError = message.isError;
    final isThinking = message.text == "Processing your request...";
    final hasSource = message.text.contains("Source:");

    final List<String> parts = hasSource
        ? message.text.split("\n\nSource:")
        : [message.text];
    final String mainText = parts[0];
    final String sourceText = hasSource ? parts[1].trim() : "";
    if (isThinking) {
      return Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          children: [
            _createBotAvatar(),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "AI is processing...",
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) _createBotAvatar(),
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser
                        ? AppColors.primaryTextColor
                        : (isError ? const Color(0xFFFEE2E2) : Colors.white),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isUser ? 20 : 0),
                      bottomRight: Radius.circular(isUser ? 0 : 20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mainText,
                        style: TextStyle(
                          color: isUser
                              ? Colors.white
                              : (isError
                                    ? Color(0xFF991B1B)
                                    : AppColors.primaryTextColor),
                          fontSize: 14,
                        ),
                      ),
                      if (hasSource && !isError)
                        Padding(
                          padding: EdgeInsetsGeometry.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: AppColors.borderColor,
                                thickness: 1,
                                height: 10,
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.link,
                                    color: AppColors.primaryColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Source: $sourceText",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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

  Container _createBotAvatar() {
    return Container(
      width: 32,
      height: 32,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        Icons.psychology_outlined,
        color: AppColors.primaryColor,
        size: 20,
      ),
    );
  }
}
