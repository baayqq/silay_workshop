import 'package:flutter/material.dart';
import 'package:si_bengkel/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_bengkel/database/sharedprefence.dart';
import 'package:si_bengkel/pages/navhome.dart';
import 'package:intl/date_symbol_data_local.dart'; // import tambahan untuk lokal tanggal

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
    'id_ID',
    null,
  ); // inisialisasi format tanggal Indonesia
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
      _home = isLoggedIn ? const HomeBottom() : const LoginPage();
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
          displayColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home:
          _home ??
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
