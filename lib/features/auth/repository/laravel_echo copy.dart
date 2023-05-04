import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client/pusher_client.dart';

import '../../../core/constant.dart';

class LaravelEcho2 {
  static LaravelEcho2? _singleton;
  static late Echo _echo;
  final String token;
  // static PusherEvent? pusherEvent;
  LaravelEcho2._({
    required this.token,
  }) {
    _echo = createLaravelEcho(token);
  }

  factory LaravelEcho2.init({
    required String token,
  }) {
    // if (_singleton == null || token != _singleton?.token) {
    //   _singleton = LaravelEcho._(token: token);
    // }
    _singleton = LaravelEcho2._(token: token);

    return _singleton!;
  }

  static Echo get instance => _echo;

  static String get socketId => _echo.socketId() ?? "11111.11111111";

  static PusherEvent pusherEvent({
    String? channelName,
    String? eventName,
    String? data,
    String? userId,
  }) {
    PusherEvent _pusherEvent = PusherEvent();
    return _pusherEvent;
  }
}

class PusherConfig {
  static const appId = "1589363";
  static const key = "86a5ac360934412cdaa8";
  static const secret = "87de7c64a1d5911cd231";
  static const cluster = "ap2";
  // static const hostEndPoint = 'http://10.0.2.2/';
  static const hostEndPoint = 'https://0874-175-110-11-240.ngrok-free.app/';
  static const hostAuthEndPoint = "${hostEndPoint}api/broadcasting/auth";
  static const port = 6001;
}
// http://10.0.2.2/api/broadcasting/auth
// PUSHER_APP_ID=1589363
// PUSHER_APP_KEY=86a5ac360934412cdaa8
// PUSHER_APP_SECRET=87de7c64a1d5911cd231
// PUSHER_APP_CLUSTER=ap2

PusherClient createPusherClient(String token) {
  PusherOptions options = PusherOptions(
    wsPort: PusherConfig.port,
    // wssPort: PusherConfig.port,
    encrypted: true,
    host: PusherConfig.hostEndPoint,
    cluster: PusherConfig.cluster,
    auth: PusherAuth(
      PusherConfig.hostAuthEndPoint,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json",
        'Accept': 'application/json'
      },
    ),
  );

  PusherClient pusherClient = PusherClient(
    PusherConfig.key,
    options,
    autoConnect: false,
    enableLogging: true,
  );

  return pusherClient;
}

Echo createLaravelEcho(String token) {
  return Echo(
    client: createPusherClient(token),
    broadcaster: EchoBroadcasterType.Pusher,
  );
}
