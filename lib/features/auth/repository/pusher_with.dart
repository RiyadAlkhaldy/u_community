import 'package:pusher_client/pusher_client.dart';
//  PusherClient pusher = PusherClient(
//     YOUR_APP_KEY,
//     options,
//     enableLogging: false,
//     autoConnect: false,
// );
//  PusherAuth auth = PusherAuth(
//     // for auth endpoint use full url
//     'http://example.com/auth',
//     headers: {
//         'Authorization': 'Bearer $token',
//     },
// );

// PusherOptions options = PusherOptions(
//     auth: auth
// );

// PusherClient pusher = PusherClient(YOUR_APP_KEY, options);
// PusherClient pusher = PusherClient(YOUR_APP_KEY, PusherOptions());
class MyWebsocketAndPusher {
  String YOUR_APP_KEY = 'laravelWebsocketKey';
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAwMFwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY4MjI4OTkwMiwibmJmIjoxNjgyMjg5OTAyLCJqdGkiOiI3NjRicFN4ZmpEajB2b05UIiwic3ViIjo0NywicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.ctyj7--PPM5pKurVjJpsYgnTm5oJ1EguXa786Kvw0RQ';

  PusherOptions get options => PusherOptions(
        cluster: 'mtl',
        host: 'http://10.0.2.2:6001',
        wsPort: 6001,
        encrypted: false,
        auth: PusherAuth(
          'http://localhost:8000/api/broadcasting/auth',
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

  Future<PusherClient> get pusher async =>
      PusherClient(YOUR_APP_KEY, options, autoConnect: true);
// pusher.then((value) => va)
// connect at a later time than at instantiation.
  void get connect async {
    await pusher.then((value) async {
//       await value.init(
//   apiKey: API_KEY,
//   cluster: API_CLUSTER
// );
      await value.connect();
    });
  }

  void get onConnectionStateChange async {
    pusher.then((value) async => value.onConnectionStateChange((state) {
          print(
              "previousState: ${state!.previousState}, currentState: ${state.currentState}");
        }));
  }

  void get onConnectionError async =>
      pusher.then((value) async => value.onConnectionError((error) {
            print("error: ${error!.message}");
          }));

// Subscribe to a private channel
  Future<Channel> get privateChannel async => await pusher
      .then((value) async => await value.subscribe("post-notification"));
  Future<Channel> get channel async =>
      pusher.then((value) async => await value.subscribe("post-notification"));

// Bind to listen for events called "order-status-updated" sent to "private-orders" channel
  get bind async => channel.then(
      (value) async => await value.bind("RealtimePosts", (PusherEvent? event) {
            print(event!.data);
          }));

// Unsubscribe from channel
  get unsubscribe async => pusher
      .then((value) async => await value.unsubscribe("post-notification"));

// Disconnect from pusher service
  get disconnect async =>
      pusher.then((value) async => await value.disconnect());
////////////////
}
