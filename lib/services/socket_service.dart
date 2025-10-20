
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../helpers/prefs_helper.dart';
import '../utils/utils.dart';
import 'api_constants.dart';

class SocketServices {
  static late IO.Socket socket;
  static String token = '';

  static final SocketServices _socketApi = SocketServices._internal();

  factory SocketServices() {
    return _socketApi;
  }

  SocketServices._internal();

  static Future<void> init() async {
    token = await PrefsHelper.getString(AppConstants.bearerToken);
    socket = IO.io(ApiConstants.socketBaseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .build());

    try {
      socket.connect();

      socket.onConnect((_) {
        print('✅ Socket Connected: ${socket.connected}');
      });

      socket.onConnectError((err) {
        print('❌ Socket Connect Error: $err');
      });

      socket.onDisconnect((_) {
        print('⚠️ Socket Disconnected');
      });
    } catch (e, s) {
      print("⚠️ Socket Error: $e");
      print("🔍 Stack Trace: $s");
    }
  }

  static Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();
    if (socket.connected) {
      socket.emitWithAck(event, body, ack: (data) {
        if (data != null) {
          completer.complete(data);
        } else {
          completer.complete(1);
        }
      });
    } else {
      print("⚠️ Cannot emit, socket not connected");
      completer.completeError("Socket Not Connected");
    }
    return completer.future;
  }

  static void emit(String event, dynamic body) {
    if (socket.connected) {
      socket.emit(event, body);
      print('📤 Emit event: $event \n Body: $body');
    } else {
      print("⚠️ Cannot emit, socket not connected");
    }
  }


}


// class SocketServices {
//   late IO.Socket socket;
//
//   // Function to connect to the socket server and pass the token in the header
//   void connectSocket(String token) {
//     // Specify the connection options
//     socket = IO.io(
//       'https://milon8086.sobhoy.com/',  // Replace with your server URL
//       IO.OptionBuilder()
//           .setTransports(['websocket']) // Specify the transport protocol
//           .enableForceNew() // Force a new connection
//           .setExtraHeaders({'Authorization': 'Bearer $token'}) // Add token to headers
//           .build(),
//     );
//
//     // Listen for the connection event
//     socket.onConnect((_) {
//       print('Connected to the server');
//     });
//
//     // Listen for the "notifications" event
//     socket.on('notifications', (data) {
//       print('Received notification: $data');
//       // Handle the notification data here
//     });
//
//     // Handle any connection errors
//     socket.onError((error) {
//       print('Socket error: $error');
//     });
//
//     // Listen for disconnection
//     socket.onDisconnect((_) {
//       print('Disconnected from the server');
//     });
//   }
//
//   // Function to disconnect the socket
//   void disconnectSocket() {
//     socket.disconnect();
//     print('Socket disconnected');
//   }
// }