import 'package:flutter/material.dart';
import 'package:paml_inilast/models/alatmusik.dart';
import 'package:paml_inilast/screen/admin/components/nota/alatnota.dart';
import 'package:paml_inilast/screen/admin/update/editsewa.dart';
import 'package:paml_inilast/services/alatservice.dart';

class ListAlat extends StatefulWidget {
  const ListAlat({super.key});

  @override
  State<ListAlat> createState() => _ListAlatState();
}

class _ListAlatState extends State<ListAlat> {
  final Alatservice _alatService = Alatservice();
  late Future<List<Alatmusik>> _futureAlats;

  @override
  void initState() {
    super.initState();
    _futureAlats = _alatService.getAlats();
  }

  void _editData(Alatmusik alat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSewa(alat: alat),
      ),
    );
  }

  void _deleteData(String id) async {
    final bool success = await _alatService.deleteAlat(id);
    if (success) {
      setState(() {
        _futureAlats = _alatService.getAlats();
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
    final bool success = await _alatService.updateStatus(id, status);
    if (success) {
      setState(() {
        _futureAlats = _alatService.getAlats();
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

  void _cetakNota(Alatmusik alat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlatNota(alat: alat),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                'Sewa Alat Musik',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Alatmusik>>(
                future: _futureAlats,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Failed to load data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final alatList = snapshot.data!;
                    return ListView.builder(
                      itemCount: alatList.length,
                      itemBuilder: (context, index) {
                        final alat = alatList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text('Nama: ${alat.nama}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Instrumen: ${alat.instrumen}'),
                                  const SizedBox(height: 4),
                                  Text('Durasi: ${alat.durasi}'),
                                  const SizedBox(height: 4),
                                  Text('Hari: ${alat.hari}'),
                                  const SizedBox(height: 4),
                                  Text('Status: ${alat.status ?? 'Pending'}'),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.download),
                                        onPressed: () => _cetakNota(alat),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.check_circle),
                                        onPressed: alat.id != null
                                            ? () => _updateStatus(
                                                alat.id!, 'Diterima')
                                            : null,
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
                                    onPressed: () => _editData(alat),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: alat.id != null
                                        ? () => _deleteData(alat.id!)
                                        : null,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.cancel),
                                    onPressed: alat.id != null
                                        ? () => _updateStatus(alat.id!,
                                            'Tidak diterima karena jadwal telah terisi, silahkan pesan ulang')
                                        : null,
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
