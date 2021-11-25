import 'package:alpha/comprobarCliente.dart';
import 'package:flutter/material.dart';

class actualizarCliente extends StatefulWidget {
  final datosClientes cliente;

  const actualizarCliente({required this.cliente});

  @override
  _actualizarClienteState createState() => _actualizarClienteState();
}

class _actualizarClienteState extends State<actualizarCliente> {

  final nombre=TextEditingController();
  final apellido=TextEditingController();
  final correo=TextEditingController();
  final celular=TextEditingController();



  @override
  Widget build(BuildContext context) {
    String cedula=widget.cliente.cedula;
    nombre.text=widget.cliente.nombre;
    apellido.text=widget.cliente.apellido;
    correo.text=widget.cliente.correo;
    celular.text=widget.cliente.celular;


    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Datos: ' + widget.cliente.nombre),
      ),
      body: ListView(
        children: [

          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: nombre,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.pink,
                  filled: true,
                  icon: Icon(Icons.assignment_rounded,size: 25),
                  hintText: "Ingrese nombre",
                  hintStyle: TextStyle(color: Colors.white)
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: apellido,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.pink,
                  filled: true,
                  icon: Icon(Icons.assignment_rounded,size: 25),
                  hintText: "Ingrese apellido",
                  hintStyle: TextStyle(color: Colors.white)
              ),
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
                  icon: Icon(Icons.assignment_rounded,size: 25),
                  hintText: "Ingrese correo",
                  hintStyle: TextStyle(color: Colors.white)
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: celular,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.pink,
                  filled: true,
                  icon: Icon(Icons.assignment_rounded,size: 25),
                  hintText: "Ingrese celular",
                  hintStyle: TextStyle(color: Colors.white)
              ),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed:(){

                  },
                  child: Text('Actualizar')),
              ElevatedButton(
                  onPressed:(){

                  },
                  child: Text('Eliminar'))
            ],
          ),

        ],
      ),
    );
  }
}
