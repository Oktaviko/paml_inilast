import 'package:flutter/material.dart';
import 'package:paml_inilast/controller/price.dart';
import 'package:paml_inilast/screen/component/studio/detailstudio.dart';
import 'package:paml_inilast/models/studio.dart';
import 'package:paml_inilast/services/studioservice.dart';

class StudioScreen extends StatefulWidget {
  const StudioScreen({super.key});

  @override
  State<StudioScreen> createState() => _StudioScreenState();
}

class _StudioScreenState extends State<StudioScreen> {
  String? selectedBookingHari;
  String? selectedBookingDurasi;
  String? selectedBayarBoking;
  double totalPrice = 0.0;
  TimeOfDay? _selectedTime;

  final TextEditingController _namaBandController = TextEditingController();
  final StudioService _studioService = StudioService();

  void updateTotalPrice(String? duration) {
    setState(() {
      totalPrice = StudioPrice.calculateTotalPrice(duration);
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submitBooking() async {
    if (_namaBandController.text.isEmpty ||
        _selectedTime == null ||
        selectedBookingHari == null ||
        selectedBookingDurasi == null ||
        selectedBayarBoking == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua bidang')),
      );
      return;
    }

    Studio studio = Studio(
      nama_band: _namaBandController.text,
      jam_sewa: _selectedTime!.format(context),
      hari: selectedBookingHari!,
      durasi: selectedBookingDurasi!,
      pembayaran: selectedBayarBoking!,
      total_harga: totalPrice.toString(),
    );

    print('Studio to be created: ${studio.toJson()}');

    Studio? newStudio = await _studioService.createStudio(studio);
    if (newStudio != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailStudio()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuat booking studio')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.green,
            Colors.yellow,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          centerTitle: true,
          title: const Text('Booking Sewa Studio'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Masukkan data dengan benar",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _namaBandController,
                      decoration: InputDecoration(
                        labelText: "Nama Band",
                        prefixIcon: const Icon(Icons.person_pin),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Pilih jadwal main",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => _selectTime(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Isi dengan jam yang diinginkan",
                          prefixIcon: const Icon(Icons.timelapse),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          _selectedTime != null
                              ? _selectedTime!.format(context)
                              : 'Pilih Waktu',
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedTime != null
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Pilih Hari",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: DropdownButton<String?>(
                          value: selectedBookingHari,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: [
                            "Senin",
                            "Selasa",
                            "Rabu",
                            "Kamis",
                            "Jumat",
                            "Sabtu",
                            "Minggu"
                          ]
                              .map<DropdownMenuItem<String?>>(
                                  (e) => DropdownMenuItem(
                                        child: Text(e.toString()),
                                        value: e,
                                      ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedBookingHari = value;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Lama main",
                    style: TextStyle(fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: DropdownButton<String?>(
                          value: selectedBookingDurasi,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: [
                            "1 jam",
                            "2 jam",
                            "3 jam",
                          ]
                              .map<DropdownMenuItem<String?>>(
                                  (e) => DropdownMenuItem(
                                        child: Text(e.toString()),
                                        value: e,
                                      ))
                              .toList(),
                          onChanged: (value) {
                            updateTotalPrice(value);
                            setState(() {
                              selectedBookingDurasi = value;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Pilih opsi pembayaran"),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: DropdownButton<String?>(
                          value: selectedBayarBoking,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: ["QRIS", "CASH"]
                              .map<DropdownMenuItem<String?>>(
                                  (e) => DropdownMenuItem(
                                        child: Text(e.toString()),
                                        value: e,
                                      ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedBayarBoking = value;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Total harga akan ditampilkan dibawah ini "),
                  Text(
                    totalPrice > 0 ? " $totalPrice" : "",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _submitBooking,
                    child: const Text(
                      "Lanjut",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
