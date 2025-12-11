import 'package:get/get.dart';
import 'package:smart_employee_management/views/ChatInboxScreen/chat_model.dart';

class ChatInboxController extends GetxController {
  var searchQuery = ''.obs;
  var currentFilter = 'all'.obs; // 'all', 'group', 'direct'

  final List<ChatItem> _allChats = mockChats;

  // Computed Property for filtered list
  List<ChatItem> get filteredChats {
    List<ChatItem> results = _allChats;

    // Filter by Search Query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      results = results
          .where(
            (chat) =>
                chat.name.toLowerCase().contains(query) ||
                chat.lastMessage.toLowerCase().contains(query),
          )
          .toList();
    }

    // Filter by Chat Type
    if (currentFilter.value != 'all') {
      results = results
          .where((chat) => chat.type == currentFilter.value)
          .toList();
    }

    // Sort to keep unread chats and pinned groups at the top
    results.sort((a, b) {
      if (a.unreadCount > 0 && b.unreadCount == 0) return -1;
      if (a.unreadCount == 0 && b.unreadCount > 0) return 1;
      return 0;
    });

    return results;
  }

  // Logic to update the filter chip
  void setFilter(String type) {
    currentFilter.value = type;
  }

  // Logic to update search query
  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
