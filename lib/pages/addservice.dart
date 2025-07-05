import 'package:flutter/material.dart';
import 'package:si_bengkel/api/api_file.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  DateTime? selectedDate;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController waktuController = TextEditingController();
  final TextEditingController kendaraanController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final UserService userService = UserService();
  final formKey = GlobalKey<FormState>();
  void kirimService() async {
    if (formKey.currentState!.validate()) {
      try {
        final result = await userService.addService(
          // bookingDate: waktuController.text,
          vehicleType: kendaraanController.text,
          complaint: deskripsiController.text,
        );

        if (result.containsKey('message')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Berhasil: ${result['message']}')),
          );

          // Kosongkan input setelah submit
          namaController.clear();
          waktuController.clear();
          kendaraanController.clear();
          deskripsiController.clear();
          setState(() => selectedDate = null);
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal booking: $e')));
      }
    }
  }

  // Future<void> handleAddService() async {
  //   if (formKey.currentState!.validate()) {
  //     try {
  //       final response = await userService.addService(
  //         bookingDate: waktuController.text,
  //         vehicleType: kendaraanController.text,
  //         complaint: deskripsiController.text,
  //       );
  //       if (response.containsKey('message')) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Berhasil ${response['message']}')),
  //         );
  //         namaController.clear();
  //         waktuController.clear();
  //         kendaraanController.clear();
  //         deskripsiController.clear();
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('Gagal booking: $e')));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            Text(
              'Silahkan Booking\nuntuk melakukan pemesanan',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            // SizedBox(height: 8),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  // TextFormField(
                  //   controller: namaController,
                  //   decoration: InputDecoration(
                  //     hintText: "Nama",
                  //     hintStyle: TextStyle(color: Color(0xff333333)),
                  //     prefixIcon: Icon(Icons.account_box_sharp),
                  //     filled: true,
                  //     fillColor: Color(0xffffffff),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'nama wajib di isi';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(height: 16),
                  // GestureDetector(
                  //   onTap: () async {
                  //     final DateTime? picked = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime.now(),
                  //       lastDate: DateTime(2100),
                  //     );
                  //     if (picked != null) {
                  //       setState(() {
                  //         selectedDate = picked;
                  //         waktuController.text = DateFormat(
                  //           'yyyy-MM-dd',
                  //         ).format(picked);
                  //       });
                  //     }
                  //   },
                  //   child: AbsorbPointer(
                  //     child: TextFormField(
                  //       controller: waktuController,
                  //       decoration: InputDecoration(
                  //         hintText: "Tanggal Booking",
                  //         hintStyle: TextStyle(color: Color(0xff333333)),
                  //         prefixIcon: Icon(Icons.date_range),
                  //         filled: true,
                  //         fillColor: Color(0xffffffff),
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(12),
                  //           borderSide: BorderSide.none,
                  //         ),
                  //       ),
                  //       validator: (value) {
                  //         if (value == null || value.isEmpty) {
                  //           return 'Wajib diisi';
                  //         }
                  //         return null;
                  //       },
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: kendaraanController,
                    decoration: InputDecoration(
                      hintText: "Jenis Kendaraan",
                      hintStyle: TextStyle(color: Color(0xff333333)),
                      prefixIcon: Icon(Icons.car_rental),
                      filled: true,
                      fillColor: Color(0xffffffff),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'wajib di isi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: deskripsiController,
                    decoration: InputDecoration(
                      hintText: "Deskripsi",
                      hintStyle: TextStyle(color: Color(0xff333333)),
                      prefixIcon: Icon(Icons.description),
                      filled: true,
                      fillColor: Color(0xffffffff),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'wajib di isi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    // height: 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.yellow[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print('Berhasil');
                          kirimService();
                        }
                      },
                      child: Text(
                        'Tambah',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
