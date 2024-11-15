import 'package:flutter/material.dart';
import '../data/wisata_data.dart';
import '../models/wisata.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Wisata Indonesia'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: wisataList.length,
          itemBuilder: (context, index) {
            final Wisata wisata = wisataList[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                leading: Image.asset(
                  wisata.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(wisata.name),
                subtitle: Text(wisata.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(wisata: wisata),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
