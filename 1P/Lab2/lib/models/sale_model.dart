import 'dart:math';

// Problema 1: IVA 15%, descuento 20% si > $2000, comisión 10%
class SaleModel {
  double montoVenta;
  double comisionVendedor;
  
  SaleModel({
    required this.montoVenta,
    this.comisionVendedor = 0.10,
  });

  double get subtotal => montoVenta;

  double get iva {
    return subtotal * 0.15; // subtotal × 0.15
  }

  double get descuento {
    if (subtotal > 2000) {
      return subtotal * 0.20; // subtotal × 0.20 si > $2000
    }
    return 0.0; // 0 si <= $2000
  }

  double get total {
    return subtotal + iva - descuento; // subtotal + IVA - descuento
  }

  double get sueldoVendedor {
    return total * comisionVendedor; // total × comisión
  }
}
