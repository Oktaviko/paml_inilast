import 'package:flutter/material.dart';
import 'package:paml_inilast/screen/auth/loginadmin.dart';
import 'package:paml_inilast/screen/auth/loginscreen.dart';
import 'package:paml_inilast/screen/auth/registerscreen.dart';
import 'package:paml_inilast/screen/component/recording/recordingscreen.dart';
import 'package:paml_inilast/screen/component/sewaalat/sewascreen.dart';
import 'package:paml_inilast/screen/component/studio/studioscreen.dart';
import 'package:paml_inilast/screen/homescreen.dart';
import 'package:paml_inilast/screen/jadwalscreen.dart';
import 'package:paml_inilast/screen/pesananscreen.dart';
import 'package:paml_inilast/screen/profilescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Studio Sebelas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/adminlog': (context) => const LoginAdmin(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/pesanan': (context) => const PesananScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/studio': (context) => const StudioScreen(),
        '/sewa': (context) => const SewaScreen(),
        '/record': (context) => const RecordingScreen(),
        '/jadwal': (context) => const JadwalScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
