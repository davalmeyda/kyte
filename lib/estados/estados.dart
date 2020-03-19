import 'package:kytestore/Models/CanastaModel.dart';
import 'package:kytestore/Models/CategoriaModel.dart';
import 'package:kytestore/Models/ProductosCanastaModel.dart';

class Estados {
  CategoriaModel categoria = new CategoriaModel();
  List<CategoriaModel> listaCategoria = new List<CategoriaModel>();
  List<ProductosCanastaModel> listaProductosCanastaModel =
      new List<ProductosCanastaModel>();
  CanastaModel canastaModel = new CanastaModel();
  int cantidad = 1;

  static final Estados _inst = Estados._internal();

  Estados._internal();

  factory Estados() {
    return _inst;
  }
}
