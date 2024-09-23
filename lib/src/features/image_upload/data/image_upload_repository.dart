// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_upload_repository.g.dart';

class ImageUploadRepository {
  final FirebaseStorage _storage;

  ImageUploadRepository(this._storage);

  Future<String> uploadImageFile(File image) async {
    final imageName = image.path.split('/').last;
    final ref = _storage.ref('images/$imageName');

    try {
      TaskSnapshot taskSnapshot = await ref.putFile(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint("Errore: $e");
      rethrow;
    }
  }
}

@riverpod
ImageUploadRepository imageUploadRepository(ImageUploadRepositoryRef ref) {
  return ImageUploadRepository(FirebaseStorage.instance);
}
