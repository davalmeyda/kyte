import 'dart:convert';

import 'package:kytestore/Models/ProductoImagenModel.dart';
import 'package:kytestore/Models/ProductoModel.dart';
import 'package:kytestore/Models/TiendaModel.dart';
import 'package:kytestore/constants/configuraciones.dart';
import 'package:http/http.dart' as http;

class ProductosProviders {
  String urlAgregarProducto =
      ConstConfiguraciones.urlBackend + "agregarProducto.php";
  String urlTraerProductos =
      ConstConfiguraciones.urlBackend + "traerProductos.php";

  Future agregarProducto(
      {String nombre,
      String precio,
      String idTienda,
      String idCategoria = "1",
      String descripcion = "",
      String codigoBarra = "",
      String unidad = "",
      String exhibir = "1",
      String imagen}) async {
    final response = await http.post(urlAgregarProducto, body: {
      "nombreProducto": nombre,
      "precio": precio,
      "idTienda": idTienda,
      "idCategoria": idCategoria,
      "descripcion": descripcion,
      "codigoBarra": codigoBarra,
      "unidad": unidad,
      "exhibir": exhibir,
      "imagen": imagen,
    });
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Fallo al cargar el archivo');
    }
  }

  Future<List<ProductoImagenModel>> traerProductos() async {
    TiendaModel tienda = TiendaModel();
    final response = await http.post(urlTraerProductos, body: {
      "idTienda": tienda.idTiendas.toString(),
    });

    List<ProductoImagenModel> productosImagenes =
        new List<ProductoImagenModel>();
    if (response.statusCode == 200) {
      if (response.body == "Error") {
        throw Exception("Fallo al traer los productos");
      } else {
        final List<dynamic> valores = json.decode(response.body);
        for (var i = 0; i < valores.length; i++) {
          ProductoImagenModel productoImagen =
              new ProductoImagenModel.fromJson(valores[i]);
          productosImagenes.add(productoImagen);
        }
      }
    }
    return productosImagenes;
  }
}
