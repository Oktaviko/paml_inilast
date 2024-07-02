import 'package:flutter/material.dart';
import 'package:paml_inilast/models/recording.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RecordNota extends StatelessWidget {
  final Recording recording;
  const RecordNota({
    Key? key,
    required this.recording,
  }) : super(key: key);

  Future<pw.Document> generatePdf(Recording recording) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Center(
                  child: pw.Text(
                    "Recording Studio",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 30,
                      color: PdfColors.blueAccent,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  padding: pw.EdgeInsets.all(16.0),
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(15),
                    border: pw.Border.all(color: PdfColors.blueAccent),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Nama Band: ${recording.nama_band}',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        children: [
                          pw.Icon(pw.IconData(0xe24f)),
                          pw.SizedBox(width: 8),
                          pw.Text(
                            'Durasi: ${recording.durasi}',
                            style: pw.TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        children: [
                          pw.Icon(pw.IconData(0xe24d)),
                          pw.SizedBox(width: 8),
                          pw.Text(
                            'Jam Sewa: ${recording.jam_sewa}',
                            style: pw.TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        children: [
                          pw.Icon(pw.IconData(0xe935)),
                          pw.SizedBox(width: 8),
                          pw.Text(
                            'Hari: ${recording.hari}',
                            style: pw.TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        children: [
                          pw.Icon(pw.IconData(0xe227)),
                          pw.SizedBox(width: 8),
                          pw.Text(
                            'Pembayaran: ${recording.pembayaran}',
                            style: pw.TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        children: [
                          pw.Icon(pw.IconData(0xe227)),
                          pw.SizedBox(width: 8),
                          pw.Text(
                            'Total Harga: ${recording.total_harga}',
                            style: pw.TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        children: [
                          pw.Icon(pw.IconData(0xe88e)),
                          pw.SizedBox(width: 8),
                          pw.Text(
                            'Status: ${recording.status ?? 'Pending'}',
                            style: pw.TextStyle(
                              fontSize: 16,
                              color: recording.status == 'Diterima'
                                  ? PdfColors.green
                                  : recording.status ==
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
              ],
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
        title: const Text('Cetak Nota Recording'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              final pdf = await generatePdf(recording);
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
                  "Recording Studio",
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
                        'Nama Band: ${recording.nama_band}',
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
                            'Durasi: ${recording.durasi}',
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
                            'Jam Sewa: ${recording.jam_sewa}',
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
                            'Hari: ${recording.hari}',
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
                            'Pembayaran: ${recording.pembayaran}',
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
                            'Total Harga: ${recording.total_harga}',
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
                            'Status: ${recording.status ?? 'Pending'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: recording.status == 'Diterima'
                                  ? Colors.green
                                  : recording.status ==
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
