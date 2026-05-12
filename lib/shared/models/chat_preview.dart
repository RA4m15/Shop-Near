class ChatPreview {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String emoji;
  final bool isOnline;
  final int unreadCount;

  ChatPreview({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.emoji,
    required this.isOnline,
    required this.unreadCount,
  });

  factory ChatPreview.fromMap(Map<String, dynamic> map) {
    return ChatPreview(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      time: map['time'] ?? '',
      emoji: map['emoji'] ?? '💬',
      isOnline: map['isOnline'] ?? false,
      unreadCount: map['unreadCount'] ?? 0,
    );
  }
}
