import 'package:flutter/material.dart';
import 'package:paml_inilast/models/instrumen.dart';
import 'package:paml_inilast/screen/admin/components/instrumen/editinstrumen.dart';
import 'package:paml_inilast/services/instrumenservice.dart';

class ListInstrumen extends StatefulWidget {
  const ListInstrumen({super.key});

  @override
  State<ListInstrumen> createState() => _ListInstrumenState();
}

class _ListInstrumenState extends State<ListInstrumen> {
  final InstrumenService _instrumenService = InstrumenService();
  late Future<List<Instrumen>> _futureInstrumens;

  @override
  void initState() {
    super.initState();
    _futureInstrumens = _instrumenService.getInstrumens();
  }

  void _editData(Instrumen instrumen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditInstrumen(instrumen: instrumen),
      ),
    ).then((updatedInstrumen) {
      if (updatedInstrumen != null) {
        setState(() {
          _futureInstrumens = _instrumenService.getInstrumens();
        });
      }
    });
  }

  void _deleteData(String id) async {
    final bool success = await _instrumenService.deleteInstrumen(id);
    if (success) {
      setState(() {
        _futureInstrumens = _instrumenService.getInstrumens();
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('List Instrumen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Instrumen>>(
            future: _futureInstrumens,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load data'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                final instrumenList = snapshot.data!;
                return ListView.builder(
                  itemCount: instrumenList.length,
                  itemBuilder: (context, index) {
                    final instrumen = instrumenList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.music_note),
                          ),
                          title: Text('Nama: ${instrumen.nama_instrumen}'),
                          subtitle: Text('Jenis: ${instrumen.jenis}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _editData(instrumen),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: instrumen.id != null
                                    ? () => _deleteData(instrumen.id!)
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
      ),
    );
  }
}
