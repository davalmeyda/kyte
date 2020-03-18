import 'package:flutter/material.dart';
import 'package:kytestore/Models/CategoriaModel.dart';
import 'package:kytestore/Providers/ProductosProvider.dart';
import 'package:kytestore/Providers/VentasProvider.dart';
import 'package:kytestore/componentes/productos/ComponentProductos.dart';
import 'package:kytestore/constants/configuraciones.dart';
import 'package:kytestore/componentes/ventas/multiplicadorIcon_widget.dart';

class TabWidget extends StatelessWidget {
  TabWidget(this.categoria, {Key key}) : super(key: key);

  final CategoriaModel categoria;

  void accionAgregar(context) {
    Navigator.pushNamed(context, "nuevoProducto");
  }

  final productosProviders = new ProductosProviders();
  final ventasProvider = new VentasProvider();
  @override
  Widget build(BuildContext context) {
    Widget _bloqueProductoVacioWidget({bool agregar = false}) {
      return GestureDetector(
        onTap: agregar ? () => accionAgregar(context) : () {},
        child: Container(
          height: 80,
          color: Color(ConstConfiguraciones.colorClaro1),
          child: Center(
            child: agregar
                ? Text(
                    '+',
                    style: TextStyle(
                        fontSize: 60,
                        color: Theme.of(context).textTheme.title.color),
                  )
                : null,
          ),
        ),
      );
    }

    Widget grid() {
      return GridView.count(
        primary: false,
        padding: const EdgeInsets.only(top: 0, right: 10, left: 10),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 3,
        childAspectRatio: 1.08,
        children: <Widget>[
          _bloqueProductoVacioWidget(agregar: true),
          _bloqueProductoVacioWidget(),
          _bloqueProductoVacioWidget(),
          _bloqueProductoVacioWidget(),
          _bloqueProductoVacioWidget(),
          _bloqueProductoVacioWidget(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Image.network(
                  'https://img.icons8.com/pastel-glyph/64/000000/barcode-scanner--v2.png'),
              onPressed: () {}),
          IconButton(icon: Icon(Icons.flash_on), onPressed: () {}),
          IconButton(icon: Icon(Icons.list), onPressed: () {}),
          MultiplicadorIconWidget(),
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: FutureBuilder(
          future: categoria == null
              ? productosProviders
                  .traerProductos(_bloqueProductoVacioWidget(agregar: true))
              : ventasProvider
                  .traerProductosCategoria(categoria.idCategorias.toString( ),_bloqueProductoVacioWidget(agregar: true)),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data.length == 0) {
                return grid();
              }

              return Container(
                padding: const EdgeInsets.only(top: 0, right: 10, left: 10),
                child: GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 3,
                    childAspectRatio: 1.08,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index + 1 == snapshot.data.length) {
                      return snapshot.data[index];
                    }
                    return ComponentProductos(
                      snapshot.data[index].ruta,
                      snapshot.data[index].nombreProducto,
                      snapshot.data[index].precio.toString(),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
