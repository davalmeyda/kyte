import 'package:flutter/material.dart';
import 'package:kytestore/componentes/productos/ComponentProductos.dart';
import 'package:kytestore/constants/configuraciones.dart';

class TabWidget extends StatelessWidget {
  void accionAgregar(context) {
    Navigator.pushNamed(context, "nuevoProducto");
  }

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
          _multiplicadorIconWidget(),
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.only(top: 0, right: 10, left: 10),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 3,
          childAspectRatio: 1.08,
          children: <Widget>[
            _bloqueProductoVacioWidget(agregar: true),
            _bloqueProductoVacioWidget(),
            ComponentProductos(
                "https://hardzone.es/app/uploads-hardzone.es/2019/10/Teclado-mec%C3%A1nico.jpg","Monitor","22.2"),
            _bloqueProductoVacioWidget(),
            _bloqueProductoVacioWidget(),
            _bloqueProductoVacioWidget(),
            _bloqueProductoVacioWidget(),
            _bloqueProductoVacioWidget(),
            _bloqueProductoVacioWidget(),
            _bloqueProductoVacioWidget(),
            _bloqueProductoVacioWidget(),
          ],
        ),
      ),
    );
  }

  Widget _multiplicadorIconWidget() {
    return GestureDetector(
      onTap: () {
        //TODO: Implementar boton cambiar multiplicador para agregar productos
        print('tab');
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(right: 11, left: 10),
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(
            '1 X',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
