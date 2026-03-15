import 'package:flutter/material.dart';
import '../models/service_schedule_model.dart';
import '../services/service_schedule_service.dart';
import 'schedule_form_page.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({super.key});

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  final ServiceScheduleService service = ServiceScheduleService();
  late Future<List<ServiceScheduleModel>> futureSchedules;

  @override
  void initState() {
    super.initState();
    futureSchedules = service.getSchedules();
  }

  void refreshData() {
    setState(() {
      futureSchedules = service.getSchedules();
    });
  }

  Future<void> deleteData(int id) async {
    await service.deleteSchedule(id);
    refreshData();
  }

  Future<void> confirmDelete(ServiceScheduleModel data) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Apakah kamu yakin ingin menghapus data ${data.namaPemilik}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (result == true && data.id != null) {
      await deleteData(data.id!);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil dihapus'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jadwal Service Kendaraan"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0E0E0),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<ServiceScheduleModel>>(
          future: futureSchedules,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("Terjadi error: ${snapshot.error}"),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Belum ada data"),
              );
            }

            final schedules = snapshot.data!;

            return ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final data = schedules[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.directions_car,
                      color: Colors.blue,
                      size: 32,
                    ),
                    title: Text(
                      data.namaPemilik,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Plat: ${data.platNomor}\n"
                      "Kendaraan: ${data.jenisKendaraan}\n"
                      "Tanggal: ${data.tanggalService}\n"
                      "Catatan: ${data.catatan}",
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.orange,
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ScheduleFormPage(
                                  schedule: data,
                                ),
                              ),
                            );

                            if (result == true) {
                              refreshData();
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => confirmDelete(data),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ScheduleFormPage(),
            ),
          );

          if (result == true) {
            refreshData();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Tambah"),
      ),
    );
  }
}