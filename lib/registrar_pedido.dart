import 'package:alpha/carritoCompra.dart';
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
  List<datosPedido> pedido=[];
  int cont=0;

  void initState(){
    super.initState();
    getCursos();
  }

  Future<void> getCursos() async{
    CollectionReference gustos = FirebaseFirestore.instance.collection('Likes');
    String cod="";
    QuerySnapshot cursos = await gustos.where('persona', isEqualTo: widget.id).get();

    if(cursos.docs.length>0){
      for(var doc in cursos.docs){
        cod=doc.id.toString();
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
        actions: [
          IconButton(
              onPressed: (){
                // for(var i=0; i<pedido.length; i++){
                //   print(pedido[i].precio);
                //   print(pedido[i].cant);
                //   print(pedido[i].total);
                // }
                Navigator.push(context, MaterialPageRoute(builder: (context)=>carritoCompras(pedido: pedido, cedula: widget.cedula, id: widget.id)));


              },
              icon: Icon(Icons.add_shopping_cart, size: 30, color: Colors.amber,)
          ),
        ],
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
            var can= TextEditingController();
            return ListTile(
              leading: Icon(Icons.add_box, size: 30, color: Colors.amber),
              title: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.pink,
                child: Text(listaCursos[i]['nombre']+' '+listaCursos[i]['descripcion']+' '+listaCursos[i]['precio'].toString()),
              ),
              subtitle: TextField(
                controller: can,
                decoration: InputDecoration(
                  hintText: 'Cantidad'
                ),
              ),
              onTap: (){
                if(can.text.isEmpty){
                  can.text='0';
                }
                
                int total= int.parse(can.text)*(int.parse(listaCursos[i]['precio']));

                datosPedido p = datosPedido(codigoGustos[i], listaCursos[i]['nombre'], listaCursos[i]['descripcion'], listaCursos[i]['precio'].toString(), int.parse(can.text), total);

                pedido.add(p);
                
                // print('Cantidad: '+can.text);
                // print('Precio: '+listaCursos[i]['precio'].toString());
                // print(int.parse(can.text)*(int.parse(listaCursos[i]['precio'].toString())));
              },
            );
          }
      ),

    );
  }
}


class datosPedido{
  String codigo='';
  String nombre='';
  String descripcion='';
  String precio='';
  int cant=0;
  int total=0;

  datosPedido(this.codigo, this.nombre, this.descripcion, this.precio, this.cant, this.total);
}