import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class pantalla3 extends StatefulWidget {
  final String criterio;
  const pantalla3(this.criterio,{Key? key}) : super(key: key);

  @override
  _pantalla3State createState() => _pantalla3State();
}

class _pantalla3State extends State<pantalla3> {

  List pers=[];

  void initState(){
    super.initState();
    getCriterio();
  }

  void getCriterio()async{
  CollectionReference datos = FirebaseFirestore.instance.collection('Personas');
  QuerySnapshot personas2= await datos.where('apellido', isEqualTo: widget.criterio).get();
  if(personas2.docs.length!=0){
    for(var per in personas2.docs){
      print(per.data());
      setState(() {
        pers.add(per);
      }
      );
    }
  }
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pantalla3'),

      ),
      body: Center(
        child: ListView.builder(
            itemCount: pers.length,
            itemBuilder: (BuildContext context, i){
              return Container(
              child: Text(pers[i]['nombre']+' '+pers[i]['apellido']),
              );
      },

      ),
    ),
    );
  }
}
