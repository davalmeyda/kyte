import 'package:flutter/material.dart';

class ComponenteProductoCarrito extends StatelessWidget {
  const ComponenteProductoCarrito({
    Key key,
    this.precioTotal,
    this.cantidadProducto1,
    this.precioUnidad,
    this.nombreProducto,
    this.funcionItems,
    this.funcionPrecio,
    this.funcionDescuento,
    this.precioDescuento,
    this.descuentofijo,
  }) : super(key: key);
  final double precioTotal, precioUnidad, precioDescuento, descuentofijo;
  final int cantidadProducto1;
  final String nombreProducto;
  final Function funcionDescuento, funcionPrecio, funcionItems;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ExpansionTile(
        // TITULO
        title: Text(nombreProducto),
        // SUBTITULO
        subtitle: Row(
          children: <Widget>[
            cantidadProducto1 == 1 && precioDescuento == null
                ? Text("")
                : precioDescuento == null
                    ? Text(
                        precioUnidad.toString() + " PEN",
                        style: TextStyle(color: Colors.black45),
                      )
                    : Text(
                        precioUnidad.toString() + " PEN",
                        style: TextStyle(
                          color: Colors.black45,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
            precioDescuento == null
                ? Text("")
                : Text(
                    "  " + precioDescuento.toString() + " PEN",
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  )
          ],
        ),
        backgroundColor: Colors.white,
        initiallyExpanded: false,
        // ICONO 1 X
        leading: cantidadProducto(cantidad: cantidadProducto1),
        // PRECIO TOTAL
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              descuentofijo != 0
                  ? Icon(
                      Icons.call_missed_outgoing,
                      color: Colors.red,
                    )
                  : Container(),
              SizedBox(
                width: 10,
              ),
              Text(
                precioDescuento == null
                    ? descuentofijo != 0
                        ? (precioTotal - descuentofijo).toString() + " PEN"
                        : precioTotal.toString() + " PEN"
                    : (precioDescuento * cantidadProducto1).toString() + " PEN",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: funcionItems,
                child: segmentos(
                  color: Colors.black54,
                  icono: Icons.shopping_cart,
                  subTexto: "",
                  texto: cantidadProducto1.toString() + " Items",
                  textColor: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: funcionPrecio,
                child: segmentos(
                  color: Colors.black54,
                  icono: Icons.attach_money,
                  subTexto: "unidad",
                  texto: precioDescuento == null
                      ? precioUnidad.toString() + " PEN"
                      : precioDescuento.toString() + " PEN",
                  textColor: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: funcionDescuento,
                child: segmentos(
                  color: Colors.red,
                  icono: Icons.call_missed_outgoing,
                  subTexto: "",
                  texto: descuentofijo != 0
                      ? descuentofijo.toString() + " PEN"
                      : "DESCUENTO",
                  textColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cantidadProducto({int cantidad}) {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        cantidad.toString() + ' X',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget segmentos(
      {String texto,
      String subTexto,
      IconData icono,
      Color color,
      Color textColor}) {
    return Container(
      height: 100,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icono,
              size: 25,
              color: color,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              texto,
              style: TextStyle(color: textColor),
            ),
            Text(
              subTexto,
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
