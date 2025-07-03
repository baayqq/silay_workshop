import 'package:flutter/material.dart';
import 'package:silay_workshop/api/api_file.dart';
import 'package:silay_workshop/model/service_model.dart';
import 'package:silay_workshop/model/status.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  late Future<List<StatusService>> _statusList;
  late Future<List<ServiceData>> _serviceList;

  int completedCount = 0;
  int todayServiceCount = 0;
  int prosesCount = 0;

  String? _selectedStatus;
  String _searchKeyword = '';
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _fetchServiceList();
    _statusList = UserService().statusServ();
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

  String getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'menunggu':
        return 'Menunggu';
      case 'diproses':
        return 'Diproses';
      case 'selesai':
        return 'Selesai';
      default:
        return '-';
    }
  }

  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'menunggu':
        return Colors.grey;
      case 'diproses':
        return Colors.orange;
      case 'selesai':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  IconData getStatusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'menunggu':
        return Icons.hourglass_empty;
      case 'diproses':
        return Icons.build;
      case 'selesai':
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  Widget _buildStatusFilterButton(String label, String? value) {
    final isSelected = _selectedStatus == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected:
          (_) => setState(() => _selectedStatus = isSelected ? null : value),
      selectedColor: getStatusColor(value),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildStatCard(
              'Total\nservice Selesai',
              completedCount.toString(),
              const Color(0xff0D47A1),
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
              const Color(0xff0D47A1),
              Colors.white,
            ),
            const SizedBox(height: 28),

            // FILTER SECTION
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daftar Servis',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 12),
                TextField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Cari Booking',
                    labelStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  onChanged: (value) => setState(() => _searchKeyword = value),
                ),

                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  children: [
                    _buildStatusFilterButton('Menunggu', 'Menunggu'),
                    _buildStatusFilterButton('Diproses', 'Diproses'),
                    _buildStatusFilterButton('Selesai', 'Selesai'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Belum pilih tanggal'
                            : 'Tanggal: ${_selectedDate!.toLocal().toString().split(" ")[0]}',
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.date_range),
                      tooltip: 'Pilih Tanggal',
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (picked != null) {
                          setState(() => _selectedDate = picked);
                        }
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.restore),
                      tooltip: 'Reset semua filter',
                      onPressed: () {
                        setState(() {
                          _selectedStatus = null;
                          _selectedDate = null;
                          _searchKeyword = '';
                          _searchController.clear(); // ini yang penting
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

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
          final filtered =
              snapshot.data!.where((serv) {
                final created = serv.createdAt;
                final keyword = _searchKeyword.toLowerCase();
                final matchesKeyword =
                    serv.vehicleType?.toLowerCase().contains(keyword) == true ||
                    serv.complaint?.toLowerCase().contains(keyword) == true;

                final matchesStatus =
                    _selectedStatus == null ||
                    serv.status?.toLowerCase() ==
                        _selectedStatus!.toLowerCase();

                final matchesDate =
                    _selectedDate == null ||
                    (created != null &&
                        created.year == _selectedDate!.year &&
                        created.month == _selectedDate!.month &&
                        created.day == _selectedDate!.day);

                return matchesKeyword && matchesStatus && matchesDate;
              }).toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final serv = filtered[index];
              return Card(
                color:
                    serv.status == 'Selesai'
                        ? Colors.green[50]
                        : Colors.orange[50],
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: Icon(
                    getStatusIcon(serv.status),
                    color: getStatusColor(serv.status),
                    size: 30,
                  ),
                  title: Text(serv.vehicleType ?? 'Jenis tidak diketahui'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Deskripsi: ${serv.complaint ?? "-"}'),
                      Text(
                        'Tanggal Input: ${serv.createdAt != null ? DateFormat("dd MMMM yyyy HH:mm", "id_ID").format(serv.createdAt!.toLocal()) : "-"}',
                      ),
                      Text(
                        'Status: ${getStatusText(serv.status)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: getStatusColor(serv.status),
                        ),
                      ),
                      Text(
                        'Update: ${serv.updatedAt != null ? DateFormat("dd MMMM yyyy HH:mm", "id_ID").format(serv.updatedAt!.toLocal()) : "-"}',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
