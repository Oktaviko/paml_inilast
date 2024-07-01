import 'package:flutter/material.dart';
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
