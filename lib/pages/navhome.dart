import 'package:flutter/material.dart';
import 'package:silay_workshop/auth/login.dart';
import 'package:silay_workshop/database/sharedprefence.dart';
import 'package:silay_workshop/pages/addservice.dart';
import 'package:silay_workshop/pages/home.dart';
import 'package:silay_workshop/pages/profile.dart';
import 'package:silay_workshop/pages/riwayat.dart';
import 'package:silay_workshop/pages/service.dart';

class HomeBottom extends StatefulWidget {
  const HomeBottom({super.key});

  @override
  State<HomeBottom> createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom> {
  int _pilihIndex = 0;

  static final List<Widget> _butonNavigator = <Widget>[
    HomeScreen(),
    AddService(),
    RiwayatPage(),
  ];

  static final List<String> _appBarTitles = [
    'Dashboard',
    'Booking',
    'Riwayat Servis',
  ];

  void _pilihNavigator(int index) {
    setState(() {
      _pilihIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F1F5),
      appBar: AppBar(
        title: Text(
          _appBarTitles[_pilihIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff0D47A1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        elevation: 4,
        backgroundColor: Color(0xff0D47A1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset('assets/images/logo.png', width: 200),
              SizedBox(height: 20),
              // Text(
              //   "Bayu",
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              // ),
              SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.home_filled, color: Colors.white),
                title: Text('Home', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeBottom()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.manage_accounts, color: Colors.white),
                title: Text('Profile', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                ),
                title: Text('Admin', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ServicePage()),
                  );
                },
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                title: Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('berhasil keluar'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  await SharedPrefService.removeToken();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _butonNavigator[_pilihIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        ],
        backgroundColor: Color(0xff0D47A1),
        currentIndex: _pilihIndex,
        selectedItemColor: Colors.yellow[600],
        unselectedItemColor: Colors.white70,
        onTap: _pilihNavigator,
      ),
    );
  }
}
