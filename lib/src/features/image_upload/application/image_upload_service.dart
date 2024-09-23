// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_upload_flutter_firebase/src/features/image_list/data/image_list_repository.dart';
import 'package:image_upload_flutter_firebase/src/features/image_upload/data/image_upload_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_upload_service.g.dart';

class ImageUploadService {
  final Ref ref;

  ImageUploadService(this.ref);

  Future<void> uploadImages(List<File> images) async {
    final imageUploadRepository = ref.read(imageUploadRepositoryProvider);
    final imageListRepository = ref.read(imageListRepositoryProvider);

    for (File image in images) {
      final imageName = image.path.split('/').last;
      try {
        final downloadUrl = await imageUploadRepository.uploadImageFile(image);
        await imageListRepository.uploadImage(imageName, downloadUrl);
      } catch (e) {
        debugPrint("Errore: $e");
      }
    }
  }
}

@riverpod
ImageUploadService imageUploadService(ImageUploadServiceRef ref) {
  return ImageUploadService(ref);
}
