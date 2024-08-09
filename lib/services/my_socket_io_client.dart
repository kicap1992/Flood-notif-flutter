import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../app/app.logger.dart';

class MySocketIoClient {
  final log = getLogger('MySocketIoClient');
  final String _url = dotenv.env['url']!;
  double waterHeight = 0;
  int warningLevel = 0;
  int dangerLevel = 0;
  String status = '...';
  static final MySocketIoClient _instance = MySocketIoClient._internal();
  factory MySocketIoClient() => _instance;
  MySocketIoClient._internal();

  int notif = 0;

  late Socket _socket;
  Socket get socket => _socket;

  Future<void> init() async {
    try {
      _socket = io(_url, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      _socket.connect();
      log.i('socket connected');
    } catch (e) {
      log.e('error : $e');
    }
  }

  Future<void> emit(String event, dynamic data) async {
    _socket.emit(event, data);
  }

  Future<void> on(String event, Function(dynamic) callback) async {
    _socket.on(event, callback);
  }

  Future<void> off(String event) async {
    _socket.off(event);
  }

  Future<void> disconnect() async {
    _socket.disconnect();
  }

  Future<void> connect() async {
    _socket.connect();
  }
}
