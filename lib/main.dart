import 'package:flutter/material.dart';
import 'package:silay_workshop/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silay_workshop/database/sharedprefence.dart';
import 'package:silay_workshop/pages/navhome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? _home;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final isLoggedIn = await SharedPrefService.hasToken();
    setState(() {
      _home = isLoggedIn ? HomeBottom() : LoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Silay WorkShop',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          // bodyColor: Colors.white, // warna teks utama
          displayColor: Colors.white, // warna untuk judul/header
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: _home ?? Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
