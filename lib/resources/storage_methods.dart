// ignore_for_file: unnecessary_null_comparison, unused_import

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodsarv01/resources/DBMethods.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding umage to firebase storage
  Future<String> uploadImagetoStorage(Uint8List file) async {
    Reference ref = _storage
        .ref()
        .child('food_items')
        .child(_auth.currentUser!.uid)
        .child('${Uuid().v4()}.jpg');

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapShot = await uploadTask;
    print('uploading image last');
    String url = await snapShot.ref.getDownloadURL();
    print(url);
    return url;
  }
}
