import 'package:flutter/material.dart';
import 'package:silay_workshop/api/api_file.dart';
import 'package:silay_workshop/model/service_model.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  late Future<List<ServiceData>> _serviceList;

  @override
  void initState() {
    super.initState();
    _fetchServiceList();
  }

  void _fetchServiceList() {
    setState(() {
      _serviceList = UserService().cstServiceWithServiceData();
    });
  }

  void _showUpdateStatusDialog(BuildContext context, int id) {
    String selectedStatus = 'Menunggu';
    final List<String> statusOptions = ['Menunggu', 'Diproses', 'Selesai'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status Servis'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButtonFormField<String>(
                value: selectedStatus,
                items:
                    statusOptions.map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Pilih Status',
                  border: OutlineInputBorder(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                // 1. Simpan status dulu, jangan pop dulu
                await UserService().updateStatusService(
                  id: id,
                  status: selectedStatus,
                );

                // 2. Cek apakah masih mounted
                if (!mounted) return;

                // 3. Pop layar
                Navigator.pop(context);

                // 4. Tampilkan snackbar dan refresh list
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Status berhasil diupdate!')),
                );
                _fetchServiceList();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showEditForm(ServiceData service) {
    final vehicleController = TextEditingController(text: service.vehicleType);
    final complaintController = TextEditingController(text: service.complaint);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Edit Layanan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: vehicleController,
                decoration: const InputDecoration(labelText: 'Jenis Kendaraan'),
              ),
              TextField(
                controller: complaintController,
                decoration: const InputDecoration(labelText: 'Keluhan'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await UserService().updateService(
                    id: service.id!,
                    vehicleType: vehicleController.text,
                    complaint: complaintController.text,
                  );
                  if (!mounted) return;
                  Navigator.pop(context);
                  _fetchServiceList();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data berhasil diperbarui')),
                  );
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _fetchServiceList(),
        child: FutureBuilder<List<ServiceData>>(
          future: _serviceList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada data servis.'));
            } else {
              final services = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final serv = services[index];
                  return Card(
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
                          Text('Status: ${serv.status ?? "Belum ditentukan"}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: const Text("Konfirmasi"),
                                      content: const Text(
                                        "Yakin hapus servis ini?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () =>
                                                  Navigator.pop(context, false),
                                          child: const Text("Batal"),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () =>
                                                  Navigator.pop(context, true),
                                          child: const Text(
                                            "Hapus",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                              );
                              if (confirm == true) {
                                final success = await UserService()
                                    .deleteService(serv.id!);
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ? 'Servis berhasil dihapus'
                                          : 'Gagal menghapus servis',
                                    ),
                                  ),
                                );
                                _fetchServiceList();
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed:
                                () =>
                                    _showUpdateStatusDialog(context, serv.id!),
                          ),
                        ],
                      ),
                      onTap: () => _showEditForm(serv),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
