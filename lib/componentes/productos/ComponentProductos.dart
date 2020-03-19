import 'package:flutter/material.dart';
import 'package:kytestore/constants/configuraciones.dart';

class ComponentProductos extends StatelessWidget {
  const ComponentProductos(this.img, this.nombre, this.precio,
      {Key key, this.imagen, this.funcionAgregarCarrito})
      : super(key: key);
  final String img, precio, nombre;
  final imagen;
  final Function funcionAgregarCarrito;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcionAgregarCarrito,
          child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: imagen != null
                    ? Image.file(
                        imagen,
                        fit: BoxFit.fill,
                      )
                    : FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: "assets/cargando.gif",
                        image: img),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Color(ConstConfiguraciones.colorOscuro2),
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 9, top: 10, bottom: 5),
                            child: Text(
                              nombre == "" ? "Producto" : nombre,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 9),
                            child: Text(
                              precio == "" ? "00.00" : precio,
                              style: TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
