import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:image_upload_flutter_firebase/src/constants/app_sizes.dart';
import 'package:image_upload_flutter_firebase/src/features/image_upload/presentation/image_upload_screen_controller.dart';
import 'package:image_upload_flutter_firebase/src/localization/string_hardcoded.dart';

class ImageUploadScreen extends ConsumerStatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  ConsumerState<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends ConsumerState<ImageUploadScreen> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      setState(() {
        for (var image in images) {
          _images.add(File(image.path));
        }
      });
    } catch (e) {
      debugPrint("Error picking image: $e".hardcoded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(imageUploadScreenControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload images".hardcoded),
        actions: _images.isNotEmpty
            ? [
                IconButton(
                  onPressed: isLoading ? null : () => setState(_images.clear),
                  icon: const Icon(Icons.clear),
                ),
              ]
            : null,
      ),
      floatingActionButton: _images.isEmpty
          ? FloatingActionButton(
              onPressed: _pickImage,
              child: const Icon(Icons.add),
            )
          : FloatingActionButton(
              onPressed: isLoading
                  ? null
                  : () => ref
                      .read(imageUploadScreenControllerProvider.notifier)
                      .uploadImages(_images),
              child: const Icon(Icons.upload),
            ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : _images.isEmpty
                ? Text("No images selected".hardcoded)
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.p4),
                    child: GridView.builder(
                      itemCount: _images.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: Sizes.p8,
                        mainAxisSpacing: Sizes.p8,
                      ),
                      itemBuilder: (context, index) => Image.file(
                        _images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
      ),
    );
  }
}
