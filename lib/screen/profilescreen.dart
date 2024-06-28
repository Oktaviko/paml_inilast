import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showEditForm = false;
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      height: 115,
                      width: 115,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/icons/profile.png'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        const Text(
                          "Hallo Oktaviko Rizki P !",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _showEditForm = !_showEditForm;
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                              label: const Text(
                                "Edit profile",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                              label: const Text(
                                "Kembali",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                _showEditForm
                    ? Form(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Masukkan Data Diri Anda",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Nama Lengkap",
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "NIK KTP",
                                prefixIcon:
                                    const Icon(Icons.account_balance_wallet),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Alamat",
                                prefixIcon: const Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "No HP",
                                prefixIcon: const Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              obscureText:
                                  true, // Sembunyikan karakter password
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                              label: const Text(
                                "Simpan",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
