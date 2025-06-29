import 'package:flutter/material.dart';
import 'package:silay_workshop/api/api_file.dart';
import 'package:silay_workshop/model/service_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int completedCount = 0;
  int todayServiceCount = 0;
  int prosesCount = 0;
  late Future<List<ServiceData>> _serviceList;

  @override
  void initState() {
    super.initState();
    _fetchServiceList();
  }

  void _fetchServiceList() {
    _serviceList = UserService().cstServiceWithServiceData().then((data) {
      final now = DateTime.now();
      int proses = 0;
      int today = 0;
      int selesai = 0;

      for (var serv in data) {
        if (serv.status == 'Diproses') proses++;
        if (serv.status == 'Selesai') selesai++;
        if (serv.createdAt != null &&
            serv.createdAt!.year == now.year &&
            serv.createdAt!.month == now.month &&
            serv.createdAt!.day == now.day) {
          today++;
        }
      }

      setState(() {
        prosesCount = proses;
        todayServiceCount = today;
        completedCount = selesai;
      });

      return data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // _buildIntroSection(),
            // const SizedBox(height: 30),
            _buildStatCard(
              'Total\nservice Selesai',
              completedCount.toString(),
              Color(0xff0D47A1),
              Colors.white,
            ),
            const SizedBox(height: 16),
            _buildStatCard(
              'Servis\nHari ini',
              todayServiceCount.toString(),
              Colors.yellow[600]!,
              Colors.black,
            ),
            const SizedBox(height: 16),
            _buildStatCard(
              'Kendaraan\nDalam proses',
              prosesCount.toString(),
              Color(0xff0D47A1),
              Colors.white,
            ),
            const SizedBox(height: 28),
            _buildServiceList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.yellow[600],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Silay Workshop',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            '''Kenapa sih kita harus melakukan perawatan juga untuk kendaraan kita?     
Kendaraan perlu dirawat secara rutin untuk menjaga performa mesin, mencegah kerusakan serius, dan memastikan keselamatan saat berkendara.

Aplikasi Silay Workshop hadir untuk memudahkan perawatan kendaraanmu, mulai dari booking servis tanpa antre, cek riwayat dan jadwal perawatan, hingga pengingat otomatis untuk servis berkala.

Semua kebutuhan bengkel kini ada dalam genggamanmu praktis, cepat, dan terpercaya.''',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceList() {
    return FutureBuilder<List<ServiceData>>(
      future: _serviceList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: \${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada data servis.'));
        } else {
          final services = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Daftar Pelanggan',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 0),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final serv = services[index];
                  return Card(
                    color: Color(0xf1ffffff),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: const Icon(Icons.build),
                      title: Text(serv.vehicleType ?? 'Jenis tidak diketahui'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('Deskripsi: ${serv.complaint ?? "-"}'),
                          Text(
                            'Tanggal Input: ${serv.createdAt != null ? serv.createdAt!.toLocal().toString().split(".")[0] : "-"}',
                          ),
                          Text('Status: ${serv.status ?? "-"}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
