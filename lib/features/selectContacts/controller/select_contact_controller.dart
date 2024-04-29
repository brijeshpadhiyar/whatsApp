import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/selectContacts/repository/select_contact_repo.dart';

final getContactProvider = FutureProvider<List<Contact>?>((ref) async {
  return await ref.watch(selectContactRepoProvider).getContacts();
});

final selectContactControllerProvider = Provider<SelectContactController>((ref) {
  return SelectContactController(ref: ref, selectContactRepository: ref.watch(selectContactRepoProvider));
});

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  SelectContactController({required this.ref, required this.selectContactRepository});

  void selectContact(Contact selectedContact, BuildContext context) async {
    await selectContactRepository.selectContact(selectedContact, context);
  }
}
