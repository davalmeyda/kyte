import 'dart:ui';
import 'package:kytestore/Models/CategoriaModel.dart';
import 'package:kytestore/Providers/ProductosProvider.dart';
import 'package:kytestore/Providers/VentasProvider.dart';
import 'package:kytestore/Views/vender/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kytestore/componentes/menu/navigation_widget.dart';
import 'package:kytestore/estados/estados.dart';

class VenderView extends StatefulWidget {
  const VenderView({Key key}) : super(key: key);

  @override
  _VenderViewState createState() => _VenderViewState();
}

class _VenderViewState extends State<VenderView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  DateTime currentBackPressTime;
  List<CategoriaModel> categorias = new List<CategoriaModel>();

  VentasProvider ventasProvider = new VentasProvider();
  ProductosProviders productosProviders = new ProductosProviders();

  List<Tab> productos = <Tab>[
    Tab(text: 'TODOS'),
  ];

  @override
  void initState() {
    super.initState();
    inicio();
    // productosProviders.traerProductos();
  }

  void inicio() async {
    Estados estados = Estados();
    categorias = await productosProviders.traerCategorias();
    estados.listaCategoria = categorias;
    productos = categorias.map((categoria) {
      return Tab(
        text: categoria.nombreCategoria,
      );
    }).toList();
    productos.insert(0, Tab(text: "Productos",));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: productos.length,
      child: Scaffold(
        drawer: NavigationWidget(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: productos,
            isScrollable: true,
            indicatorColor: Theme.of(context).accentColor,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).textTheme.title.color,
          ),
          elevation: 0.0,
          title: Text(
            'Vender',
            style: Theme.of(context).textTheme.title,
          ),
          actions: <Widget>[
            _nuevoClienteWidget(),
          ],
        ),
        body: WillPopScope(
          onWillPop: onWillPop,
          child: TabBarView(
            children: listaTab(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _floatWidget(),
      ),
    );
  }

  List<Widget> listaTab() {
    List<Widget> tabs = new List<Widget>();
    if (categorias.length == 0) {
      return [
        TabWidget(null),
      ];
    } else {
      tabs.add(TabWidget(null));
      for (CategoriaModel tab in categorias) {
        tabs.add(TabWidget(tab));
      }
    }
    return tabs;
  }

  // BOTON DE RETOCESO EN DOS TIEMPOS
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Presione dos veces para salir");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _nuevoClienteWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        icon: Icon(
          Icons.person_add,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _floatWidget() {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).accentColor,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        '6 items = 72.00 PEN',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
