import 'package:flutter/material.dart';
import 'package:paml_inilast/models/alatmusik.dart';
import 'package:paml_inilast/services/alatservice.dart';

class EditSewa extends StatefulWidget {
  final Alatmusik alat;

  const EditSewa({super.key, required this.alat});

  @override
  State<EditSewa> createState() => _EditSewaState();
}

class _EditSewaState extends State<EditSewa> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _noHpController;
  late TextEditingController _instrumenController;
  late TextEditingController _durasiController;
  late TextEditingController _opsiController;
  late TextEditingController _alamatController;
  late TextEditingController _pembayaranController;
  late TextEditingController _totalHargaController;
  final Alatservice _alatService = Alatservice();

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.alat.nama);
    _noHpController = TextEditingController(text: widget.alat.no_hp);
    _instrumenController = TextEditingController(text: widget.alat.instrumen);
    _durasiController = TextEditingController(text: widget.alat.durasi);
    _opsiController = TextEditingController(text: widget.alat.opsi);
    _alamatController = TextEditingController(text: widget.alat.alamat);
    _pembayaranController = TextEditingController(text: widget.alat.pembayaran);
    _totalHargaController =
        TextEditingController(text: widget.alat.total_harga);
  }

  void _updateData() async {
    if (_formKey.currentState!.validate()) {
      Alatmusik updatedAlat = Alatmusik(
        id: widget.alat.id,
        nama: _namaController.text,
        no_hp: _noHpController.text,
        instrumen: _instrumenController.text,
        durasi: _durasiController.text,
        opsi: _opsiController.text,
        alamat: _alamatController.text,
        pembayaran: _pembayaranController.text,
        total_harga: _totalHargaController.text,
        hari: '',
      );

      bool success =
          await _alatService.updateAlat(updatedAlat, updatedAlat.id.toString());
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Data berhasil diperbarui',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal memperbarui data',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Sewa Alat Musik'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama lengkap tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _noHpController,
                decoration: const InputDecoration(labelText: 'No HP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No HP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _instrumenController,
                decoration: const InputDecoration(labelText: 'Instrumen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Instrumen tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _durasiController,
                decoration: const InputDecoration(labelText: 'Durasi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Durasi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _opsiController,
                decoration: const InputDecoration(labelText: 'Opsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Opsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _pembayaranController,
                decoration: const InputDecoration(labelText: 'Pembayaran'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pembayaran tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _totalHargaController,
                decoration: const InputDecoration(labelText: 'Total Harga'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Total harga tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateData,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
