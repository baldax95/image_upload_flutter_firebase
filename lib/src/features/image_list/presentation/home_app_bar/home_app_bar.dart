import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_upload_flutter_firebase/src/localization/string_hardcoded.dart';
import 'package:image_upload_flutter_firebase/src/routing/app_router.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return AppBar(
      title: Text("My Images".hardcoded),
      actions: [
        IconButton(
          onPressed: () => goRouter.pushNamed(AppRoute.imageUpload.name),
          icon: const Icon(Icons.upload),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
