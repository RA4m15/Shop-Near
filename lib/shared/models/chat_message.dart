class ChatMessage {
  final String text;
  final String sender;
  final String receiver;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.receiver,
    required this.timestamp,
    required this.isMe,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      text: map['text'] ?? '',
      sender: map['sender'] ?? '',
      receiver: map['receiver'] ?? '',
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
      isMe: map['isMe'] ?? false,
    );
  }
}
