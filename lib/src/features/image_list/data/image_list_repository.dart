import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_upload_flutter_firebase/src/features/image_list/domain/my_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_list_repository.g.dart';

class ImageListRepository {
  final FirebaseFirestore _firestore;

  ImageListRepository(this._firestore);

  Future<void> uploadImage(
    String imageName,
    String downloadUrl,
  ) async {
    final ref = _firestore.collection('images').withConverter(
          fromFirestore: (snapshot, _) => MyImage.fromMap(snapshot.data()!),
          toFirestore: (MyImage myImage, _) => myImage.toMap(),
        );

    final myImage = MyImage(
      imageName: imageName,
      downloadUrl: downloadUrl,
    );

    try {
      await ref.doc(imageName).set(myImage);
    } catch (e) {
      debugPrint("Errore: $e");
    }
  }

  Stream<List<MyImage>> watchImageList() {
    final ref = _firestore
        .collection('images')
        .withConverter(
          fromFirestore: (snapshot, _) => MyImage.fromMap(snapshot.data()!),
          toFirestore: (MyImage myImage, _) => myImage.toMap(),
        )
        .orderBy('imageName');

    try {
      return ref.snapshots().map(
            (querySnapshots) => querySnapshots.docs
                .map(
                  (queryDocumentSnapshot) => queryDocumentSnapshot.data(),
                )
                .toList(),
          );
    } catch (e) {
      debugPrint("Errore: $e");
      rethrow;
    }
  }
}

@riverpod
ImageListRepository imageListRepository(ImageListRepositoryRef ref) {
  return ImageListRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<MyImage>> imageListStream(ImageListStreamRef ref) {
  final imageListRepository = ref.watch(imageListRepositoryProvider);
  return imageListRepository.watchImageList();
}
