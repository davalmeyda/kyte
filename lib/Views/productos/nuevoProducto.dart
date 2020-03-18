import 'package:flutter/material.dart';
import 'package:kytestore/Views/productos/registro/registro_Tap.dart';

class NuevoProducto extends StatefulWidget {
  NuevoProducto({Key key}) : super(key: key);

  @override
  _NuevoProductoState createState() => _NuevoProductoState();
}

class _NuevoProductoState extends State<NuevoProducto>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> nuevoProductos = <Tab>[
    Tab(text: 'REGISTRO'),
    Tab(text: 'STOCK'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: nuevoProductos.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: nuevoProductos,          
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Theme.of(context).textTheme.title.color,
        ),
        elevation: 0.0,
        title: Text("Nuevo Producto"),
      ),
      body:TabBarView(
          controller: _tabController,
          children: [
            RegistroView(),
            Text("hola"),
            
          ],
        ),
      
    );
  }
}
