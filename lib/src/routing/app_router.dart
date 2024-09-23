import "package:go_router/go_router.dart";
import 'package:image_upload_flutter_firebase/src/features/image_list/presentation/image_list_screen.dart';
import 'package:image_upload_flutter_firebase/src/features/image_upload/presentation/image_upload_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  imageList,
  imageUpload,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: AppRoute.imageList.name,
        builder: (context, state) => const ImageListScreen(),
      ),
      GoRoute(
        path: "/upload",
        name: AppRoute.imageUpload.name,
        builder: (context, state) => const ImageUploadScreen(),
      ),
    ],
  );
}
