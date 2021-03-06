class ProductoModel {
  int idProductos;
  String nombreProducto;
  double precio;
  double costo;
  int idCategoria;
  String descripcion;
  String codigoBarra;
  String unidad;
  int exhibir;
  int idTienda;

  ProductoModel(
      {this.idProductos,
      this.nombreProducto,
      this.precio,
      this.idCategoria,
      this.descripcion,
      this.codigoBarra,
      this.unidad,
      this.exhibir,
      this.idTienda});

  ProductoModel.fromJson(Map<String, dynamic> json) {
    idProductos = json['idProductos'];
    nombreProducto = json['NombreProducto'];    
    idCategoria = json['idCategoria'];
    descripcion = json['Descripcion'];
    codigoBarra = json['CodigoBarra'];
    unidad = json['Unidad'];
    exhibir = json['Exhibir'];
    idTienda = json['idTienda'];
    precio = double.parse(json['Precio'].toString());
    costo = double.parse(json['Costo'].toString());
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
    data['idTienda'] = this.costo;
    return data;
  }
}
