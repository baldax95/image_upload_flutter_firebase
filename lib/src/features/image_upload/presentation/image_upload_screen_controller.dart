import 'dart:io';

import 'package:image_upload_flutter_firebase/src/features/image_upload/application/image_upload_service.dart';
import 'package:image_upload_flutter_firebase/src/routing/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_upload_screen_controller.g.dart';

@riverpod
class ImageUploadScreenController extends _$ImageUploadScreenController {
  @override
  FutureOr<void> build() {}

  Future<void> uploadImages(List<File> images) async {
    final imageUploadService = ref.read(imageUploadServiceProvider);
    state = const AsyncLoading();
    final value = await AsyncValue.guard(() => imageUploadService.uploadImages(images));
    if (value.hasError == false) {
      ref.read(goRouterProvider).pop();
    }
  }
}
