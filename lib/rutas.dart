import 'package:flutter/cupertino.dart';
import 'package:kytestore/Views/vender/vender_view.dart';

Map<String, WidgetBuilder> getRutas() {
  return {    
    'venderView': (context) => VenderView(),
  };
}
