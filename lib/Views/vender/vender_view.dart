import 'dart:ui';
import 'package:multi_store/Views/vender/tab_widget.dart';
import 'package:multi_store/navigation_widget.dart';
import 'package:flutter/material.dart';

class VenderView extends StatefulWidget {
  const VenderView({Key key}) : super(key: key);

  @override
  _VenderViewState createState() => _VenderViewState();
}

class _VenderViewState extends State<VenderView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> productos = <Tab>[
    Tab(text: 'TODOS'),
    Tab(text: 'TECLADOS'),
    Tab(text: 'MONITORES'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: productos.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationWidget(),
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: productos,
          // isScrollable: true,
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
      body: TabBarView(
        controller: _tabController,
        children: [
          TabWidget(),
          TabWidget(),
          TabWidget(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floatWidget(),
    );
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
