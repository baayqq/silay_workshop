import 'package:flutter/material.dart';

class ServPage extends StatefulWidget {
  const ServPage({super.key});

  @override
  State<ServPage> createState() => _ServPageState();
}

class _ServPageState extends State<ServPage> {
  //   await userService.addService(
  //   bookingDate: "2025-06-25",
  //   vehicleType: "Motor",
  //   description: "Servis rutin & ganti oli",
  // );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xff0D47A1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.add, color: Colors.white, size: 32),

                Text(
                  'Tambah Pelanggan',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
