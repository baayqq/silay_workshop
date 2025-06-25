import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '120',
                    style: TextStyle(
                      fontSize: 24,
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '8',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    'Kendaraan\nDalam proses',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '4',
                    style: TextStyle(
                      fontSize: 24,
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
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Silay Workshop',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '''
Kenapa sih kita harus melakukan perawatan juga untuk kendaraan kita?     
Kendaraan perlu dirawat secara rutin untuk menjaga performa mesin, mencegah kerusakan serius, dan memastikan keselamatan saat berkendara.
            
Aplikasi Silay Workshop hadir untuk memudahkan perawatan kendaraanmu, mulai dari booking servis tanpa antre, cek riwayat dan jadwal perawatan, hingga pengingat otomatis untuk servis berkala.
            
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
