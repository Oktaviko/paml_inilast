import 'package:flutter/material.dart';
import 'package:paml_inilast/models/recording.dart';
import 'package:paml_inilast/services/recordingservice.dart';

class EditRecording extends StatefulWidget {
  final Recording recording;
  const EditRecording({super.key, required this.recording});

  @override
  State<EditRecording> createState() => _EditRecordingState();
}

class _EditRecordingState extends State<EditRecording> {
  late TextEditingController namaBandController;
  late TextEditingController jamSewaController;
  late TextEditingController hariController;
  late TextEditingController durasiController;
  late TextEditingController pembayaranController;
  late TextEditingController totalHargaController;

  final RecordingService _recordingService = RecordingService();

  @override
  void initState() {
    super.initState();
    namaBandController = TextEditingController(text: widget.recording.nama_band);
    jamSewaController = TextEditingController(text: widget.recording.jam_sewa);
    hariController = TextEditingController(text: widget.recording.hari);
    durasiController = TextEditingController(text: widget.recording.durasi);
    pembayaranController = TextEditingController(text: widget.recording.pembayaran);
    totalHargaController = TextEditingController(text: widget.recording.total_harga);
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
    Recording updatedRecording = Recording(
      id: widget.recording.id, // Pastikan ID disertakan
      nama_band: namaBandController.text,
      jam_sewa: jamSewaController.text,
      hari: hariController.text,
      durasi: durasiController.text,
      pembayaran: pembayaranController.text,
      total_harga: totalHargaController.text,
    );

    bool success = await _recordingService.updateRecording(updatedRecording, updatedRecording.id!);

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
        title: const Text('Edit Pesanan Recording'),
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
