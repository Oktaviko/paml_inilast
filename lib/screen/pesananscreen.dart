import 'package:flutter/material.dart';
import 'package:paml_inilast/services/studioservice.dart';
import 'package:paml_inilast/models/studio.dart';
import 'editpesanan.dart';

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

  void _editData(Studio pesanan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPesananScreen(studio: pesanan),
      ),
    );
  }

  void _deleteData(String id) async {
    final bool success = await _studioService.deleteStudio(id);
    if (success) {
      setState(() {
        _futureStudios = _studioService.getStudios();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data berhasil dihapus',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menghapus data',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Pesanan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    final pesananList = snapshot.data!;
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
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _editData(pesanan),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: pesanan.id != null
                                        ? () => _deleteData(pesanan.id!)
                                        : null, // Periksa null dan gunakan id
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
