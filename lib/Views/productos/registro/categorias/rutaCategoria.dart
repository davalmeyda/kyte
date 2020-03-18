import 'package:flutter/material.dart';
import 'package:kytestore/Models/TiendaModel.dart';
import 'package:kytestore/Providers/ProductosProvider.dart';
import 'package:kytestore/Views/productos/registro/categorias/cuerpoCategoria.dart';

class RutaCategorias extends StatefulWidget {
  const RutaCategorias({Key key}) : super(key: key);

  @override
  _RutaCategoriasState createState() => _RutaCategoriasState();
}

class _RutaCategoriasState extends State<RutaCategorias> {
  ProductosProviders productosProviders = new ProductosProviders();
  TextEditingController _categoria = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: agregarCategoria,
          )
        ],
      ),
      body: CuerpoCategoria(),
    );
  }

  void _mostrarAgregarCategoria() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Agregar Categoria"),
          content: TextField(
            autofocus: true,
            controller: _categoria,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(              
              hintStyle: TextStyle(color: Colors.black38),
              hintText: "Ingrese su categoria",
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              onPressed: () async {
                TiendaModel tienda = TiendaModel();
                await productosProviders.agregarCategoria(
                    idTienda: tienda.idTiendas.toString(),
                    nombreCategoria: _categoria.text);
                Navigator.pop(context);
                setState(() {});
              },
              child: Text("Agregar"),
            ),
          ],
        );
      },
    );
  }

  void agregarCategoria() {
    _mostrarAgregarCategoria();
  }
}
