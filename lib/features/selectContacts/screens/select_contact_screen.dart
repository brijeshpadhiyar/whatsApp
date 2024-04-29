import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:whatsapp/common/widgets/error_screen.dart';
import 'package:whatsapp/common/widgets/loader.dart';
import 'package:whatsapp/features/selectContacts/controller/select_contact_controller.dart';

class SelectContactScreen extends ConsumerWidget {
  const SelectContactScreen({super.key});

  void _selectContact(WidgetRef ref, Contact selContact, BuildContext context) {
    ref.read(selectContactControllerProvider).selectContact(selContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select contact"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ref.watch(getContactProvider).when(
          data: (data) {
            if (data != null) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final contact = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      onTap: () => _selectContact(ref,contact,context),
                      title: Text(
                        contact.displayName,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      leading: contact.photo == null
                          ? null
                          : CircleAvatar(
                              backgroundImage: MemoryImage(contact.photo!),
                              radius: 30,
                            ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
          error: (error, stackTrace) {
            return ErrorScreen(error: error.toString());
          },
          loading: () => const Loader()),
    );
  }
}
