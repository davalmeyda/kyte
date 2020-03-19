import 'package:flutter/material.dart';

class BotonPrincipal extends StatelessWidget {
  const BotonPrincipal(
      {Key key, this.next, this.texto, this.menuIcono, this.menu=false})
      : super(key: key);
  final Function next, menuIcono;
  final String texto;
  final bool menu;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: next,
      child: Container(
        height: 50,
        child: Row(
          children: <Widget>[
            menu
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    width: 50,
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: menuIcono,
                    ),
                  )
                : Container(),
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
                          texto,
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
      ),
    );
  }
}
