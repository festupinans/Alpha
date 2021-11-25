import 'package:alpha/actualizaCliente.dart';
import 'package:alpha/listaPersonas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

class moduloCliente extends StatefulWidget {
  const moduloCliente({Key? key}) : super(key: key);

  @override
  _moduloClienteState createState() => _moduloClienteState();
}

class _moduloClienteState extends State<moduloCliente> {
  final cedula = TextEditingController();
  final correo = TextEditingController();

  CollectionReference cliente =
  FirebaseFirestore.instance.collection('Clientes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprobar Cliente'),
      ),
      drawer: menu(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: cedula,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.pink,
                  filled: true,
                  icon: Icon(Icons.assignment_rounded, size: 25),
                  hintText: "Ingrese cedula",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: correo,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.pink,
                  filled: true,
                  icon: Icon(Icons.assignment_rounded, size: 25),
                  hintText: "Ingrese correo",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                QuerySnapshot ingreso = await cliente
                    .where(FieldPath.documentId, isEqualTo: cedula.text)
                    .where('correo', isEqualTo: correo.text)
                    .get();

                List listaCliente=[];
                for(var cli in ingreso.docs){
                  listaCliente.add(cli.data());
                }



                if(ingreso.docs.length>0){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>listaPesonas(cedula: cedula.text)));
                  Fluttertoast.showToast(msg: "Cargando datos", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.black45, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);


                }
                Fluttertoast.showToast(msg: "Datos incorrectos", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.black45, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
              },
              child: Text("Verificar",
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ),
        ],
      ),
    );
  }
}

