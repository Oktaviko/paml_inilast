import 'package:flutter/material.dart';
import 'package:paml_inilast/models/studio.dart';
import 'package:paml_inilast/services/studioservice.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  final StudioService _studioService = StudioService();
  late Future<List<Studio>> _futureStudios;

  @override
  void initState() {
    super.initState();
    _futureStudios = _studioService.getStudios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pesanan Anda"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                'Studio Musik',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Studio>>(
                future: _futureStudios,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Failed to load data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final pesananList = snapshot.data!
                        .where((pesanan) => pesanan.status != 'Pending')
                        .toList();
                    return ListView.builder(
                      itemCount: pesananList.length,
                      itemBuilder: (context, index) {
                        final pesanan = pesananList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: pesanan.status ==
                                    'Tidak diterima karena jadwal telah terisi, silahkan pesan ulang'
                                ? Colors.redAccent
                                : Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: Text('Nama Band: ${pesanan.nama_band}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Durasi: ${pesanan.durasi}'),
                                  const SizedBox(height: 4),
                                  Text('Jam Sewa: ${pesanan.jam_sewa}'),
                                  const SizedBox(height: 4),
                                  Text('Hari: ${pesanan.hari}'),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Status: ${pesanan.status ?? 'Pending'}',
                                    style: TextStyle(
                                      color: pesanan.status ==
                                              'Tidak diterima karena jadwal telah terisi, silahkan pesan ulang'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
