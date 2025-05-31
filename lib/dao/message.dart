class Message {
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final String? sender;
  final String? senderRole;
  final bool isBot;

  Message({
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.sender,
    this.senderRole,
    this.isBot = false,
  });
}
