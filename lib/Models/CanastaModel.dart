import 'package:kytestore/Models/ProductosCanastaModel.dart';

class CanastaModel {
  double totalCanasta;
  int descuento;
  double descuentoCantidad;
  int descuentoPorcentaje;
  String observacion;
  int items;

  CanastaModel({
    this.totalCanasta = 0,
    this.descuento,
    this.descuentoCantidad,
    this.descuentoPorcentaje,
    this.items = 0,
    this.observacion,
  });

  calcular({List<ProductosCanastaModel> listaProductosCanasta}) {
    double totalProducto = 0;
    double total1 = 0;
    int inicio = 0;
    listaProductosCanasta.forEach((productosCanasta) {
      if (productosCanasta.precioDescuento == null) {
        switch (productosCanasta.descuento) {
          case 0:
            totalProducto =
                (productosCanasta.cantidad * productosCanasta.producto.precio);
            break;
          case 1:
            totalProducto =
                (productosCanasta.cantidad * productosCanasta.producto.precio) -
                    productosCanasta.descuentoCantidad;
            break;
          case 2:
            totalProducto =
                (productosCanasta.cantidad * productosCanasta.producto.precio) -
                    (productosCanasta.descuentoPorcentaje *
                        productosCanasta.producto.precio /
                        100);
            break;
          default:
        }
      } else {
        switch (productosCanasta.descuento) {
          case 0:
            totalProducto =
                (productosCanasta.cantidad * productosCanasta.precioDescuento);
            break;
          case 1:
            totalProducto =
                (productosCanasta.cantidad * productosCanasta.precioDescuento) -
                    productosCanasta.descuentoCantidad;
            break;
          case 2:
            totalProducto =
                (productosCanasta.cantidad * productosCanasta.precioDescuento) -
                    (productosCanasta.descuentoPorcentaje *
                        productosCanasta.producto.precio /
                        100);
            break;
          default:
        }
      }
      inicio = inicio + productosCanasta.cantidad;
      total1 = totalProducto + total1;
    });
    this.items = inicio;
    this.totalCanasta = total1;
  }

  agregarDescuento({int porcentaje, double fijo}) {
    if (porcentaje == null) {
      if (fijo != null) {
        totalCanasta = totalCanasta - fijo;
        descuento = 1;
        descuentoCantidad = fijo;
        descuentoPorcentaje = 0;
      }
    } else {
      totalCanasta = totalCanasta * porcentaje / 100;
      descuento = 2;
      descuentoCantidad = 0;
      descuentoPorcentaje = porcentaje;
    }
  }

  quitarDescuento() {
    descuento = 0;
    descuentoCantidad = 0;
    descuentoPorcentaje = 0;
  }

  agregarObservacion({String observaciones}) {
    observacion = observaciones;
  }

  quitarObservacion() {
    observacion = "";
  }
}
