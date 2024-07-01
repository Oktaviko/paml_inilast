import 'package:flutter/material.dart';
import 'package:paml_inilast/controller/price.dart';
import 'package:paml_inilast/models/alatmusik.dart';
import 'package:paml_inilast/screen/component/sewaalat/detailsewa.dart';
import 'package:paml_inilast/services/alatservice.dart';
import 'package:paml_inilast/widgets/mapscreen.dart';

class SewaScreen extends StatefulWidget {
  const SewaScreen({super.key});

  @override
  State<SewaScreen> createState() => _SewaScreenState();
}

class _SewaScreenState extends State<SewaScreen> {
  String? selectedValueAlat;
  String? selectedValueHari;
  String? selectedValueBayar;
  String? selectedValueAntar = 'Ambil ditempat';
  String? _alamat;
  int? totalPrice;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final Alatservice _alatService = Alatservice();

  void calculateTotalPrice() {
    setState(() {
      totalPrice = SewaPrices.getPrice(selectedValueAlat, selectedValueHari);
    });
  }

  Future<void> _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      String alamat = selectedValueAntar == 'Diantar'
          ? _alamat ?? ''
          : 'Studio Musik Sebelas';

      Alatmusik alatmusik = Alatmusik(
        nama: namaController.text,
        no_hp: noHpController.text,
        instrumen: selectedValueAlat ?? '',
        durasi: selectedValueHari ?? '',
        alamat: alamat,
        pembayaran: selectedValueBayar ?? '',
        total_harga: totalPrice?.toString() ?? '0', // Konversi ke string
        opsi: selectedValueAntar ?? '', // Tambahkan ini
      );

      print('Alatmusik to be created: ${alatmusik.toJson()}');

      Alatmusik? newAlatmusik = await _alatService.createAlat(alatmusik);
      if (newAlatmusik != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data berhasil disimpan'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailSewa()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan data'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
          title: const Text('Sewa Alat Musik'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Apa yang ingin kamu sewa?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Masukkan dan pilih data dengan benar",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: namaController,
                          decoration: InputDecoration(
                            labelText: "Nama Lengkap",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama lengkap tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: noHpController,
                          decoration: InputDecoration(
                            labelText: "No HP",
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'No HP tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Pilih Instrumen yang akan disewa"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.black, width: 2.0),
                            ),
                            child: DropdownButton<String?>(
                              value: selectedValueAlat,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: ["Gitar", "Bass", "Keyboard", "Ampli"]
                                  .map<DropdownMenuItem<String?>>(
                                    (e) => DropdownMenuItem(
                                      child: Text(e.toString()),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValueAlat = value;
                                  calculateTotalPrice();
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text("Berapa lama akan disewa"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.black, width: 2.0),
                            ),
                            child: DropdownButton<String?>(
                              value: selectedValueHari,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: ["1 Hari", "2 Hari", "3 Hari"]
                                  .map<DropdownMenuItem<String?>>(
                                    (e) => DropdownMenuItem(
                                      child: Text(e.toString()),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValueHari = value;
                                  calculateTotalPrice();
                                });
                              },
                            ),
                          ),
                        ),
                        const Text("Pilih opsi"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.black, width: 2.0),
                            ),
                            child: DropdownButton<String?>(
                              value: selectedValueAntar,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: ["Diantar", "Ambil ditempat"]
                                  .map<DropdownMenuItem<String?>>(
                                    (e) => DropdownMenuItem(
                                      child: Text(e.toString()),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValueAntar = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: selectedValueAntar == 'Diantar',
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Alamat"),
                                _alamat == null
                                    ? const SizedBox(
                                        width: double.infinity,
                                        child: Text('Alamat kosong'))
                                    : Text('$_alamat'),
                                _alamat == null
                                    ? TextButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MapScreen(
                                                onLocationSelected:
                                                    (selectedAddress) {
                                                  setState(() {
                                                    _alamat = selectedAddress;
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text('Pilih Alamat'),
                                      )
                                    : TextButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MapScreen(
                                                onLocationSelected:
                                                    (selectedAddress) {
                                                  setState(() {
                                                    _alamat = selectedAddress;
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                          setState(() {});
                                        },
                                        child: const Text('Ubah Alamat'),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
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
                              border:
                                  Border.all(color: Colors.black, width: 2.0),
                            ),
                            child: DropdownButton<String?>(
                              value: selectedValueBayar,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: [
                                "QRIS",
                                "CASH",
                              ]
                                  .map<DropdownMenuItem<String?>>(
                                    (e) => DropdownMenuItem(
                                      child: Text(e.toString()),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValueBayar = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Column(
                          children: [
                            const Text(
                                "Total harga akan ditampilkan dibawah ini "),
                            Text(
                              totalPrice != null ? "$totalPrice" : "",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: _submitBooking,
                              child: const Text(
                                "Lanjut",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
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
