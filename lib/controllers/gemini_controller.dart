import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/views/AIAssistantScreen/widgets/gemini_services.dart';

enum Sender { user, bot }

class Message {
  final String text;
  final Sender sender;
  final bool isError;

  Message({required this.text, required this.sender, this.isError = false});
}

class GeminiController extends GetxController {
  var messages = <Message>[].obs;
  var isThinking = false.obs;

  final TextEditingController textController = TextEditingController();
  final GeminiService _geminiService = GeminiService();

  @override
  void onInit() {
    messages.add(
      Message(
        text:
            "Hi Saimur, I am here to answer questions about HR policies, benefits, and company resources. How can I help you today?",
        sender: Sender.bot,
      ),
    );
    super.onInit();
  }

  Future<String> _loadContextualData(String userQuery) async {
    await Future.delayed(Duration(milliseconds: 100));

    const int casualLeave = 10;
    const int sickLeave = 14;
    const int emergencyLeave = 3;
    const String employeeName = "Saimur Rahman";
    const String employeeRole = "Flutter Developer";

    if (userQuery.toLowerCase().contains('leave') ||
        userQuery.toLowerCase().contains('ছুটি') ||
        userQuery.toLowerCase().contains('balance')) {
      return "Current Employee Leave Balances: Casual Leave Remaining: $casualLeave days, Sick Leave Remaining: $sickLeave days, Emergency Leave Remaining: $emergencyLeave days. Use this data to answer.";
    }

    return "Current user is $employeeName, $employeeRole. Their ID is EMP-2024.";
  }

  // Getting user query and call api
  Future<void> sendMessage(String prompt) async {
    if (prompt.trim().isEmpty) return;

    final originalPrompt = prompt.trim();
    textController.clear();

    // Add the users message in the UI
    messages.add(Message(text: originalPrompt, sender: Sender.user));

    // Load data from the DB
    final contextualData = await _loadContextualData(originalPrompt);

    // Creating main prompt
    final finalPrompt =
        "Employee Context: $contextualData\n\nUser Question: $originalPrompt";

    // Enable Loading state
    isThinking.value = true;

    // Showing processing bubble in the UI
    messages.add(
      Message(
        text: "Processing your request...",
        sender: Sender.bot,
        isError: false,
      ),
    );

    // to refresh the UI fast
    messages.refresh();

    // Calling Gemini API
    final response = await _geminiService.getAiResponse(finalPrompt);

    // Remove loading message and replace with real response
    messages.removeLast();

    isThinking.value = false;

    if (response.startsWith("ERROR:")) {
      messages.add(
        Message(
          text:
              "Sorry, I encountered an issue. Please try again later. ($response)",
          sender: Sender.bot,
          isError: true,
        ),
      );
    } else {
      messages.add(Message(text: response, sender: Sender.bot));
    }

    messages.refresh();
  }
}
