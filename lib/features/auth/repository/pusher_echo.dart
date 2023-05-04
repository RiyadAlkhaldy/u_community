import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EchoFlutter {
  static const String PUSHER_KEY = 'laravelWebsocketKey';
  static const String PUSHER_CLUSTER = 'mt1';
  String BEARER_TOKEN = 'YOUR_BEARER_TOKEN_HERE';
  static const String AUTH_URL = 'ws://10.0.2.2:8000/api/noty';
  PusherOptions? options;
  PusherClient? pusherClient;
  iniTial() async {
    await SharedPreferences.getInstance().then((value) async {
      BEARER_TOKEN = await value.getString('token')!;
      options = PusherOptions(
        wsPort: 6001,
        encrypted: false,
        host: 'http://localhost:6001',
        cluster: PUSHER_CLUSTER,
        auth: PusherAuth(
          AUTH_URL,
          headers: {
            'Authorization': 'Bearer $BEARER_TOKEN',
          },
        ),
      );
      pusherClient = PusherClient(
        PUSHER_KEY,
        options!,
        autoConnect: false,
        enableLogging: true,
      );
    });
  }

  EchoFlutter();

  Echo? echo;
// Create echo instance
  echoInstance() {
    echo = Echo(
      broadcaster: EchoBroadcasterType.Pusher,
      client: pusherClient,
    );

    return echo;
  }

// Listening public channel

  void printEcho() async {
    await echo!.channel('post-notification').listen('RealtimePosts', (e) {
      print('helllo$e.toString()');
    });
  }

// Accessing pusher instance
  acessingPusherInstance() {
    echo!.connect();
    
    echo!.connector.pusher.onConnectionStateChange((state) {
      print(state!.currentState.toString());
    });
  }
}
// const String PUSHER_KEY = 'YOUR_PUSHER_KEY_HERE';
// const String PUSHER_CLUSTER = 'YOUR_PUSHER_CLUSTER_HERE';
// const String BEARER_TOKEN = 'YOUR_BEARER_TOKEN_HERE';
// const String AUTH_URL = 'http://echo.test/api/broadcasting/auth';

// PusherOptions options = PusherOptions(
//   cluster: PUSHER_CLUSTER,
//   auth: PusherAuth(
//     AUTH_URL,
//     headers: {
//       'Authorization': 'Bearer $BEARER_TOKEN',
//     },
//   ),
// );

// Create pusher client
// PusherClient pusherClient = PusherClient(
//   PUSHER_KEY,
//   options,
//   autoConnect: false,
//   enableLogging: true,
// );

// // Create echo instance
// Echo echo =   Echo(
//   broadcaster: EchoBroadcasterType.Pusher,
//   client: pusherClient,
// );

// // Listening public channel
// echo.Channel('public-channel').listen('PublicEvent', (e) {
//   print(e);
// });

// // Accessing pusher instance
// echo.connector.pusher.onConnectionStateChange((state) {
//   print(state!.currentState.toString());
// });