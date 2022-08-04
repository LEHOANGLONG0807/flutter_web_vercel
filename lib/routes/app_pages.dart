import 'package:get/get.dart';
import '../screens/screens.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      bindings: [
        BindingsBuilder.put(() => SplashController()),
      ],
    ),
    GetPage(
      name: Routes.webManager,
      page: () => WebManagerScreen(),
      bindings: [
        BindingsBuilder.put(() => WebManagerController()),
      ],
    ),
    GetPage(
      name: Routes.form,
      page: () => FormScreen(),
      bindings: [
        BindingsBuilder.put(() => FormController()),
      ],
    ),
    GetPage(
      name: Routes.scanQR,
      page: () => const ScanQRScreen(),
      bindings: [
        BindingsBuilder.put(() => ScanQRController()),
      ],
    ),
    GetPage(
      name: Routes.main,
      page: () => MainScreen(),
      bindings: [
        BindingsBuilder.put(() => MainController()),
      ],
    ),
    GetPage(
      name: Routes.listForm,
      page: () => ListScreen(),
      bindings: [
        BindingsBuilder.put(() => ListController()),
      ],
    ),
    GetPage(
      name: Routes.previewCheckIn,
      page: () => PreviewCheckInScreen(),
      bindings: [
        BindingsBuilder.put(() => PreviewCheckInController()),
      ],
    ),
  ];
}
