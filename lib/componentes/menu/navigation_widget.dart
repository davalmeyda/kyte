import 'package:flutter/material.dart';
import 'package:kytestore/constants/configuraciones.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _tituloMenu(String nombre, Icon icono, {bool active = false}) {
      return Container(
        height: 50,
        color: active ? Colors.white12 : null,
        child: ListTile(
          title: Align(
            child: Text(
              nombre,
              style: Theme.of(context).textTheme.subtitle,
            ),
            alignment: Alignment(-1.2, 0),
          ),
          leading: icono,
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
      );
    }

    return ListTileTheme(
      dense: true,
      iconColor: Theme.of(context).textTheme.subtitle.color,
      child: Drawer(
        child: Ink(
          color: Color(ConstConfiguraciones.colorOscuro),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 150,
                child: DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Pro Solutions',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          'David Almeyda',
                          style: TextStyle(color: Colors.white54),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _tituloMenu(
                  'Vender                ', Icon(Icons.check_circle_outline), active: true),
              _tituloMenu('Productos          ', Icon(Icons.dashboard)),
              _tituloMenu('Clientes              ', Icon(Icons.person_outline)),
              _tituloMenu('Transacciones   ', Icon(Icons.attach_money)),
              _tituloMenu('Estadisticas       ', Icon(Icons.show_chart)),
              _tituloMenu('Usuarios             ', Icon(Icons.group)),
              _tituloMenu('Configuraciones', Icon(Icons.settings)),
              _tituloMenu('Ayuda                  ', Icon(Icons.help_outline)),
            ],
          ),
        ),
      ),
    );
  }
}
