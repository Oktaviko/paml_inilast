import 'package:flutter/material.dart';
import 'package:paml_inilast/models/alatmusik.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AlatNota extends StatelessWidget {
  final Alatmusik alat;
  const AlatNota({
    Key? key,
    required this.alat,
  }) : super(key: key);

  Future<pw.Document> generatePdf(Alatmusik alat) async {
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
                      "Nota Sewa Alat Musik",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 30,
                        color: PdfColors.blue,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Nama: ${alat.nama}',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe0b0), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Nomor HP: ${alat.no_hp}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe405), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Instrumen: ${alat.instrumen}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe192), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Durasi: ${alat.durasi}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe935), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Hari: ${alat.hari}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe88e), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Total Harga: ${alat.total_harga}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe227), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text('Pembayaran: ${alat.pembayaran}',
                          style: pw.TextStyle(fontSize: 16)),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Icon(pw.IconData(0xe88e), color: PdfColors.blue),
                      pw.SizedBox(width: 8),
                      pw.Text(
                        'Status: ${alat.status ?? 'Pending'}',
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: alat.status == 'Diterima'
                              ? PdfColors.green
                              : alat.status ==
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
        title: const Text('Cetak Nota Sewa Alat Musik'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              final pdf = await generatePdf(alat);
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
                  "Sewa Alat Musik",
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
                        'Nama: ${alat.nama}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Nomor HP: ${alat.no_hp}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.music_note, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Instrumen: ${alat.instrumen}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Durasi: ${alat.durasi}',
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
                            'Hari: ${alat.hari}',
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
                            'Pembayaran: ${alat.pembayaran}',
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
                            'Total Harga: ${alat.total_harga}',
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
                            'Status: ${alat.status ?? 'Pending'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: alat.status == 'Diterima'
                                  ? Colors.green
                                  : alat.status ==
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
