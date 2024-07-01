import 'package:flutter/material.dart';
import 'package:paml_inilast/models/alatmusik.dart';
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

  void _deleteData(int id) async {
    final bool success = await _alatService.deleteAlat(id.toString());
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