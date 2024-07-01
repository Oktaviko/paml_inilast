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
        title: const Text('Daftar Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
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
                        .where((studio) => studio.status == 'Diterima')
                        .toList();
                    return ListView.builder(
                      itemCount: pesananList.length,
                      itemBuilder: (context, index) {
                        final pesanan = pesananList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
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
