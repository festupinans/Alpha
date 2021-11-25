import 'package:alpha/comprobarCliente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


class registroClientes extends StatefulWidget {
  const registroClientes({Key? key}) : super(key: key);

  @override
  _registroClientesState createState() => _registroClientesState();
}

class _registroClientesState extends State<registroClientes> {

  final cedula=TextEditingController();
  final nombre=TextEditingController();
  final apellido=TextEditingController();
  final correo=TextEditingController();
  final celular=TextEditingController();

  void limpiar(){
    cedula.text="";
    nombre.text="";
    apellido.text="";
    correo.text="";
    celular.text="";
  }

  CollectionReference clientes = FirebaseFirestore.instance.collection('Clientes');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de clientes"),
      ),
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
                icon: Icon(Icons.assignment_rounded,size: 25),
                hintText: "Ingrese cedula",
                hintStyle: TextStyle(color: Colors.white)
              ),
            ),
      ),


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
                  icon: Icon(Icons.person,size: 25),
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
              Container(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if(cedula.text.isEmpty || nombre.text.isEmpty || apellido.text.isEmpty || correo.text.isEmpty || celular.text.isEmpty){
                      print('campos vacios');
                      Fluttertoast.showToast(msg: 'campos vacios', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP);
                    }else{
                      QuerySnapshot existe = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                      if(existe.docs.length>0){
                        Fluttertoast.showToast(msg: 'El cliente ya existe', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP);
                        limpiar();
                      }else{
                        clientes.doc(cedula.text).set({
                          'nombres': nombre.text,
                          'apellidos': apellido.text,
                          'correo': correo.text,
                          'celular': celular.text
                        });
                          QuerySnapshot inserto = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                          limpiar();
                          if(inserto.docs.length>0){
                            Fluttertoast.showToast(msg: 'Cliente registrado existosamente', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP);
                      }else{
                            Fluttertoast.showToast(msg: 'No se registro el cliente', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP);
                          }
                      }

                    }
                  },
                  child: Text("Registrar", style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if(cedula.text.isEmpty){
                      Fluttertoast.showToast(msg: "Digite la cedula", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.black45, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else{
                      List lista=[];
                      var id;
                      var ced=cedula.text;
                      QuerySnapshot consulta = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                      if(consulta.docs.length>0){
                        for(var doc in consulta.docs){
                          //id=FieldPath.documentId;
                          lista.add(doc.data());
                        }
                        cedula.text=ced;
                        nombre.text=lista[0]["nombres"];
                        apellido.text=lista[0]["apellidos"];
                        correo.text=lista[0]["correo"];
                        celular.text=lista[0]["celular"];
                      }else{
                        limpiar();
                        Fluttertoast.showToast(msg: "El cliente no se encontro", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.black45, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                      }
                    }
                },
                child: Text("Consultar", style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    if(cedula.text.isEmpty || nombre.text.isEmpty || apellido.text.isEmpty || correo.text.isEmpty || celular.text.isEmpty){
                      print('campos vacios');
                      Fluttertoast.showToast(msg: "Campos vacios", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.black45, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else{
                      clientes.doc(cedula.text).update({
                        'nombres': nombre.text,
                        'apellidos': apellido.text,
                        'correo': correo.text,
                        'celular': celular.text
                      });
                      limpiar();
                      Fluttertoast.showToast(msg: "Datos actualizados corecctamente", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.black45, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }

                  },
                  child: Text("Actualizar", style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    if(cedula.text.isEmpty){
                      Fluttertoast.showToast(msg: "Campo vacio, ingrese una cedula", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.black45, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else{
                      clientes.doc(cedula.text).delete();
                      limpiar();
                      Fluttertoast.showToast(msg: "Cliente eliminado :(", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.black45, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
;                    }

                  },
                  child: Text("Eliminar", style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
        },
        child: Icon(Icons.arrow_forward_sharp , size: 30, color: Colors.pink),
      ),
    );
  }
}

