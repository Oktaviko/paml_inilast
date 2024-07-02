import 'package:flutter/material.dart';
import 'package:paml_inilast/models/studio.dart';
import 'package:paml_inilast/models/recording.dart';
import 'package:paml_inilast/models/alatmusik.dart';
import 'package:paml_inilast/services/studioservice.dart';
import 'package:paml_inilast/services/recordingservice.dart';
import 'package:paml_inilast/services/alatservice.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  final StudioService _studioService = StudioService();
  final RecordingService _recordingService = RecordingService();
  final Alatservice _alatService = Alatservice();

  late Future<List<Studio>> _futureStudios;
  late Future<List<Recording>> _futureRecordings;
  late Future<List<Alatmusik>> _futureAlats;

  @override
  void initState() {
    super.initState();
    _futureStudios = _studioService.getStudios();
    _futureRecordings = _recordingService.getRecordings();
    _futureAlats = _alatService.getAlats();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.green,
            Colors.yellow,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text("Pesanan Anda"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Text(
                    'Studio Musik',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder<List<Studio>>(
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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                Center(
                  child: const Text(
                    'Recording Studio',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder<List<Recording>>(
                  future: _futureRecordings,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Failed to load data'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final recordingList = snapshot.data!
                          .where((recording) => recording.status != 'Pending')
                          .toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recordingList.length,
                        itemBuilder: (context, index) {
                          final recording = recordingList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: recording.status ==
                                      'Tidak diterima karena jadwal telah terisi, silahkan pesan ulang'
                                  ? Colors.redAccent
                                  : Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                title:
                                    Text('Nama Band: ${recording.nama_band}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Durasi: ${recording.durasi}'),
                                    const SizedBox(height: 4),
                                    Text('Jam Sewa: ${recording.jam_sewa}'),
                                    const SizedBox(height: 4),
                                    Text('Hari: ${recording.hari}'),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Status: ${recording.status ?? 'Pending'}',
                                      style: TextStyle(
                                        color: recording.status ==
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
                Center(
                  child: const Text(
                    'Sewa Alat Musik',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder<List<Alatmusik>>(
                  future: _futureAlats,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Failed to load data'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final alatList = snapshot.data!
                          .where((alat) => alat.status != 'Pending')
                          .toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: alatList.length,
                        itemBuilder: (context, index) {
                          final alat = alatList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: alat.status ==
                                      'Tidak diterima karena jadwal telah terisi, silahkan pesan ulang'
                                  ? Colors.redAccent
                                  : Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.music_note),
                                ),
                                title: Text('Nama: ${alat.nama}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Instrumen: ${alat.instrumen}'),
                                    const SizedBox(height: 4),
                                    Text('Durasi: ${alat.durasi}'),
                                    const SizedBox(height: 4),
                                    Text('Status: ${alat.status ?? 'Pending'}'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
