import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kytestore/Models/ProductoImagenModel.dart';
import 'package:kytestore/Providers/VentasProvider.dart';
import 'package:kytestore/componentes/ventas/componenteProductoCarrito.dart';
import 'package:kytestore/Models/ProductosCanastaModel.dart';
import 'package:kytestore/estados/estados.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class CuerpoCarrito extends StatefulWidget {
  CuerpoCarrito({Key key, this.qr, this.funcion}) : super(key: key);
  final bool qr;
  Function funcion;
  @override
  _CuerpoCarritoState createState() => _CuerpoCarritoState();
}

class _CuerpoCarritoState extends State<CuerpoCarrito> {
  Estados estados = Estados();
  VentasProvider ventasProvider = new VentasProvider();
  String qr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          widget.qr
              ? Container(
                  height: 150,
                  child: QrCamera(
                    onError: (context, error) => Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                    qrCodeCallback: (code) {
                      agregarCarrito(code);
                    },
                    child: new Container(
                      decoration: new BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                )
              : Container(),
          Expanded(
            child: ListView(
              children: listaProductos(),
            ),
          )
        ],
      ),
    );
  }

  // CARGAN PRODUCTOS EN LA CANASTA
  List<Widget> listaProductos() {
    List<Widget> lista = List<Widget>();
    estados.listaProductosCanastaModel.forEach((productosCanastaModel) {
      lista.add(ComponenteProductoCarrito(
        cantidadProducto1: productosCanastaModel.cantidad,
        precioTotal: productosCanastaModel.cantidad *
            productosCanastaModel.producto.precio,
        precioUnidad: productosCanastaModel.producto.precio,
        nombreProducto: productosCanastaModel.producto.nombreProducto,
        funcionDescuento: () => funcionDescuento(productosCanastaModel),
        funcionItems: () => funcionItems(productosCanastaModel),
        funcionPrecio: () => funcionPrecio(productosCanastaModel),
        precioDescuento: productosCanastaModel.precioDescuento,
        descuentofijo: productosCanastaModel.descuentoCantidad,
      ));
    });
    lista.add(
      totalCarrito(),
    );
    return lista;
  }

  Widget totalCarrito() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 80,
          padding: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Dar descuento",
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                ),
              ),
              Container(
                child: Text(
                  ' Total = ' +
                      estados.canastaModel.totalCanasta.toString() +
                      ' PEN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextEditingController showDialogController = new TextEditingController();

  TextEditingController showDialogController1 = new TextEditingController();

  // FUNCION DESCUENTO POR PRODUCTO
  funcionDescuento(ProductosCanastaModel productosCanastaModel) {
    var aceptar = () {
      // TODO: agregar validacion para que el descuento no exceda el valor principal
      if (showDialogController1.text == "") {
        productosCanastaModel.agregarDescuento(
            cantidad1: double.parse(showDialogController.text), fijo: true);
      } else {
        productosCanastaModel.agregarDescuento(
            cantidad1: double.parse(showDialogController1.text), fijo: false);
      }

      productosCanastaModel.quitarPrecioDescuento();
      estados.canastaModel
          .calcular(listaProductosCanasta: estados.listaProductosCanastaModel);
      setState(() {
         widget.funcion();
      });
      Navigator.pop(context);
    };

    var eliminar = () {
      productosCanastaModel.quitarDescuento();
      estados.canastaModel
          .calcular(listaProductosCanasta: estados.listaProductosCanastaModel);
      Navigator.pop(context);
      setState(() {
         widget.funcion();
      });
    };

    _mostrarDialog("Aplicar Descuento", "", aceptar,
        descuento: true,
        valDescuentoFijo: productosCanastaModel.descuentoCantidad,
        valDescuentoPorcentaje: productosCanastaModel.descuentoPorcentaje,
        eliminar: true,
        funcionEliminar: eliminar);
  }

  // FUNCION CAMBIAR CANTIDAD ITEM Y ELIMINAR
  funcionItems(ProductosCanastaModel productosCanastaModel) {
    var eliminar = () {
      estados.listaProductosCanastaModel.removeWhere((item) =>
          item.producto.idProductos ==
          productosCanastaModel.producto.idProductos);
      estados.canastaModel
          .calcular(listaProductosCanasta: estados.listaProductosCanastaModel);
      setState(() {
         widget.funcion();
      });
      Navigator.pop(context);
    };
    var aceptar = () {
      productosCanastaModel.cantidad = int.parse(showDialogController.text);
      estados.canastaModel
          .calcular(listaProductosCanasta: estados.listaProductosCanastaModel);
      setState(() {
         widget.funcion();
      });
      Navigator.pop(context);
    };

    _mostrarDialog(
      "Cantidad:",
      productosCanastaModel.cantidad.toString(),
      aceptar,
      eliminar: true,
      funcionEliminar: eliminar,
    );
  }

  // FUNCION CAMBIAR PRECIO
  funcionPrecio(ProductosCanastaModel productosCanastaModel) {
    var aceptar = () {
      if (double.parse(showDialogController.text) ==
          productosCanastaModel.producto.precio) {
        productosCanastaModel.precioDescuento = null;
      } else {
        productosCanastaModel.precioDescuento =
            double.parse(showDialogController.text);
      }

      productosCanastaModel.quitarDescuento();
      estados.canastaModel
          .calcular(listaProductosCanasta: estados.listaProductosCanastaModel);
      setState(() {
         widget.funcion();
      });
      Navigator.pop(context);
    };
    _mostrarDialog("Editar precio unitario",
        productosCanastaModel.producto.precio.toString(), aceptar);
  }

  void _mostrarDialog(String titulo, String hint, Function funcionAceptar,
      {bool eliminar,
      Function funcionEliminar,
      bool descuento,
      double valDescuentoPorcentaje,
      double valDescuentoFijo}) {
    showDialogController = new TextEditingController();
    showDialogController1 = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(titulo),
          content: Wrap(
            children: <Widget>[
              descuento != null ? Text("Precio fijo") : Container(),
              TextField(
                autofocus: true,
                controller: showDialogController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black38),
                  hintText: hint == "" ? valDescuentoFijo.toString() : hint,
                ),
              ),
              descuento != null ? Text("Procentaje de descuento") : Container(),
              descuento != null
                  ? TextField(
                      autofocus: true,
                      controller: showDialogController1,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.black38),
                        hintText: valDescuentoPorcentaje.toString(),
                      ),
                    )
                  : Text(""),
            ],
          ),
          actions: <Widget>[
            eliminar != null
                ? FlatButton(
                    child: new Text(
                      "Quitar         ",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: funcionEliminar,
                  )
                : Text(""),
            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              onPressed: funcionAceptar,
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  DateTime currentBackPressTime;

  // FUNCION QUE AGREGA AL CARRITO
  void agregarCarrito(String code) async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 3)) {
      currentBackPressTime = now;
      // VALIDA CON EL SERVIDOR EL PRODUCTO
      List<ProductoImagenModel> producto = await ventasProvider.buscarQr(code);
      if (producto.length == 1) {
        ventasProvider.agregarCarrito(producto[0]);
        Fluttertoast.showToast(msg: "Producto agregado");
        setState(() {
          widget.funcion();
        });
      } else {
        Fluttertoast.showToast(msg: "Producto no encontrado");
      }
    }
  }
}
