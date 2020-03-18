import 'package:flutter/cupertino.dart';
import 'package:kytestore/Views/login/login_view.dart';
import 'package:kytestore/Views/productos/nuevoProducto.dart';
import 'package:kytestore/Views/vender/vender_view.dart';

Map<String, WidgetBuilder> getRutas() {
  return {
    'venderView': (context) => VenderView(),
    'loginView': (context) => LoginView(),
    'nuevoProducto': (context) =>NuevoProducto(),
  };
}
