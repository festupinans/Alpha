import 'package:alpha/recibe_mensaje.dart';
import 'package:flutter/material.dart';

class mensaje extends StatefulWidget {
  const mensaje({Key? key}) : super(key: key);

  @override
  _mensajeState createState() => _mensajeState();
}

class _mensajeState extends State<mensaje> {

  void initState(){
    super.initState();
    final objeto= new recibiendo_mensaje();
    objeto.notificaciones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
    );
  }
}
