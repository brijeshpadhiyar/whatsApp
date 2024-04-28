import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoryProvider = Provider<CommonFirebaseStorageRepository>((ref) {
  return CommonFirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance);
});

class CommonFirebaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  CommonFirebaseStorageRepository({required FirebaseStorage firebaseStorage}) : _firebaseStorage = firebaseStorage;

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downurl = await snapshot.ref.getDownloadURL();
    return downurl;
  }
}
