import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/info.dart';
import 'package:whatsapp/models/info_model.dart';
import 'package:whatsapp/screens/mobile_chat_screen.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    List<InfoModel> infoList = info.map((e) => InfoModel.fromMap(e)).toList();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: infoList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          InfoModel infoItem = infoList[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MobileChatScreen(),
                        ));
                  },
                  title: Text(
                    infoItem.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      infoItem.message,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(infoItem.profilePic),
                    radius: 30,
                  ),
                  trailing: Text(
                    infoItem.time,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const Divider(
                color: AppColor.dividerColor,
                indent: 85,
              ),
            ],
          );
        },
      ),
    );
  }
}
