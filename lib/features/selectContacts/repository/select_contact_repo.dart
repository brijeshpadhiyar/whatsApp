// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/utils/utils.dart';

final selectContactRepoProvider = Provider<SelectContactRepository>((ref) {
  return SelectContactRepository(firestore: FirebaseFirestore.instance);
});

class SelectContactRepository {
  final FirebaseFirestore _firestore;
  SelectContactRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future<List<Contact>?> getContacts() async {
    List<Contact>? contacts;
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  Future selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await _firestore.collection("users").get();
      bool isFound = false;
      for (var doc in userCollection.docs) {
        var userData = UserModel.fromMap(doc.data());
        String selecPhoneNum = selectedContact.phones[0].number.replaceAll(" ", "");
        if (selecPhoneNum == userData.number) {
          isFound = true;
        }
        if (!isFound) {
          showSnackbar(context: context, content: "This number does not exist on this app");
        }
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
