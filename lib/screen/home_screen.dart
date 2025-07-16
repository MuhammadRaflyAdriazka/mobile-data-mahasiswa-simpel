import 'package:flutter/material.dart';
import '../model/mahasiswa.dart';
import '../db/db_helper.dart';
import 'form_screen.dart';

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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mhs.nama,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.badge, size: 16, color: Colors.indigo),
                                  const SizedBox(width: 6),
                                  Text(
                                    mhs.nim,
                                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.school, size: 16, color: Colors.indigo),
                                  const SizedBox(width: 6),
                                  Text(
                                    mhs.prodi,
                                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.wc, size: 16, color: Colors.indigo),
                                  const SizedBox(width: 6),
                                  Text(
                                    mhs.jeniskelamin,
                                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FormScreen(mahasiswa: mhs),
                                  ),
                                );
                                fetchData();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteData(mhs.id!),
                            ),
                          ],
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
