import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kytestore/Models/ProductoImagenModel.dart';
import 'package:kytestore/Models/ProductosCanastaModel.dart';
import 'package:kytestore/Models/TiendaModel.dart';
import 'package:kytestore/constants/configuraciones.dart';
import 'package:http/http.dart' as http;
import 'package:kytestore/estados/estados.dart';

class VentasProvider {
  String urlTraerProductosCategorias =
      ConstConfiguraciones.urlBackend + "traerProductosCategoria.php";
  String urlBuscarQr = ConstConfiguraciones.urlBackend + "buscarQr.php";
  TiendaModel tienda = TiendaModel();

  Future traerProductosCategoria(String idCategoria, Widget widget) async {
    final response = await http.post(urlTraerProductosCategorias, body: {
      "idTienda": tienda.idTiendas.toString(),
      "idCategoria": idCategoria,
    });

    List<dynamic> categorias = new List<dynamic>();
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
        categorias.add(widget);
      }
    }
    return categorias;
  }

  Future<List<ProductoImagenModel>> buscarQr(String qr) async {
    final response = await http.post(urlBuscarQr, body: {
      "idTienda": tienda.idTiendas.toString(),
      "qr": qr,
    });

    List<ProductoImagenModel> productosImagenes = new List<ProductoImagenModel>();
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
      }
    }
    return productosImagenes;
  }

  void agregarCarrito(ProductoImagenModel producto) {
    Estados estados = Estados();
    bool encontro = false;
    if (estados.listaProductosCanastaModel.length != 0) {
      estados.listaProductosCanastaModel.forEach((productosCanastaModel) {
        if (productosCanastaModel.producto.idProductos ==
            producto.idProductos) {
          productosCanastaModel.cantidad =
              productosCanastaModel.cantidad + estados.cantidad;
          productosCanastaModel.quitarDescuento();
          estados.canastaModel.calcular(
              listaProductosCanasta: estados.listaProductosCanastaModel);
          encontro = true;
        }
      });
      if (!encontro) {
        ProductosCanastaModel productosCanastaModel = new ProductosCanastaModel(
            producto: producto, cantidad: estados.cantidad, descuento: 0);
        estados.listaProductosCanastaModel.add(productosCanastaModel);
        estados.canastaModel.calcular(
            listaProductosCanasta: estados.listaProductosCanastaModel);
      }
    } else {
      ProductosCanastaModel productosCanastaModel = new ProductosCanastaModel(
          producto: producto, cantidad: estados.cantidad, descuento: 0);
      estados.listaProductosCanastaModel.add(productosCanastaModel);
      estados.canastaModel
          .calcular(listaProductosCanasta: estados.listaProductosCanastaModel);
    }
  }
}
