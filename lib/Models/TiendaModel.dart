class TiendaModel {
  int idTiendas;
  String nombreTienda;

  static final TiendaModel _inst = TiendaModel._internal();

  TiendaModel._internal();

  factory TiendaModel(){    
    return _inst;
  }

  factory  TiendaModel.fromJson(Map<String, dynamic> json) {
    _inst.idTiendas = json['idTiendas'];
    _inst.nombreTienda = json['NombreTienda'];
    return _inst;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTiendas'] = this.idTiendas;
    data['NombreTienda'] = this.nombreTienda;
    return data;
  }
}
