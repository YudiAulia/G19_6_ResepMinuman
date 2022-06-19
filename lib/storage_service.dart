import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  Future<void> uploadFile(
    final filePath,
    String fileName,
  ) async {
    String imageUrl = "";
    File file = File(filePath);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("$fileName");
    UploadTask uploadTask = ref.putFile(file);
    uploadTask.whenComplete(() async {
      try{
        imageUrl = await ref.getDownloadURL();

      }catch(onError){
        print("Error");
      }
      // print(imageUrl);

    });
  }
}
  // Future<void> uploadFile(
  //   final filePath,
  //   String fileName,
  // ) async {
  //   File file = File(filePath);

  //   try {
  //     await storage.ref('test/$fileName').putFile(file);
  //   } on firebase_core.FirebaseException catch (e) {
  //     print(e);
  //   }
  // }

