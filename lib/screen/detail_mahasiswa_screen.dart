import 'package:flutter/material.dart';
import '../model/mahasiswa.dart';

/// Halaman untuk menampilkan detail data dari satu mahasiswa (mode baca-saja)
class DetailMahasiswaScreen extends StatelessWidget {
  final Mahasiswa mahasiswa; // Data mahasiswa yang akan ditampilkan

  const DetailMahasiswaScreen({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Data Mahasiswa', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white), // warna ikon kembali
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Tambahkan di atas field Nama
TextField(
  controller: TextEditingController(text: mahasiswa.id.toString()),
  decoration: InputDecoration(
    labelText: 'Nomor',
    hintText: 'Masukkan Nomor ID',
    prefixIcon: const Icon(Icons.numbers),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
  enabled: false, // readonly
),
const SizedBox(height: 18),


            const SizedBox(height: 18),

            // Field Nama
            TextField(
              controller: TextEditingController(text: mahasiswa.nama),
              decoration: InputDecoration(
                labelText: 'Nama',
                hintText: 'Masukkan Nama',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              enabled: false, // tidak bisa diedit
            ),

            const SizedBox(height: 18),

            // Field NIM
            TextField(
              controller: TextEditingController(text: mahasiswa.nim),
              decoration: InputDecoration(
                labelText: 'NIM',
                hintText: 'Masukkan NIM',
                prefixIcon: const Icon(Icons.badge),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              enabled: false,
            ),

            const SizedBox(height: 18),

            // Field Prodi
            TextField(
              controller: TextEditingController(text: mahasiswa.prodi),
              decoration: InputDecoration(
                labelText: 'Prodi',
                hintText: 'Masukkan Program Studi',
                prefixIcon: const Icon(Icons.school),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              enabled: false,
            ),

            const SizedBox(height: 18),

            // Field Jenis Kelamin
            TextField(
              controller: TextEditingController(text: mahasiswa.jeniskelamin),
              decoration: InputDecoration(
                labelText: 'Jenis Kelamin',
                hintText: 'Masukkan Jenis Kelamin',
                prefixIcon: const Icon(Icons.wc),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              enabled: false,
            ),

            const SizedBox(height: 18),

            // Field Alamat
            TextField(
              controller: TextEditingController(text: mahasiswa.alamat),
              decoration: InputDecoration(
                labelText: 'Alamat',
                hintText: 'Masukkan Alamat',
                prefixIcon: const Icon(Icons.home),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              enabled: false,
            ),

            const SizedBox(height: 18),

            // Field Tanggal Lahir
            TextField(
              controller: TextEditingController(text: mahasiswa.tanggallahir),
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                hintText: 'Pilih Tanggal Lahir',
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              enabled: false,
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
