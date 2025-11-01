import '../models/sale_model.dart';

// Problema 1
class SaleController {
  late SaleModel _model;

  void setSaleData({required double montoVenta, double comisionVendedor = 0.10}) {
    _model = SaleModel(
      montoVenta: montoVenta,
      comisionVendedor: comisionVendedor,
    );
  }

  double getSubtotal() => _model.subtotal;
  
  double getIva() => _model.iva;
  
  double getDescuento() => _model.descuento;
  
  double getTotal() => _model.total;
  
  double getSueldoVendedor() => _model.sueldoVendedor;
}
