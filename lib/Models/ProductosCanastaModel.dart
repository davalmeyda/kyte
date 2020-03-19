import 'package:kytestore/Models/ProductoImagenModel.dart';

class ProductosCanastaModel {
  ProductoImagenModel producto;
  int cantidad;
  int descuento = 0; //0-1
  double descuentoCantidad = 0;
  double descuentoPorcentaje = 0;
  double precioTotalDescuento = 0;
  double precioDescuento;

  ProductosCanastaModel({
    this.producto,
    this.cantidad,
    this.descuento = 0,
    this.descuentoCantidad = 0,
    this.descuentoPorcentaje = 0,
    this.precioDescuento,
    this.precioTotalDescuento = 0,
  });

  agregarDescuento({bool fijo, double cantidad1}) {
    if (fijo) {
      this.precioTotalDescuento =
          (this.cantidad * this.producto.precio) - cantidad1;
      this.descuentoCantidad = cantidad1; // 60
      this.descuentoPorcentaje =
          ((100 * cantidad1) / this.precioTotalDescuento); //30
    } else {
      this.precioTotalDescuento = (this.cantidad * this.producto.precio);
      this.descuentoCantidad =
          ((this.precioTotalDescuento * cantidad1) / 100); //60
      this.descuentoPorcentaje = cantidad1; //30
      this.precioTotalDescuento =
          this.precioTotalDescuento - this.descuentoCantidad;
    }
    this.descuento = 1;
  }

  quitarDescuento() {
    this.descuentoCantidad = 0;
    this.descuentoPorcentaje = 0;
    this.descuento = 0;
    this.precioTotalDescuento=0;
  }

  quitarPrecioDescuento() {
    this.precioDescuento = null;
  }
}
