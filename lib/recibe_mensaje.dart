import 'package:firebase_messaging/firebase_messaging.dart';

class recibiendo_mensaje {
  FirebaseMessaging mensaje = FirebaseMessaging.instance;

  notificaciones() {
    mensaje.requestPermission();
    mensaje.getToken().then((token) {
      print('-----TOKEN-----');
      print(token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //aplicacion abierta
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //aplicacion segundo plano
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      //aplicacion cerrada
    });
  }
}
