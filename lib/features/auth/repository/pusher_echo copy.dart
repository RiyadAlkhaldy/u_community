//  import 'package:laravel_echo/laravel_echo.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// const String BEARER_TOKEN = 'YOUR_BEARER_TOKEN_HERE';

// // Create socket.io client
// IO.Socket socket = IO.io(
//   'http://localhost:6001',
//   IO.OptionBuilder()
//       .disableAutoConnect()
//       .setTransports(['websocket']).build(),
// );

// // Create echo instance
// Echo echo = new Echo(
//   broadcaster: EchoBroadcasterType.SocketIO,
//   client: socket,
//   options: {
//     'auth': {
//       'headers': {
//         'Authorization': 'Bearer $BEARER_TOKEN',
//       }
//     },
//   },
// );

// // Listening public channel
// echo.channel('public-channel').listen('PublicEvent', (e) {
//   print(e);
// });

// // Listening private channel
// // Needs auth. See details how to authorize channel below in guides
// echo.private('private-channel').listen('PrivateEvent', (e) {
//   print(e);
// });

// // Listening presence channel
// // Needs auth. See details how to authorize channel below in guides
// echo.join('presence-channel')
//   .here((users) {
//     print(users);
//   }).joining((user) {
//     print(user);
//   }).leaving((user) {
//     print(user);
//   }).listen('PresenceEvent', (e) {
//     print(e);
//   });

// // Accessing socket instance
// echo.connector.socket.onConnect((_) => print('connected'));
// echo.connector.socket.onDisconnect((_) => print('disconnected'));