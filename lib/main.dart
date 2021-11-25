import 'package:alpha/comprobarCliente.dart';
import 'package:alpha/pantalla2.dart';
import 'package:alpha/registroClientes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List datos_personas=[];

  void initState(){
    super.initState();
    getPersonas();
  }

void getPersonas() async {
    CollectionReference datos= FirebaseFirestore.instance.collection('People'); //Conecta a la conexion
  QuerySnapshot personas= await datos.get(); //Traer todas las personas
  if(personas.docs.length>0){
    print('Trae datos');

    for(var doc in personas.docs){
      print(doc.data());
      datos_personas.add(doc.data());

    }
  }else{
    print('ha fallado....');
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('Listado de personas'),
      ),
      drawer: menu(),
      body: Center(

        child: ListView.builder(
            itemCount: datos_personas.length,
            itemBuilder: (BuildContext context, i){
              return ListTile(
                title: Text('Persona '+i.toString()+' - '+datos_personas[i]['nombre'].toString()),
              );
            },
        ),

        ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> pantalla2()));
          }, label: Text("Siguiente"),
          icon: Icon(Icons.arrow_forward),
      ),
      );

  }
}

class menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink),
              child: Image.network('https://github.com/festupinans/equipo2_grupo15/blob/master/lib/Imagenes/TuMI.png?raw=true')
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.search, size: 30, color: Colors.pink),
                title: Text('Consultar Personas'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla2()));
                },
              ),
              ListTile(
                leading: Icon(Icons.update , size: 30, color: Colors.pink),
                title: Text('Actualizar Datos'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
                },
              ),
              ListTile(
                trailing: Icon(Icons.person_add , size: 30, color: Colors.pink),
                enabled: true,
                title: Text('Registrar Personas'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registroClientes()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
