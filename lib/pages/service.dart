import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 12),
          FutureBuilder<DataProfile>(
                future: userService.profileUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Terjadi Kesalahan: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('Tidak ada data profile'));
                  }

                  final profile = snapshot.data!;
                  return Padding(
                    
                  );
                },
              ),
        ],
      ),
    );
  }
}
