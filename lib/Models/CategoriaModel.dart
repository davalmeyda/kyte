class CategoriaModel {
  int idCategorias;
  String nombreCategoria;
  int idTienda;

  CategoriaModel({this.idCategorias, this.nombreCategoria, this.idTienda});

  CategoriaModel.fromJson(Map<String, dynamic> json) {
    idCategorias = json['idCategorias'];
    nombreCategoria = json['NombreCategoria'];
    idTienda = json['idTienda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCategorias'] = this.idCategorias;
    data['NombreCategoria'] = this.nombreCategoria;
    data['idTienda'] = this.idTienda;
    return data;
  }
}