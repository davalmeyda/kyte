import 'package:flutter/material.dart';
import 'package:kytestore/Models/CategoriaModel.dart';
import 'package:kytestore/Providers/ProductosProvider.dart';
import 'package:kytestore/estados/estados.dart';

class CuerpoCategoria extends StatefulWidget {
  CuerpoCategoria({Key key}) : super(key: key);

  @override
  _CuerpoCategoriaState createState() => _CuerpoCategoriaState();
}

class _CuerpoCategoriaState extends State<CuerpoCategoria> {
  ProductosProviders productosProviders = new ProductosProviders();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: productosProviders.traerCategorias(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text("No hay Categorias"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].nombreCategoria),
                          onTap: () =>
                              seleccionarCategoria(snapshot.data[index]),
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void seleccionarCategoria(CategoriaModel categoria) {
    Estados estado = Estados();
    estado.categoria = categoria;
    Navigator.pop(context);
  }
}
