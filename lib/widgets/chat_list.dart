import 'package:flutter/material.dart';
import 'package:whatsapp/info.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/widgets/my_message_card.dart';
import 'package:whatsapp/widgets/sender_message_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chatList = messages.map((e) => ChatModel.fromMap(e)).toList();

    return ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        ChatModel chatItem = chatList[index];
        if (chatItem.isMe == true) {
          return MyMessageCard(message: chatItem.text, date: chatItem.time);
        }
        return SenderMessageCard(message: chatItem.text, date: chatItem.time);
      },
    );
  }
}
