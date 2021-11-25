import 'package:alpha/pantalla4.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

class pantalla3 extends StatefulWidget {
  final String criterio;
  const pantalla3(this.criterio,{Key? key}) : super(key: key);

  @override
  _pantalla3State createState() => _pantalla3State();
}

class _pantalla3State extends State<pantalla3> {

  List gustosLista=[];
  List personasLista=[];

  void initState(){
    super.initState();
    getCriterio();
  }

  void getCriterio()async{
    String cri=widget.criterio;
    print(cri);
  CollectionReference info = FirebaseFirestore.instance.collection('Likes');
  QuerySnapshot gustos= await info.where('nombre', isEqualTo: cri).get();
  if(gustos.docs.length!=0){
    for(var per in gustos.docs){
      print(per.data());
      setState(() {
        gustosLista.add(per);
      }
      );
    }
  }else{
    print("no se como resolver este fallo (por ahora), puta vida ");
  }
    String id;
    CollectionReference datos2 = FirebaseFirestore.instance.collection("People");
  for(var i=0;i<gustosLista.length;i++){
    id=gustosLista[i]["persona"];
    QuerySnapshot personas= await datos2.where(FieldPath.documentId, isEqualTo: id).get();
    if(personas.docs.length>0){
      for(var pers in personas.docs){
        setState(() {
          personasLista.add(pers.data());
          print(pers.data());
        });

      }
    }else{print("no hay personas con ese gusto");
    }
  }
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pantalla3'),
      ),
        drawer: menu(),

      body: ListView.builder(
        itemCount: personasLista.length,
        itemBuilder: (BuildContext context, j){
          return ListTile(
            onTap: (){
              print(personasLista[j]);
              datosPersonas p = datosPersonas(personasLista[j]['nombre'], personasLista[j]['apellido'], personasLista[j]['correo'], personasLista[j]['foto'], personasLista[j]['edad'], personasLista[j]['web']);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla4(persona: p)));
            },
              title:  miCardImage(url: personasLista[j]["foto"], texto: personasLista[j]["nombre"]+" "+personasLista[j]["apellido"] +"\n"+ personasLista[j]["correo"])
          );
        },
      )

      /*ListView(
        children:[
          ListView.builder(
          itemCount: gustosLista.length,
          itemBuilder: (BuildContext context, i){
            return Container(
              child: Text(gustosLista[i]['nombre']+' '+gustosLista[i]['descripcion']+' '+gustosLista[i]['persona']),

            );

          },

        ),*/


    );
  }
}



class boton extends StatefulWidget {

  @override
  _botonState createState() => _botonState();
}

class _botonState extends State<boton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: (){

      },child:
      Text('Consultar'),
          style: ElevatedButton.styleFrom(
              primary: Colors.cyan)
      ),
    );
  }
}


class miCardImage extends StatelessWidget {
  final String url;
  final String texto;

  const miCardImage({required this.url, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(35)),
      margin: EdgeInsets.all(20),
      elevation: 10,
      color: Colors.pink,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Column(
          children: [
            Image.network(url),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.cyan,
              child: Text(texto,style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}


class datosPersonas{
  String nombre='';
  String apellido='';
  String correo='';
  String foto='';
  int edad=0;
  String web='';



  datosPersonas(nombre,apellido,correo,foto,edad,web){
    this.nombre=nombre;
    this.apellido=apellido;
    this.correo=correo;
    this.foto=foto;
    this.edad=edad;
    this.web=web;
  }
}
