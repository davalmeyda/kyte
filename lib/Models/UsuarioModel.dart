class UsuarioModel {
  String idUsuarios;
  String nombreCompleto;
  String password;
  String rol;
  int idTienda;

  static final UsuarioModel _inst = UsuarioModel._internal();

  UsuarioModel._internal();

  factory UsuarioModel() {        
    return _inst;
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    _inst.idUsuarios = json['idUsuarios'];
    _inst.nombreCompleto = json['NombreCompleto'];
    _inst.password = json['Password'];
    _inst.rol = json['Rol'];
    _inst.idTienda = json['idTienda'];
    return _inst;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUsuarios'] = this.idUsuarios;
    data['NombreCompleto'] = this.nombreCompleto;
    data['Password'] = this.password;
    data['Rol'] = this.rol;
    data['idTienda'] = this.idTienda;
    return data;
  }
}
