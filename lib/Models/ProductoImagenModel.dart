import 'package:kytestore/constants/configuraciones.dart';

class ProductoImagenModel {
  int idProductos;
  String nombreProducto;
  int precio;
  int idCategoria;
  String descripcion;
  String codigoBarra;
  String unidad;
  int exhibir;
  int idTienda;
  int idImagen;
  String ruta;
  int idProducto;

  ProductoImagenModel(
      {this.idProductos,
      this.nombreProducto,
      this.precio,
      this.idCategoria,
      this.descripcion,
      this.codigoBarra,
      this.unidad,
      this.exhibir,
      this.idTienda,
      this.idImagen,
      this.ruta,
      this.idProducto});

  ProductoImagenModel.fromJson(Map<String, dynamic> json) {
    ruta = ConstConfiguraciones.urlBackend +
                ConstConfiguraciones.urlImagen +
                (json['Ruta'] ==
            null
        ? "ERROR.jpg"
        : json['Ruta']);

    idProductos = json['idProductos'];
    nombreProducto = json['NombreProducto'];
    precio = json['Precio'];
    idCategoria = json['idCategoria'];
    descripcion = json['Descripcion'];
    codigoBarra = json['CodigoBarra'];
    unidad = json['Unidad'];
    exhibir = json['Exhibir'];
    idTienda = json['idTienda'];
    idImagen = json['idImagen'];
    idProducto = json['idProducto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProductos'] = this.idProductos;
    data['NombreProducto'] = this.nombreProducto;
    data['Precio'] = this.precio;
    data['idCategoria'] = this.idCategoria;
    data['Descripcion'] = this.descripcion;
    data['CodigoBarra'] = this.codigoBarra;
    data['Unidad'] = this.unidad;
    data['Exhibir'] = this.exhibir;
    data['idTienda'] = this.idTienda;
    data['idImagen'] = this.idImagen;
    data['Ruta'] = this.ruta;
    data['idProducto'] = this.idProducto;
    return data;
  }
}
