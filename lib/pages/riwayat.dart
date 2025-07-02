import 'package:flutter/material.dart';
import 'package:silay_workshop/api/api_file.dart';
import 'package:silay_workshop/model/riwayat_model.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  late Future<List<HistoryModel>> _historyList;

  @override
  void initState() {
    super.initState();
    _fetchRiwayat();
  }

  void _fetchRiwayat() {
    setState(() {
      _historyList = UserService().historyServ();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Riwayat Servis',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 24,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: const Color(0xff0D47A1),
      //   iconTheme: const IconThemeData(color: Colors.white),
      // ),
      body: FutureBuilder<List<HistoryModel>>(
        future: _historyList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada riwayat servis."));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  elevation: 4,
                  color: Colors.green[50],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      item.vehicleType ?? 'Kendaraan tidak diketahui',
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Keluhan: ${item.complaint ?? "-"}"),
                        Text(
                          "Status: ${item.status ?? "-"}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Tanggal Input: ${item.createdAt != null ? item.createdAt!.toLocal().toString().split(".")[0] : "-"}',
                        ),
                        Text(
                          'Selesai: ${item.updatedAt != null ? item.updatedAt!.toLocal().toString().split(".")[0] : "-"}',
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.green,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
