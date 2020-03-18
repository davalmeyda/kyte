import 'package:flutter/material.dart';

class MultiplicadorIconWidget extends StatelessWidget {
  const MultiplicadorIconWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        //TODO: Implementar boton cambiar multiplicador para agregar productos
        print('tab');
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(right: 11, left: 10),
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(
            '1 X',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}