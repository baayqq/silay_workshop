import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final PageController _pageController = PageController();

  // final List<String> gambarList = [
  //   'https://c.inilah.com/reborn/2024/09/large_Profil_Timothy_Ronald_Salah_Satu_Investor_Saham_dan_Crypto_Sukses_di_Indonesia_11zon_29bc8826ba.jpg',
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA2YwS0fDR1cudbNq8X3m1P0gDQF09CBs3ew&s',
  //   'https://i.ytimg.com/vi/KlurwqV9sCk/sddefault.jpg',
  // ];

  // int _currentPage = 0;
  // Timer? _timer;

  // @override
  // void initState() {
  //   super.initState();

  //   _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
  //     if (_currentPage < gambarList.length - 1) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }

  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   });
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 140,
            //   child: PageView.builder(
            //     controller: _pageController,
            //     itemCount: gambarList.length,
            //     itemBuilder: (context, index) {
            //       return ClipRRect(
            //         borderRadius: BorderRadius.circular(16),
            //         child: Image.network(
            //           gambarList[index],
            //           fit: BoxFit.cover,
            //           width: double.infinity,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xff0D47A1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total\nPelanggan',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '120',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Servis\nHari ini',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '8',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xff0D47A1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Motor\nDalam proses',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '4',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // SizedBox(
            //   height: 200,
            //   child: PageView.builder(
            //     controller: _pageController,
            //     itemCount: gambarList.length,
            //     itemBuilder: (context, index) {
            //       return ClipRRect(
            //         borderRadius: BorderRadius.circular(16),
            //         child: Image.network(
            //           gambarList[index],
            //           fit: BoxFit.cover,
            //           width: double.infinity,
            //         ),
            //       );
            //     },
            //   ),
            // ),

            // SizedBox(height: 20),
            Text(
              'Silay Workshop',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '''
Kenapa sih kita harus melakukan perawatan juga untuk kendaraan kita?     
Kendaraan perlu dirawat secara rutin untuk menjaga performa mesin, mencegah kerusakan serius, dan memastikan keselamatan saat berkendara.
            
Aplikasi SILAY Workshop hadir untuk memudahkan perawatan kendaraanmu, mulai dari booking servis tanpa antre, cek riwayat dan jadwal perawatan, hingga pengingat otomatis untuk servis berkala.
            
Semua kebutuhan bengkel kini ada dalam genggamanmu praktis, cepat, dan terpercaya.
            ''',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),

            SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
