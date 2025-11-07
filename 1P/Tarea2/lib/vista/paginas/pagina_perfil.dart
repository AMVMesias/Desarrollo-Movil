import 'package:flutter/material.dart';
import '../../controlador/perfil_controlador.dart';
import '../../modelo/perfil_modelo.dart';
import '../../temas/esquema_color.dart';
import 'pagina_login.dart';

// Página de perfil estilo Gabriel con tu tema
class PaginaPerfil extends StatefulWidget {
  final String tipoPerfil;

  const PaginaPerfil({Key? key, required this.tipoPerfil}) : super(key: key);

  @override
  State<PaginaPerfil> createState() => _PaginaPerfilState();
}

class _PaginaPerfilState extends State<PaginaPerfil> {
  late PerfilModelo perfil;

  @override
  void initState() {
    super.initState();
    final controlador = PerfilControlador();
    perfil = controlador.cargarPerfil(widget.tipoPerfil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.fondo,
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre - Centrado
          Center(
            child: Column(
              children: [
                Text(
                  perfil.nombreCompleto,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  perfil.carrera,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          // Información básica
          _buildItem('Teléfono', perfil.telefono),
          _buildItem('Edad', '${perfil.edad} años'),
          _buildItem('Email', perfil.email),
          
          if (perfil.githubUrl.isNotEmpty)
            _buildItem('GitHub', perfil.githubUrl),

          // Sobre mí
          if (perfil.sobreMi.isNotEmpty) ...[
            SizedBox(height: 24),
            Text(
              'Sobre Mí',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ColorApp.primaio,
              ),
            ),
            SizedBox(height: 8),
            Text(
              perfil.sobreMi,
              textAlign: TextAlign.justify,
            ),
          ],

          // Educación
          if (perfil.educacion.isNotEmpty) ...[
            SizedBox(height: 24),
            Text(
              'Educación',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ColorApp.primaio,
              ),
            ),
            SizedBox(height: 8),
            ...perfil.educacion.map((edu) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('• ${edu.titulo} - ${edu.institucion} (${edu.periodo})'),
                )),
          ],

          // Experiencia
          if (perfil.experiencia.isNotEmpty) ...[
            SizedBox(height: 24),
            Text(
              'Experiencia',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ColorApp.primaio,
              ),
            ),
            SizedBox(height: 8),
            ...perfil.experiencia.map((exp) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ${exp.cargo} - ${exp.empresa}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '  ${exp.periodo}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      if (exp.descripcion.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, left: 12),
                          child: Text(
                            exp.descripcion,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                    ],
                  ),
                )),
          ],

          // Habilidades
          if (perfil.habilidades.isNotEmpty) ...[
            SizedBox(height: 24),
            Text(
              'Habilidades',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ColorApp.primaio,
              ),
            ),
            SizedBox(height: 8),
            Text(perfil.habilidades.join(', ')),
          ],
        ],
      ),
    );
  }

  Widget _buildItem(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titulo: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}
