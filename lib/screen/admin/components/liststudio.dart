import 'package:flutter/material.dart';
import 'package:paml_inilast/models/studio.dart';
import 'package:paml_inilast/screen/admin/components/nota/studionota.dart';
import 'package:paml_inilast/screen/admin/update/editstudio.dart';
import 'package:paml_inilast/services/studioservice.dart';

class ListStudio extends StatefulWidget {
  const ListStudio({super.key});

  @override
  State<ListStudio> createState() => _ListStudioState();
}

class _ListStudioState extends State<ListStudio> {
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
        builder: (context) => EditStudio(studio: pesanan),
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

  void _updateStatus(String id, String status) async {
    final bool success = await _studioService.updateStatus(id, status);
    if (success) {
      setState(() {
        _futureStudios = _studioService.getStudios();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Status berhasil diperbarui',
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
            'Gagal memperbarui status',
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

  void _cetakNota(Studio studio) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudioNota(studio: studio),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.redAccent,
            Colors.orangeAccent,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                                title: Text(
                                  'Nama Band: ${pesanan.nama_band}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
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
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.download),
                                          onPressed: () => _cetakNota(pesanan),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.check_circle),
                                          onPressed: pesanan.id != null
                                              ? () => _updateStatus(
                                                  pesanan.id!, 'Diterima')
                                              : null, // Periksa null dan gunakan id
                                        ),
                                      ],
                                    ),
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
                                    IconButton(
                                      icon: const Icon(Icons.cancel),
                                      onPressed: pesanan.id != null
                                          ? () => _updateStatus(pesanan.id!,
                                              'Tidak diterima karena jadwal telah terisi, silahkan pesan ulang')
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
      ),
    );
  }
}
