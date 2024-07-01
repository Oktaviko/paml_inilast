import 'package:flutter/material.dart';
import 'package:paml_inilast/models/studio.dart';
import 'package:paml_inilast/services/studioservice.dart';

class EditPesananScreen extends StatefulWidget {
  final Studio studio;

  const EditPesananScreen({super.key, required this.studio});

  @override
  _EditPesananScreenState createState() => _EditPesananScreenState();
}

class _EditPesananScreenState extends State<EditPesananScreen> {
  late TextEditingController namaBandController;
  late TextEditingController jamSewaController;
  late TextEditingController hariController;
  late TextEditingController durasiController;
  late TextEditingController pembayaranController;
  late TextEditingController totalHargaController;

  final StudioService _studioService = StudioService();

  @override
  void initState() {
    super.initState();
    namaBandController = TextEditingController(text: widget.studio.nama_band);
    jamSewaController = TextEditingController(text: widget.studio.jam_sewa);
    hariController = TextEditingController(text: widget.studio.hari);
    durasiController = TextEditingController(text: widget.studio.durasi);
    pembayaranController = TextEditingController(text: widget.studio.pembayaran);
    totalHargaController = TextEditingController(text: widget.studio.total_harga);
  }

  @override
  void dispose() {
    namaBandController.dispose();
    jamSewaController.dispose();
    hariController.dispose();
    durasiController.dispose();
    pembayaranController.dispose();
    totalHargaController.dispose();
    super.dispose();
  }

  Future<void> _updatePesanan() async {
    Studio updatedStudio = Studio(
      id: widget.studio.id, // Pastikan ID disertakan
      nama_band: namaBandController.text,
      jam_sewa: jamSewaController.text,
      hari: hariController.text,
      durasi: durasiController.text,
      pembayaran: pembayaranController.text,
      total_harga: totalHargaController.text,
    );

    bool success = await _studioService.updateStudio(updatedStudio, updatedStudio.id!);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data berhasil diperbarui'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true); // Kembalikan ke layar sebelumnya dengan status berhasil
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui data'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaBandController,
              decoration: const InputDecoration(labelText: 'Nama Band'),
            ),
            TextField(
              controller: jamSewaController,
              decoration: const InputDecoration(labelText: 'Jam Sewa'),
            ),
            TextField(
              controller: hariController,
              decoration: const InputDecoration(labelText: 'Hari'),
            ),
            TextField(
              controller: durasiController,
              decoration: const InputDecoration(labelText: 'Durasi'),
            ),
            TextField(
              controller: pembayaranController,
              decoration: const InputDecoration(labelText: 'Pembayaran'),
            ),
            TextField(
              controller: totalHargaController,
              decoration: const InputDecoration(labelText: 'Total Harga'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePesanan,
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
