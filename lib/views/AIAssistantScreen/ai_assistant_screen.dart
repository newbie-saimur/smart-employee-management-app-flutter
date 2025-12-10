import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/controllers/gemini_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/AIAssistantScreen/widgets/chat_bubble.dart';

class AiAssistantScreen extends StatelessWidget {
  const AiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GeminiController controller = Get.put(GeminiController());
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final messages = controller.messages.toList().reversed.toList();
              return ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(message: messages[index]);
                },
              );
            }),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                border: Border.all(
                  color: controller.isThinking.value
                      ? AppColors.borderColor
                      : AppColors.primaryColor.withValues(alpha: 0.2),
                  width: controller.isThinking.value ? 1 : 1.5,
                ),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.textController,
                      enabled: !controller.isThinking.value,
                      decoration: InputDecoration(
                        hintText: "Ask a policy question...",
                        hintStyle: TextStyle(
                          color: AppColors.secondaryTextColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                      ),
                      style: TextStyle(color: AppColors.primaryTextColor),
                      onSubmitted: controller.sendMessage,
                    ),
                  ),
                  InkWell(
                    onTap: controller.isThinking.value
                        ? null
                        : () => controller.sendMessage(
                            controller.textController.text,
                          ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: controller.isThinking.value
                            ? AppColors.secondaryTextColor
                            : AppColors.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10),
                        ],
                      ),
                      child: controller.isThinking.value
                          ? Padding(
                              padding: EdgeInsetsGeometry.all(10),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Icon(Icons.arrow_back_rounded),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 12,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 0.5,
                  blurStyle: BlurStyle.outer,
                  spreadRadius: 0.8,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            child: Center(
              child: Icon(Icons.auto_awesome_outlined, color: Colors.white),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Smart AI Assistant",
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Grounded in company policies",
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
