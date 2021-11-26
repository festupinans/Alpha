import 'package:alpha/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class registrarPedido extends StatefulWidget {

  final String id,cedula;

  const registrarPedido({required this.id, required this.cedula}) ;

  @override
  _registrarPedidoState createState() => _registrarPedidoState();
}

class _registrarPedidoState extends State<registrarPedido> {

  List listaCursos=[];
  List codigoGustos=[];

  void initState(){
    super.initState();
    getCursos();
  }

  Future<void> getCursos() async{
    CollectionReference gustos = FirebaseFirestore.instance.collection('Likes');
    String cod="";
    QuerySnapshot cursos = await gustos.where('People', isEqualTo: widget.id).get();
    if(cursos.docs.length>0){
      for(var doc in cursos.docs){
        cod=doc.id.toString();
        print(cod);
        codigoGustos.add(cod);
        listaCursos.add(doc.data());
      }
    }
    setState(() {

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar pedido'),

      ),
      drawer: menu(),
      body:
      // ListView(
      //   children: [
      //     Container(
      //       child: Text('hola'),
      //     )
      //   ],
      // ),
      ListView.builder(
          itemCount: listaCursos.length,
          itemBuilder: (BuildContext context, i){
            return ListTile(
              title: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.pink,
                child: Text(listaCursos[i]['nombre']+' '+listaCursos[i]['descripcion']+' '+listaCursos[i]['precio'].toString()),
              ),
            );
          }
      ),

    );
  }
}
