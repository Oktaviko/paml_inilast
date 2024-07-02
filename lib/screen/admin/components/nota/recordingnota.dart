import 'package:flutter/material.dart';

import 'package:paml_inilast/models/recording.dart';

class RecordNota extends StatelessWidget {
  final Recording recording;
  const RecordNota({
    Key? key,
    required this.recording,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cetak Nota Recording'),
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