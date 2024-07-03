import 'package:flutter/material.dart';

class InstrumenScreen extends StatefulWidget {
  const InstrumenScreen({super.key});

  @override
  State<InstrumenScreen> createState() => _InstrumenScreenState();
}

class _InstrumenScreenState extends State<InstrumenScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaInstrumenController = TextEditingController();
  final _jenisInstrumenController = TextEditingController();

  @override
  void dispose() {
    _namaInstrumenController.dispose();
    _jenisInstrumenController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Logic to save data
      // Example: You can use a service to save the data to a database

      // Show a snackbar or dialog to indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data instrumen berhasil ditambahkan'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the form
      _formKey.currentState!.reset();
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
          title: const Text('Tambah Instrumen'),
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
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 250, 250, 250),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text(
                      'Tambah Alat',
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
