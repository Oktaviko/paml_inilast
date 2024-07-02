import 'package:flutter/material.dart';
import 'package:paml_inilast/models/studio.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class StudioNota extends StatelessWidget {
  final Studio studio;
  const StudioNota({
    Key? key,
    required this.studio,
  }) : super(key: key);

  Future<pw.Document> generatePdf(Studio studio) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Container(
              padding: pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.blue, width: 2),
                borderRadius: pw.BorderRadius.circular(15),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Center(
                    child: pw.Text(
                      "Nota Sewa Studio",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 30,
                        color: PdfColors.blue,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Nama Band: ${studio.nama_band}',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe192), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Durasi: ${studio.durasi}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe192), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Jam Sewa: ${studio.jam_sewa}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe935), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Hari: ${studio.hari}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe227), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Pembayaran: ${studio.pembayaran}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe88e), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Total Harga: ${studio.total_harga}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe88e), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text(
                        'Status: ${studio.status ?? 'Pending'}',
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: studio.status == 'Diterima'
                              ? PdfColors.green
                              : studio.status ==
                                      'Tidak diterima karena jadwal telah terisi, silahkan pesan ulang'
                                  ? PdfColors.red
                                  : PdfColors.black,
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
    );

    return pdf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cetak Nota Studio Sebelas'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              final pdf = await generatePdf(studio);
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Sewa Studio",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Band: ${studio.nama_band}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Durasi: ${studio.durasi}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.schedule, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Jam Sewa: ${studio.jam_sewa}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Hari: ${studio.hari}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.payment, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Pembayaran: ${studio.pembayaran}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Total Harga: ${studio.total_harga}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.info, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Status: ${studio.status ?? 'Pending'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: studio.status == 'Diterima'
                                  ? Colors.green
                                  : studio.status ==
                                          'Tidak diterima karena jadwal telah terisi, silahkan pesan ulang'
                                      ? Colors.red
                                      : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
