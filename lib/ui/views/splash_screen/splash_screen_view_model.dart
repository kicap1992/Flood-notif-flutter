import 'package:flood_app/services/my_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../app/core/custom_base_view_model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class SplashScreenViewModel extends CustomBaseViewModel {
  final log = getLogger('SplashScreenViewModel');
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    // navigate to login page
    // ignore: use_build_context_synchronously
    MyNotification.initialize(flutterLocalNotificationsPlugin);
    socketIoClient.init();
    // socketIoClient.connect();

    navigationService.replaceWith(Routes.navBarView);
  }
}
