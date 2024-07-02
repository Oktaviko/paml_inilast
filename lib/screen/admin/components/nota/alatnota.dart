import 'package:flutter/material.dart';

import 'package:paml_inilast/models/alatmusik.dart';

class AlatNota extends StatelessWidget {
  final Alatmusik alat;
  const AlatNota({
    Key? key,
    required this.alat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cetak Nota Sewa Alat Musik'),
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