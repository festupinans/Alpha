

import 'package:alpha/actualizaCliente.dart';
import 'package:alpha/pantalla3.dart';
import 'package:alpha/registrarPedido.dart';
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

  List personas=[];
  List codigos=[];

  void initState(){
    super.initState();
    getPersonas();
  }

  Future<void> getPersonas() async {
    CollectionReference persona = FirebaseFirestore.instance.collection('People');
    String id="";
    QuerySnapshot datos = await persona.get();
    if(datos.docs.length>0){
      for(var doc in datos.docs){
        id=doc.id.toString();
        print(id);
        codigos.add(id);
        personas.add(doc.data());
      }
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profesores'),
      ),
      drawer: menu(),
      body: ListView.builder(
          itemCount: personas.length,
          itemBuilder: (BuildContext context, j){
            return ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>registrarPedido(id: codigos[j], cedula: widget.cedula)));
            },
            title: miCardImage(url: personas[j]['foto'], texto: personas[j]['nombre']+' '+personas[j]['apellido']+'\n'+personas[j]['correo']),
            );
    },
      ),
    );
  }
}
