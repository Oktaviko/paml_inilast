import 'package:flutter/material.dart';
import 'package:paml_inilast/screen/admin/components/instrumen/instrumenscreen.dart';
import 'package:paml_inilast/screen/admin/components/instrumen/listinstrumen.dart';
import 'package:paml_inilast/screen/admin/components/listalat.dart';
import 'package:paml_inilast/screen/admin/components/listrecording.dart';
import 'package:paml_inilast/screen/admin/components/liststudio.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const ListStudio(),
    const ListAlat(),
    const ListRecording(),
  ];

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
          centerTitle: true,
          title: const Text('Daftar Pesanan'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Tambah data instrumen') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InstrumenScreen(),
                    ),
                  );
                } else if (value == 'Lihat Instrumen') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListInstrumen(),
                    ),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Tambah data instrumen', 'Lihat Instrumen'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: ListTile(
                      leading: choice == 'Tambah data instrumen'
                          ? Icon(Icons.add)
                          : Icon(Icons.list),
                      title: Text(choice),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Color.fromARGB(255, 250, 255, 251),
          selectedItemColor: const Color.fromARGB(255, 19, 19, 19),
          unselectedItemColor: Color.fromARGB(255, 226, 105, 25),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Studio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Alat Musik',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mic),
              label: 'Recording',
            ),
          ],
        ),
      ),
    );
  }
}
