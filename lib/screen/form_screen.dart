import 'package:flutter/material.dart';
import '../model/mahasiswa.dart';
import '../db/db_helper.dart';

class FormScreen extends StatefulWidget {
  final Mahasiswa? mahasiswa; // null = tambah, isi = edit
  const FormScreen({super.key, this.mahasiswa});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // Controller untuk input
  final nimCtrl = TextEditingController();
  final namaCtrl = TextEditingController();
  final prodiCtrl = TextEditingController();
  final jeniskelaminCtrl = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    // Jika mode edit, isi controller dengan data lama
    if (widget.mahasiswa != null) {
      nimCtrl.text = widget.mahasiswa!.nim;
      namaCtrl.text = widget.mahasiswa!.nama;
      prodiCtrl.text = widget.mahasiswa!.prodi;
      jeniskelaminCtrl.text = widget.mahasiswa!.jeniskelamin;
    }
  }

  // Fungsi simpan ke database (insert / update)
  void simpan() async {
    // Validasi input tidak boleh kosong
    if (nimCtrl.text.isEmpty || namaCtrl.text.isEmpty || prodiCtrl.text.isEmpty || jeniskelaminCtrl.text.isEmpty) {
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
    // Validasi NIM harus 10 karakter
    if (nimCtrl.text.length != 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'NIM harus 10 karakter!',
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

    try {
      if (widget.mahasiswa == null) {
        // Tambah data baru
        await DBHelper.insert(Mahasiswa(
          nim: nimCtrl.text,
          nama: namaCtrl.text,
          prodi: prodiCtrl.text,
          jeniskelamin: jeniskelaminCtrl.text,
        ));
      } else {
        // Edit data lama
        await DBHelper.update(Mahasiswa(
          id: widget.mahasiswa!.id,
          nim: nimCtrl.text,
          nama: namaCtrl.text,
          prodi: prodiCtrl.text,
          jeniskelamin: jeniskelaminCtrl.text,
        ));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Gagal simpan data: $e',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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

    if (!mounted) return; // Hindari error jika context sudah tidak aktif
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
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    Navigator.pop(context); // Kembali ke halaman sebelumnya
  }

  // UI tampilan form
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mahasiswa == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 20),

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
                child: const Text("Simpan", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
