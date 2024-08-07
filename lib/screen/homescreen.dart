import 'package:flutter/material.dart';
import 'package:paml_inilast/services/authservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final AuthService _authService = AuthService();

  void _logout() async {
    //await _authService.logout();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
          centerTitle: true,
          title: Text('Beranda'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Apa yang kamu butuhkan?",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage("assets/icons/studio.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/studio');
                        },
                      ),
                      Text(
                        "Booking Studio",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage("assets/icons/guitar.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/sewa');
                        },
                      ),
                      Text(
                        "Sewa Alat Musik",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  GestureDetector(
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("assets/icons/recording.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/record');
                    },
                  ),
                  Text(
                    "Recording",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('Profil'),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                title: Text('Jadwal'),
                leading: Icon(Icons.schedule),
                onTap: () {
                  Navigator.pushNamed(context, '/jadwal');
                },
              ),
              ListTile(
                title: Text('Pesanan'),
                leading: Icon(Icons.note),
                onTap: () {
                  Navigator.pushNamed(context, '/pesanan');
                },
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.logout),
                onTap: _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
