import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_upload_flutter_firebase/src/common_widgets/async_value_widget.dart';
import 'package:image_upload_flutter_firebase/src/features/image_list/data/image_list_repository.dart';
import 'package:image_upload_flutter_firebase/src/features/image_list/presentation/home_app_bar/home_app_bar.dart';

import '../../../constants/app_sizes.dart';

class ImageListScreen extends ConsumerWidget {
  const ImageListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(imageListStreamProvider);

    return AsyncValueWidget(
      value: value,
      data: (images) => Scaffold(
        appBar: const HomeAppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p4),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: Sizes.p8,
                mainAxisSpacing: Sizes.p8,
              ),
              itemBuilder: (context, index) => Image.network(
                images[index].downloadUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
