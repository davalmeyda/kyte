import 'package:kytestore/Models/CategoriaModel.dart';

class Estados {
  CategoriaModel categoria = new CategoriaModel();
  List<CategoriaModel> listaCategoria = List<CategoriaModel>();

  static final Estados _inst = Estados._internal();

  Estados._internal();

  factory Estados() {
    return _inst;
  }
}