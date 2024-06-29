import 'package:flutter/material.dart';
import 'package:paml_inilast/controller/price.dart';
import 'package:paml_inilast/screen/component/recording/detailsrecord.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  String? selectedRecordingHari;
  String? selectedRecordDurasi;
  String? selectedBayarRecord;
  double totalPrice = 0.0;

  void updateTotalPrice(String? duration) {
    setState(() {
      totalPrice = RecordingPrice.calculateTotalPrice(duration);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          centerTitle: true,
          title: Text('Recording Musik Studio'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Isi dengan jam yang diinginkan",
                        prefixIcon: const Icon(Icons.timelapse),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
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
                          value: selectedRecordingHari,
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
                              selectedRecordingHari = value;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Lama record",
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
                          value: selectedRecordDurasi,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: [
                            "1 jam",
                            "2 jam",
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
                              selectedRecordDurasi = value;
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
                          value: selectedBayarRecord,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: ["BRI", "BNI", "Mandiri", "BCA"]
                              .map<DropdownMenuItem<String?>>(
                                  (e) => DropdownMenuItem(
                                        child: Text(e.toString()),
                                        value: e,
                                      ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedBayarRecord = value;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Total harga akan ditampilkan dibawah ini "),
                  Text(
                    totalPrice > 0 ? "Rp $totalPrice" : "",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DetailRecord()));
                    },
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
