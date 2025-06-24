import 'package:flutter/material.dart';
import 'package:silay_workshop/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: LoginPage(),
    );
  }
}
