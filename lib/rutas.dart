import 'package:flutter/cupertino.dart';
import 'package:multi_store/Views/vender/vender_view.dart';

Map<String, WidgetBuilder> getRutas() {
  return {    
    'venderView': (context) => VenderView(),
  };
}
