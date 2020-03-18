import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kytestore/Models/TiendaModel.dart';
import 'package:kytestore/Models/UsuarioModel.dart';
import 'package:kytestore/constants/configuraciones.dart';
export 'package:kytestore/Models/UsuarioModel.dart';
export 'package:kytestore/Models/TiendaModel.dart';

class LoginProvider {
  String urlUsuario = ConstConfiguraciones.urlBackend + "validarUsuarios.php";
  String urlTienda = ConstConfiguraciones.urlBackend + "traerTienda.php";

  Future<List<dynamic>> rolUsuario(String id) async {
    final response = await http.post(urlUsuario, body: {"idUsuario": id});

    if (response.statusCode == 200) {
      UsuarioModel usuario = UsuarioModel.fromJson(json.decode(response.body));
      final responseTienda = await http
          .post(urlTienda, body: {"idTienda": usuario.idTienda.toString()});
      TiendaModel tienda =
          TiendaModel.fromJson(json.decode(responseTienda.body));
      List<dynamic> lista = [usuario, tienda];
      return lista;
    } else {
      throw Exception('Fallo al cargar el archivo');
    }
  }
}
