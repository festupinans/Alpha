

import 'package:alpha/actualizaCliente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

class listaPesonas extends StatefulWidget {

  final String cedula;

  const listaPesonas({required this.cedula});

  @override
  _listaPesonasState createState() => _listaPesonasState();
}

class _listaPesonasState extends State<listaPesonas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personas'),
      ),
      drawer: menu(),
      body: Text('cedula: '+ widget.cedula),
    );
  }
}
