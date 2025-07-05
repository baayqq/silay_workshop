import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('username') ?? 'Pengguna';
    final userEmail = prefs.getString('email') ?? 'email@tidakdiketahui.com';

    setState(() {
      username = name;
      email = userEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        centerTitle: true,
        backgroundColor: const Color(0xff0D47A1),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0D47A1), Color(0xff1976D2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 60, color: Color(0xff0D47A1)),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 450,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                    Text(
                      email,
                      // style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Lakukan 10 kali servis dan tukarkan hadiah spesial dari merchant kami! Semakin sering Anda servis, semakin besar peluang mendapatkan berbagai hadiah menarik. Jangan lewatkan kesempatan emas ini loyalitas Anda kami hargai dengan kejutan istimewa yang telah kami siapkan khusus untuk pelanggan setia seperti Anda!',
                    ),
                    SizedBox(height: 20),
                    const Icon(
                      Icons.info_outline,
                      size: 30,
                      color: Color(0xff0D47A1),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Si Bengkel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0D47A1),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Version 1.0.0 - Beta',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
