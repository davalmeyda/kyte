import 'package:kytestore/Models/CategoriaModel.dart';
import 'package:kytestore/Providers/ProductosProvider.dart';
import 'package:kytestore/Providers/VentasProvider.dart';
import 'package:kytestore/Views/vender/tabs/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kytestore/componentes/botones/botonPrincipal.dart';
import 'package:kytestore/componentes/menu/navigation_widget.dart';
import 'package:kytestore/estados/estados.dart';

class VenderView extends StatefulWidget {
  const VenderView({Key key}) : super(key: key);

  @override
  _VenderViewState createState() => _VenderViewState();
}

class _VenderViewState extends State<VenderView>
    with SingleTickerProviderStateMixin {
  DateTime currentBackPressTime;
  List<CategoriaModel> categorias = new List<CategoriaModel>();
  Estados estados = Estados();

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
    categorias = await productosProviders.traerCategorias();
    estados.listaCategoria = categorias;
    productos = categorias.map((categoria) {
      return Tab(
        text: categoria.nombreCategoria,
      );
    }).toList();
    productos.insert(
        0,
        Tab(
          text: "Productos",
        ));
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
        floatingActionButton: BotonPrincipal(
          next: nextCarrito,
          texto: estados.canastaModel.items.toString() +
              ' items = ' +
              estados.canastaModel.totalCanasta.toString() +
              ' PEN',
        ),
      ),
    );
  }

  void actualizarVista() {
    setState(() {});
  }

  List<Widget> listaTab() {
    List<Widget> tabs = new List<Widget>();
    if (categorias.length == 0) {
      return [
        TabWidget(
          null,
          funcion: this.actualizarVista,
        ),
      ];
    } else {
      tabs.add(TabWidget(
        null,
        funcion: this.actualizarVista,
      ));
      for (CategoriaModel tab in categorias) {
        tabs.add(TabWidget(
          tab,
          funcion: this.actualizarVista,
        ));
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

  // NUEVO CLIENTE
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

  // BOTON CARRITO
  void nextCarrito() {
    Navigator.pushNamed(context, 'rutaCarrito', arguments: {'qr': false});
  }
}
