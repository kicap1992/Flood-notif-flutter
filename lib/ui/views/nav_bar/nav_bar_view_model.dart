import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../services/my_notification.dart';
import '../../../services/my_socket_io_client.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NavBarViewModel extends IndexTrackingViewModel {
  final log = getLogger('NavBarViewModel');
  final _navigationService = locator<NavigationService>();
  final _socketIoClient = locator<MySocketIoClient>();
  final _myNotification = locator<MyNotification>();

  final _bottomNavBarList = [
    {
      'name': 'Real Time',
      'icon': Icons.home_outlined,
    },
    {
      'name': 'Log Data',
      'icon': Icons.list_alt_outlined,
    },
  ];

  List<Map<String, dynamic>> get bottomNavBarList => _bottomNavBarList;

  final List<String> _views = [
    NavBarViewRoutes.monitoringView,
    NavBarViewRoutes.logDataView,
  ];

  Future<void> init() async {
    _socketIoClient.on('data', (data) {
      // log.i('data : $data');
      var waterHeight = data['water_height'];
      _socketIoClient.waterHeight = waterHeight is int
          ? waterHeight.toDouble()
          : waterHeight is double
              ? waterHeight
              : double.parse(waterHeight as String);

      _socketIoClient.warningLevel = data['warning_level'];
      _socketIoClient.dangerLevel = data['danger_level'];

      if (_socketIoClient.dangerLevel == 1) {
        _socketIoClient.status =
            "Bahaya , Peringatan Banjir, Air Melewati Batas";
        if (_socketIoClient.notif < 2) {
          _myNotification.showNotification(
            id: 1,
            title: 'Peringatan Banjir',
            body: 'Air Melewati Batas',
            payload: 'payload',
            flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
          );
          _socketIoClient.notif = 2;
        }
      } else if (_socketIoClient.warningLevel == 1) {
        _socketIoClient.status =
            "Peringatan Banjir, Air Dalam Skala 4:5 atau lebih";
        if (_socketIoClient.notif == 0) {
          _myNotification.showNotification(
            id: 2,
            title: 'Peringatan Banjir',
            body: 'Air Dalam Skala 4:5 atau lebih',
            payload: 'payload',
            flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
          );
          _socketIoClient.notif = 1;
        }
      } else {
        _socketIoClient.status = "Normal";
        _socketIoClient.notif = 0;
      }

      notifyListeners();
    });
  }

  void handleNavigation(int index) {
    log.d("handleNavigation: $index");
    log.d("currentIndex: $currentIndex");

    if (currentIndex == index) return;

    setIndex(index);
    // header = _bottomNavBarList[index]['header'] as String;
    _navigationService.navigateTo(
      _views[index],
      id: 3,
    );
  }
}
