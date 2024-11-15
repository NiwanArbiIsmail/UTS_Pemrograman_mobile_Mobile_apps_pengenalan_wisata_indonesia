import 'package:flutter/material.dart';
import '../models/wisata.dart';

class DetailScreen extends StatelessWidget {
  final Wisata wisata;

  const DetailScreen({Key? key, required this.wisata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wisata.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(wisata.imagePath),
            const SizedBox(height: 16),
            Text(
              wisata.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(wisata.description),
          ],
        ),
      ),
    );
  }
}
