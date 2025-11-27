import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../viewmodel/operario_viewmodel.dart';

class PdfReportScreen extends StatelessWidget {
  const PdfReportScreen({super.key});

  Future<Uint8List> _generatePdfBytes(List historial) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'Reporte de Calculos Salariales',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  'Fecha: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black, width: 1),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.green100),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('N', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Aumento (\$)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Sueldo Final (\$)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  ...historial.asMap().entries.map((entry) {
                    final index = entry.key;
                    final resultado = entry.value;
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('${index + 1}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(resultado.aumento.toStringAsFixed(2)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(resultado.sueldoFinal.toStringAsFixed(2)),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                'Total de calculos: ${historial.length}',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<File> _savePdfToTemp(Uint8List bytes) async {
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/reporte_salarial.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OperarioViewModel>(
      builder: (context, viewModel, child) {
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Reporte PDF'),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: viewModel.historial.isEmpty
                    ? null
                    : () async {
                        try {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Generando PDF para compartir...')),
                          );
                          final bytes = await _generatePdfBytes(viewModel.historial);
                          final file = await _savePdfToTemp(bytes);
                          await Share.shareXFiles(
                            [XFile(file.path)],
                            text: 'Reporte de Calculos Salariales',
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error al compartir: $e')),
                          );
                        }
                      },
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: viewModel.historial.isEmpty
                    ? const Center(
                        child: Text('No hay calculos para mostrar en el reporte.'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: viewModel.historial.length,
                        itemBuilder: (context, index) {
                          final resultado = viewModel.historial[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Calculo #${index + 1}'),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Aumento: \$ ${resultado.aumento.toStringAsFixed(2)}'),
                                      Text(
                                        'Sueldo Final: \$ ${resultado.sueldoFinal.toStringAsFixed(2)}',
                                        style: theme.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Generar y Compartir PDF'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: viewModel.historial.isEmpty
                      ? null
                      : () async {
                          try {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Generando PDF...')),
                            );
                            final bytes = await _generatePdfBytes(viewModel.historial);
                            final file = await _savePdfToTemp(bytes);
                            
                            await Share.shareXFiles(
                              [XFile(file.path)],
                              text: 'Reporte de Calculos Salariales',
                            );
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('PDF generado exitosamente')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error al generar PDF: $e')),
                            );
                          }
                        },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
