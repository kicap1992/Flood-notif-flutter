import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';

import '../services/http_services.dart';
import '../services/my_easyloading.dart';
import '../services/my_notification.dart';
import '../services/my_socket_io_client.dart';
import '../services/other_function.dart';

import '../ui/views/nav_bar/log_data/log_data_view.dart';
import '../ui/views/nav_bar/monitoring/monitoring_view.dart';
import '../ui/views/nav_bar/nav_bar_view.dart';
import '../ui/views/splash_screen/splash_screen_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreenView, initial: true),
    MaterialRoute(
      page: NavBarView,
      children: [
        MaterialRoute(page: MonitoringView),
        MaterialRoute(page: LogDataView),
      ],
    ),
  ],
  // dialogs: [
  //   StackedDialog(classType: ScanRfidDialogView),

  // ],
  // bottomsheets: [
  //   StackedBottomsheet(classType: DetailLogHistoryView),
  // ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    //

    LazySingleton(classType: MyEasyLoading),
    LazySingleton(classType: MyHttpServices),
    LazySingleton(classType: OtherFunction),
    LazySingleton(classType: MySocketIoClient),
    LazySingleton(classType: MyNotification),
  ],
  logger: StackedLogger(),
)
class App {}
