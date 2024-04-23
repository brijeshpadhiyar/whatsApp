import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  bool isMe;
  String text;
  String time;
  ChatModel({
    required this.isMe,
    required this.text,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isMe': isMe,
      'text': text,
      'time': time,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      isMe: map['isMe'] as bool,
      text: map['text'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
