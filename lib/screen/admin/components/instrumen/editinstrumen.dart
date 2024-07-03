import 'package:flutter/material.dart';
import 'package:paml_inilast/models/instrumen.dart';
import 'package:paml_inilast/services/instrumenservice.dart';

class EditInstrumen extends StatefulWidget {
  final Instrumen instrumen;

  const EditInstrumen({required this.instrumen, super.key});

  @override
  State<EditInstrumen> createState() => _EditInstrumenState();
}

class _EditInstrumenState extends State<EditInstrumen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaInstrumenController;
  late TextEditingController _jenisInstrumenController;
  final InstrumenService _instrumenService = InstrumenService();

  @override
  void initState() {
    super.initState();
    _namaInstrumenController =
        TextEditingController(text: widget.instrumen.nama_instrumen);
    _jenisInstrumenController =
        TextEditingController(text: widget.instrumen.jenis);
  }

  @override
  void dispose() {
    _namaInstrumenController.dispose();
    _jenisInstrumenController.dispose();
    super.dispose();
  }

  Future<void> _updateInstrumen() async {
    if (_formKey.currentState!.validate()) {
      Instrumen updatedInstrumen = Instrumen(
        id: widget.instrumen.id,
        nama_instrumen: _namaInstrumenController.text,
        jenis: _jenisInstrumenController.text,
      );

      bool success = await _instrumenService.updateInstrumen(
        updatedInstrumen,
        updatedInstrumen.id!,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data instrumen berhasil diperbarui'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, updatedInstrumen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memperbarui instrumen'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
          title: const Text('Edit Instrumen'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _namaInstrumenController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Instrumen',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama instrumen tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _jenisInstrumenController,
                  decoration: const InputDecoration(
                    labelText: 'Jenis',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jenis instrumen tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _updateInstrumen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 250, 250, 250),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text(
                      'Simpan Perubahan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
