import 'package:flutter/material.dart';

class InformasiScreen extends StatelessWidget {
  const InformasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar bagian atas aplikasi
      appBar: AppBar(
        title: const Text(
          'Informasi Aplikasi',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white), // warna ikon kembali
      ),

      // Isi konten informasi
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // Judul aplikasi
            Text(
              'Aplikasi Polibanku',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            // Deskripsi aplikasi
            Text(
              'Aplikasi polibanku ini dibuat untuk pendataan mahasiswa poliban. '
              'Admin nantinya bisa menambahkan, update dan, delete data data mahasiswa poliban.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
