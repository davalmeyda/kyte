import 'package:flutter/material.dart';
import 'package:kytestore/Views/vender/carrito/cuerpoCarrito.dart';
import 'package:kytestore/componentes/botones/botonPrincipal.dart';
import 'package:kytestore/constants/configuraciones.dart';
import 'package:kytestore/estados/estados.dart';

class CarritoView extends StatefulWidget {
  CarritoView({Key key}) : super(key: key);

  @override
  _CarritoViewState createState() => _CarritoViewState();
}

class _CarritoViewState extends State<CarritoView> {
  Estados estados = Estados();

  @override
  Widget build(BuildContext context) {
    final Map arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Carrito"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.person_add,
                color: Color(ConstConfiguraciones.colorKyte),
              ),
              onPressed: agregarCliente),
        ],
      ),
      body: CuerpoCarrito(qr: arg['qr'], funcion: actualizarEstado),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BotonPrincipal(
        next: comprarCarrito,
        texto: estados.canastaModel.items.toString() +
            ' items = ' +
            estados.canastaModel.totalCanasta.toString() +
            ' PEN',
        menu: true,
        menuIcono: () => menuIcono(context),
      ),
    );
  }

  //TODO: implementar agregar cliente
  void agregarCliente() {}

  // TODO: OPcion de comprar
  void comprarCarrito() {}

  // TODO: opciones de menu para icono
  void menuIcono(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Mas opciones",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text("Añadir observación"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                ),
                onTap: nextObservacion,
              ),
              ListTile(
                title: Text("Añadir Descuento"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                ),
                onTap: nextDescuento,
              ),
              ListTile(
                title: Text("Vaciar Carrito"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                ),
                onTap: nextCarrito,
              ),
            ],
          ),
        );
      },
    );
  }

  // TODO: agregar boton orbservaciones
  void nextObservacion() {}
  // TODO: agregar boton descuento
  void nextDescuento() {}
  // TODO: agregar boton carrito
  void nextCarrito() {}

  void actualizarEstado() {
    setState(() {});
  }
}
