import 'package:flutter/material.dart';
import 'package:paml_inilast/screen/admin/components/instrumen/instrumenscreen.dart';
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
    return Scaffold(
      appBar: AppBar(
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
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Tambah data instrumen'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: ListTile(
                    leading: Icon(Icons.add),
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
    );
  }
}
