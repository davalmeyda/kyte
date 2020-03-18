import 'dart:convert';
import 'package:kytestore/Models/ProductoImagenModel.dart';
import 'package:kytestore/Models/TiendaModel.dart';
import 'package:kytestore/constants/configuraciones.dart';
import 'package:http/http.dart' as http;

class VentasProvider {
  String urlTraerProductosCategorias =
      ConstConfiguraciones.urlBackend + "traerProductosCategoria.php";
  TiendaModel tienda = TiendaModel();

  Future<List<ProductoImagenModel>> traerProductosCategoria(
      String idCategoria) async {
    final response = await http.post(urlTraerProductosCategorias, body: {
      "idTienda": tienda.idTiendas.toString(),
      "idCategoria": idCategoria,
    });

    List<ProductoImagenModel> categorias = new List<ProductoImagenModel>();
    if (response.statusCode == 200) {
      if (response.body == "Error") {
        throw Exception("Fallo al traer los productos");
      } else {
        if (response.body == "") {
          return categorias;
        }
        final List<dynamic> valores = json.decode(response.body);
        for (var i = 0; i < valores.length; i++) {
          ProductoImagenModel productoImagen =
              new ProductoImagenModel.fromJson(valores[i]);
          categorias.add(productoImagen);
        }
      }
    }
    return categorias;
  }
}
