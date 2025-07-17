import 'package:flutter/material.dart';
import '../model/mahasiswa.dart';
import '../db/db_helper.dart';
import 'form_screen.dart';
import 'detail_mahasiswa_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Mahasiswa> data = [];

  void fetchData() async {
    final res = await DBHelper.getAll();
    setState(() {
      data = res;
    });
  }

  void deleteData(int id) async {
    await DBHelper.delete(id);
    fetchData();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Mahasiswa",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Reset Database',
            onPressed: () async {
              await DBHelper.resetDatabase();
              fetchData();
              if (!mounted) return;
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Database berhasil direset!')),
              );
            },
          ),
        ],
      ),
      body: data.isEmpty
          ? const Center(child: Text("Belum Ada Data Mahasiswa"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final mhs = data[index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.indigo,
                          child: Text(
                            mhs.nama.isNotEmpty ? mhs.nama[0].toUpperCase() : '?',
                            style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (ctx) => SimpleDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  title: const Text('Pilihan'),
                                  children: [
                                    SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => DetailMahasiswaScreen(mahasiswa: mhs),
                                          ),
                                        );
                                      },
                                      child: const Text('Lihat Data'),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () async {
                                        Navigator.pop(ctx);
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => FormScreen(mahasiswa: mhs),
                                          ),
                                        );
                                        fetchData();
                                      },
                                      child: const Text('Update Data'),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text('Hapus Data'),
                                            content: const Text('Yakin ingin menghapus data ini?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('Batal'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  deleteData(mhs.id!);
                                                },
                                                child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: const Text('Hapus Data', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}. ${mhs.nama}', // <-- Tambah nomor urut di sini
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.badge, size: 16, color: Colors.indigo),
                                    const SizedBox(width: 6),
                                    Text(mhs.nim, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.school, size: 16, color: Colors.indigo),
                                    const SizedBox(width: 6),
                                    Text(mhs.prodi, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.wc, size: 16, color: Colors.indigo),
                                    const SizedBox(width: 6),
                                    Text(mhs.jeniskelamin, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.home, size: 16, color: Colors.indigo),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        mhs.alamat,
                                        style: const TextStyle(fontSize: 15, color: Colors.black87),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16, color: Colors.indigo),
                                    const SizedBox(width: 6),
                                    Text(mhs.tanggallahir, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormScreen()),
          );
          fetchData();
        },
      ),
    );
  }
}
