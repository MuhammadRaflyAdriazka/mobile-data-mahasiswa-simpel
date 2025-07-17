import 'package:flutter/material.dart';
import '../model/mahasiswa.dart';
import '../db/db_helper.dart';

class FormScreen extends StatefulWidget {
  final Mahasiswa? mahasiswa; // Jika null = tambah data, jika isi = edit data
  const FormScreen({super.key, this.mahasiswa});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // Controller untuk masing-masing inputan
  final nomorCtrl = TextEditingController();
  final nimCtrl = TextEditingController();
  final namaCtrl = TextEditingController();
  final prodiCtrl = TextEditingController();
  final jeniskelaminCtrl = TextEditingController();
  final alamatCtrl = TextEditingController();
  final tanggallahirCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Jika dalam mode edit, isi field dengan data lama
    if (widget.mahasiswa != null) {
      nomorCtrl.text = widget.mahasiswa!.id.toString();
      nimCtrl.text = widget.mahasiswa!.nim;
      namaCtrl.text = widget.mahasiswa!.nama;
      prodiCtrl.text = widget.mahasiswa!.prodi;
      jeniskelaminCtrl.text = widget.mahasiswa!.jeniskelamin;
      alamatCtrl.text = widget.mahasiswa!.alamat;
      tanggallahirCtrl.text = widget.mahasiswa!.tanggallahir;
    }
  }

  // Fungsi untuk menyimpan data (insert / update)
  void simpan() async {
    // Validasi: semua field harus diisi
    if (nimCtrl.text.isEmpty || namaCtrl.text.isEmpty || prodiCtrl.text.isEmpty || jeniskelaminCtrl.text.isEmpty || alamatCtrl.text.isEmpty || tanggallahirCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Semua field harus diisi!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.indigo,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Cek duplikat NIM
    final isExist = await DBHelper.isNimExist(nimCtrl.text.trim(), excludeId: widget.mahasiswa?.id);
    if (isExist) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'NIM sudah terdaftar. Gunakan NIM lain.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      if (widget.mahasiswa == null) {
        // Simpan data baru
        await DBHelper.insert(Mahasiswa(
          nim: nimCtrl.text,
          nama: namaCtrl.text,
          prodi: prodiCtrl.text,
          jeniskelamin: jeniskelaminCtrl.text,
          alamat: alamatCtrl.text,
          tanggallahir: tanggallahirCtrl.text,
        ));
      } else {
        // Update data lama
        await DBHelper.update(Mahasiswa(
          id: widget.mahasiswa!.id,
          nim: nimCtrl.text,
          nama: namaCtrl.text,
          prodi: prodiCtrl.text,
          jeniskelamin: jeniskelaminCtrl.text,
          alamat: alamatCtrl.text,
          tanggallahir: tanggallahirCtrl.text,
        ));
      }
    } catch (e) {
      // Tampilkan pesan jika gagal simpan
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal simpan data: $e',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Tampilkan snackbar berhasil
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Data berhasil disimpan!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 2),
      ),
    );

    // Delay sebelum kembali ke halaman sebelumnya
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    Navigator.pop(context);
  }

  // Tampilan UI form input
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mahasiswa == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white), // warna ikon kembali
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Nomor
            TextField(
              controller: nomorCtrl,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Nomor',
                hintText: 'Nomor ID Otomatis',
                prefixIcon: const Icon(Icons.numbers),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              
            ),
            const SizedBox(height: 12),

            // Input Nama
            TextField(
              controller: namaCtrl,
              decoration: InputDecoration(
                labelText: 'Nama',
                hintText: 'Masukkan Nama',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),

            // Input NIM
            TextField(
              controller: nimCtrl,
              decoration: InputDecoration(
                labelText: 'NIM',
                hintText: 'Masukkan NIM',
                prefixIcon: const Icon(Icons.badge),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),

            // Input Prodi
            TextField(
              controller: prodiCtrl,
              decoration: InputDecoration(
                labelText: 'Prodi',
                hintText: 'Masukkan Program Studi',
                prefixIcon: const Icon(Icons.school),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),

            // Input Jenis Kelamin
            TextField(
              controller: jeniskelaminCtrl,
              decoration: InputDecoration(
                labelText: 'Jenis Kelamin',
                hintText: 'Masukkan Jenis Kelamin',
                prefixIcon: const Icon(Icons.wc),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),

            // Input Alamat
            TextField(
              controller: alamatCtrl,
              decoration: InputDecoration(
                labelText: 'Alamat',
                hintText: 'Masukkan Alamat',
                prefixIcon: const Icon(Icons.home),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),

            // Input Tanggal Lahir (menggunakan DatePicker)
            TextField(
              controller: tanggallahirCtrl,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                hintText: 'Pilih Tanggal Lahir',
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: tanggallahirCtrl.text.isNotEmpty
                      ? DateTime.tryParse(tanggallahirCtrl.text) ?? DateTime.now()
                      : DateTime.now(),
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  tanggallahirCtrl.text = picked.toIso8601String().substring(0, 10);
                }
              },
            ),
            const SizedBox(height: 12),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: simpan,
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}