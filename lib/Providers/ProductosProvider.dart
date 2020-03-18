import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:kytestore/Models/ProductoImagenModel.dart';
import 'package:kytestore/Models/TiendaModel.dart';
import 'package:kytestore/constants/configuraciones.dart';
import 'package:kytestore/Models/CategoriaModel.dart';
import 'package:http/http.dart' as http;

class ProductosProviders {
  String urlAgregarProducto =
      ConstConfiguraciones.urlBackend + "agregarProducto.php";
  String urlTraerProductos =
      ConstConfiguraciones.urlBackend + "traerProductos.php";
  String urlTraerCategorias =
      ConstConfiguraciones.urlBackend + "traerCategorias.php";
  String urlAgregarCategoria =
      ConstConfiguraciones.urlBackend + "agregarCategoria.php";
  TiendaModel tienda = TiendaModel();

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

      if(imagen==null){
        imagen = "vacio";
      }
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
      throw Exception('Fallo al agregar el Producto');
    }
  }

  Future<List<dynamic>> traerProductos(Widget widget) async {
    final response = await http.post(urlTraerProductos, body: {
      "idTienda": tienda.idTiendas.toString(),
    });

    List<dynamic> productosImagenes = new List<dynamic>();
    if (response.statusCode == 200) {
      if (response.body == "Error") {
        throw Exception("Fallo al traer los productos");
      } else {
        if (response.body == "") {
          return productosImagenes;
        }
        final List<dynamic> valores = json.decode(response.body);
        for (var i = 0; i < valores.length; i++) {
          ProductoImagenModel productoImagen =
              new ProductoImagenModel.fromJson(valores[i]);
          productosImagenes.add(productoImagen);
        }
        productosImagenes.add(widget);
      }
    }
    return productosImagenes;
  }

  Future<List<CategoriaModel>> traerCategorias() async {
    final response = await http.post(urlTraerCategorias, body: {
      "idTienda": tienda.idTiendas.toString(),
    });

    List<CategoriaModel> categorias = new List<CategoriaModel>();
    if (response.statusCode == 200) {
      if (response.body == "Error") {
        throw Exception("Fallo al traer los productos");
      } else {
        if (response.body == "") {
          return categorias;
        }
        final List<dynamic> valores = json.decode(response.body);
        for (var i = 0; i < valores.length; i++) {
          CategoriaModel productoImagen =
              new CategoriaModel.fromJson(valores[i]);
          categorias.add(productoImagen);
        }
      }
    }
    return categorias;
  }

  Future agregarCategoria({String nombreCategoria, String idTienda}) async {
    final response = await http.post(urlAgregarCategoria, body: {
      "nombreCategoria": nombreCategoria,
      "idTienda": idTienda,
    });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception("Fallo al agregar la categoria");
    }
  }
}
