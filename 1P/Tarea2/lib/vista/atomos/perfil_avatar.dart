import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';

/// Átomo: Avatar circular del perfil
class PerfilAvatar extends StatelessWidget {
  final String iniciales;
  final double radius;

  const PerfilAvatar({
    Key? key,
    required this.iniciales,
    this.radius = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: ColorApp.primaio,
      child: Text(
        iniciales,
        style: TextStyle(
          fontSize: radius * 0.6,
          fontWeight: FontWeight.bold,
          color: ColorApp.textoClaro,
        ),
      ),
    );
  }
}
