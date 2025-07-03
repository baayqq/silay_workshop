import 'package:flutter/material.dart';
import 'package:silay_workshop/api/api_file.dart';
import 'package:silay_workshop/model/riwayat_model.dart';
import 'package:intl/intl.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<HistoryModel>> _historyList;

  String _searchKeyword = '';
  String? _selectedStatus;
  DateTime? _selectedDate;

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search field
            Row(
              children: [
                Expanded(
                  child: TextField(
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
                    onChanged:
                        (value) => setState(() => _searchKeyword = value),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.date_range),
                  tooltip: 'Pilih Tanggal',
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.restore),
                  tooltip: 'Reset filter',
                  onPressed: () {
                    setState(() {
                      _searchKeyword = '';
                      _selectedStatus = null;
                      _selectedDate = null;
                      _searchController.clear();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Status Filter

            // List
            Expanded(
              child: FutureBuilder<List<HistoryModel>>(
                future: _historyList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("Tidak ada riwayat servis."),
                    );
                  } else {
                    final filtered =
                        snapshot.data!.where((item) {
                          final created = item.createdAt;
                          final keyword = _searchKeyword.toLowerCase();
                          final matchesKeyword =
                              item.vehicleType?.toLowerCase().contains(
                                    keyword,
                                  ) ==
                                  true ||
                              item.complaint?.toLowerCase().contains(keyword) ==
                                  true;

                          final matchesStatus =
                              _selectedStatus == null ||
                              item.status?.toLowerCase() ==
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
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(
                              item.vehicleType ?? 'Jenis tidak diketahui',
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Keluhan: ${item.complaint ?? "-"}"),
                                Text(
                                  'Tanggal Input: ${item.createdAt != null ? DateFormat("dd MMMM yyyy HH:mm", "id_ID").format(item.createdAt!.toLocal()) : "-"}',
                                ),
                                Text(
                                  'Status: ${item.status ?? "-"}',
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    // color: getStatusColor(item.status),
                                  ),
                                ),
                                Text(
                                  'Update: ${item.updatedAt != null ? DateFormat("dd MMMM yyyy HH:mm", "id_ID").format(item.updatedAt!.toLocal()) : "-"}',
                                ),
                              ],
                            ),
                            trailing: Icon(
                              getStatusIcon(item.status),
                              color: getStatusColor(item.status),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
