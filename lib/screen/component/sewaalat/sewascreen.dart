import 'package:flutter/material.dart';
import 'package:paml_inilast/controller/price.dart';
import 'package:paml_inilast/screen/component/sewaalat/detailsewa.dart';
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

  void calculateTotalPrice() {
    setState(() {
      totalPrice = SewaPrices.getPrice(selectedValueAlat, selectedValueHari);
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
          title: Text('Sewa Alat Musik'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Apa yang ingin kamu sewa?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Masukkan dan pilih data dengan benar",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Nama Lengkap",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "No HP",
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Pilih Instrumen yang akan disewa"),
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
                                underline: SizedBox(),
                                items: ["Gitar", "Bass", "Keyboard", "Ampli"]
                                    .map<DropdownMenuItem<String?>>(
                                        (e) => DropdownMenuItem(
                                              child: Text(e.toString()),
                                              value: e,
                                            ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValueAlat = value;
                                    calculateTotalPrice();
                                  });
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("Berapa lama akan disewa"),
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
                                underline: SizedBox(),
                                items: ["1 Hari", "2 Hari", "3 Hari"]
                                    .map<DropdownMenuItem<String?>>(
                                        (e) => DropdownMenuItem(
                                              child: Text(e.toString()),
                                              value: e,
                                            ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValueHari = value;
                                    calculateTotalPrice();
                                  });
                                }),
                          ),
                        ),
                        Text("Pilih opsi"),
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
                                underline: SizedBox(),
                                items: ["Diantar", "Ambil ditempat"]
                                    .map<DropdownMenuItem<String?>>(
                                        (e) => DropdownMenuItem(
                                              child: Text(e.toString()),
                                              value: e,
                                            ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValueAntar = value;
                                  });
                                }),
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
                                              }),
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
                                              }),
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
                        Text("Pilih opsi pembayaran"),
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
                                underline: SizedBox(),
                                items: ["BRI", "BNI", "Mandiri", "BCA"]
                                    .map<DropdownMenuItem<String?>>(
                                        (e) => DropdownMenuItem(
                                              child: Text(e.toString()),
                                              value: e,
                                            ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValueBayar = value;
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Column(
                          children: [
                            Text("Total harga akan ditampilkan dibawah ini "),
                            Text(
                              totalPrice != null ? "Rp $totalPrice" : "",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ElevatedButton(
                            //   onPressed: calculateTotalPrice,
                            //   child: Text(
                            //     "Hitung Total Harga",
                            //     style:
                            //         TextStyle(fontSize: 16, color: Colors.black),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailSewa()));
                              },
                              child: Text(
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
