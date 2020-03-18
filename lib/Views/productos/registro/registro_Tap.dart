import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kytestore/Models/TiendaModel.dart';
import 'package:kytestore/Providers/ProductosProvider.dart';
import 'package:kytestore/componentes/productos/ComponentProductos.dart';
import 'package:kytestore/constants/configuraciones.dart';
import 'package:kytestore/estados/estados.dart';

class RegistroView extends StatefulWidget {
  RegistroView({Key key}) : super(key: key);

  @override
  _RegistroViewState createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  TextEditingController _nombreProducto = new TextEditingController();
  TextEditingController _precio = new TextEditingController();
  TextEditingController _categoria = new TextEditingController();
  TextEditingController _descripcion = new TextEditingController();
  TextEditingController _codigo = new TextEditingController();
  TextEditingController _costo = new TextEditingController();
  TextEditingController _unidad = new TextEditingController();
  ProductosProviders productosProviders = new ProductosProviders();
  File imageFile;

  Estados estado = Estados();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreProducto.addListener(() {
      setState(() {});
    });

    _precio.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _categoria.text = estado.categoria.nombreCategoria == null
        ? ""
        : estado.categoria.nombreCategoria;

    return Container(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              // IMAGEN Y AGREGAR IMAGEN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    color: Color(ConstConfiguraciones.colorClaro1),
                    height: 200,
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        child: ComponentProductos(
                          "https://hardzone.es/app/uploads-hardzone.es/2019/10/Teclado-mec%C3%A1nico.jpg",
                          _nombreProducto.text,
                          _precio.text,
                          imagen: imageFile,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: FlatButton.icon(
                          onPressed: () => buscarImagen(context),
                          icon: Icon(Icons.photo_library),
                          label: Text("")),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    // NOMBRE DE PRODUCTO
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _nombreProducto,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black38),
                          hintText: "Nombre del Producto",
                        ),
                      ),
                    ),
                    // PRECIO
                    Container(
                      padding: EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _precio,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black38),
                          hintText: "Precio",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                backgroundColor: Colors.white,
                title: Text("Opcionales"),
                children: <Widget>[
                  // CATEGORIA
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    // TODO: eliminar la edicion del texto
                    child: TextField(
                      onTap: nextCategoria,
                      controller: _categoria,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                        hintStyle: TextStyle(color: Colors.black38),
                        hintText: "Categoria",
                      ),
                    ),
                  ),
                  // DESCRIPCION
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: TextField(
                      onTap: nextDescripcion,
                      controller: _descripcion,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                        hintStyle: TextStyle(color: Colors.black38),
                        hintText: "Descripción",
                      ),
                    ),
                  ),
                  // CODIGO
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: TextField(
                      controller: _codigo,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.border_horizontal),
                          onPressed: codigoBarra,
                        ),
                        hintStyle: TextStyle(color: Colors.black38),
                        hintText: "Codigo",
                      ),
                    ),
                  ),
                  // COSTO
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _costo,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.black38),
                        hintText: "Costo",
                      ),
                    ),
                  ),
                  // UNIDAD
                  GestureDetector(
                    onTap: nextUnidad,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: TextField(
                        controller: _unidad,
                        enabled: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_forward_ios),
                          hintStyle: TextStyle(color: Colors.black38),
                          hintText: "Unidad",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // BOTON AGREGAR
              Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 40,
                        child: RaisedButton(
                          highlightElevation: 0.0,
                          elevation: 0.0,
                          color: Color(ConstConfiguraciones.colorKyte),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Text(
                            "Añadir Producto",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          onPressed: guardarProducto,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TODO: implementar codigo de barra
  void codigoBarra() async {
    print("qr");

    try {
      String barcode = await BarcodeScanner.scan();
      _codigo.text = barcode;
    } catch (e) {
      print('The user did not grant the camera permission!');

      print('Unknown error: $e');
    }
  }

  // TODO: implementar ruta Categoria
  void nextCategoria() {
    Navigator.pushNamed(context, 'rutaCategoria');
  }

  // TODO: implementar ruta Descripcion
  void nextDescripcion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Agregar Descripcion"),
          content: TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _descripcion,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.black38),
              hintText: "Ingrese la descripcion",
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                _descripcion.text = "";
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  // TODO: implementar ruta Unidad
  void nextUnidad() {}

  // TODO: implementar buscar imagen
  Future<void> buscarImagen(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Añadir una nueva foto"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Selectionar foto"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Tomar una foto"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 664, maxWidth: 1268);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    try {
      var picture = await ImagePicker.pickImage(
          source: ImageSource.camera, maxHeight: 664, maxWidth: 1268);
      this.setState(() {
        imageFile = picture;
      });
      Navigator.of(context).pop();
    } catch (e) {}
  }

  void guardarProducto() async {
    TiendaModel tienda = TiendaModel();
    String base64Image;
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      base64Image = base64Encode(imageBytes);
    } catch (e) {
      print(e.toString());
    }

    final String resultado = await productosProviders.agregarProducto(
      nombre: _nombreProducto.text,
      precio: _precio.text,
      idTienda: tienda.idTiendas.toString(),
      imagen: base64Image,
      idCategoria: estado.categoria.idCategorias.toString(),
      descripcion: _descripcion.text,
      codigoBarra: _codigo.text,
    );

    if (resultado == "Agregado") {
      Navigator.pop(context);
    }
  }
}
