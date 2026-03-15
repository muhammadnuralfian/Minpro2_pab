import 'package:flutter/material.dart';
import '../models/service_schedule_model.dart';
import '../services/service_schedule_service.dart';

class ScheduleFormPage extends StatefulWidget {
  final ServiceScheduleModel? schedule;

  const ScheduleFormPage({super.key, this.schedule});

  @override
  State<ScheduleFormPage> createState() => _ScheduleFormPageState();
}

class _ScheduleFormPageState extends State<ScheduleFormPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final platController = TextEditingController();
  final jenisController = TextEditingController();
  final tanggalController = TextEditingController();
  final catatanController = TextEditingController();

  final ServiceScheduleService service = ServiceScheduleService();

  @override
  void initState() {
    super.initState();

    if (widget.schedule != null) {
      namaController.text = widget.schedule!.namaPemilik;
      platController.text = widget.schedule!.platNomor;
      jenisController.text = widget.schedule!.jenisKendaraan;
      tanggalController.text = widget.schedule!.tanggalService;
      catatanController.text = widget.schedule!.catatan;
    }
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      tanggalController.text =
          "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  Future<void> saveData() async {
    if (!_formKey.currentState!.validate()) return;

    final data = ServiceScheduleModel(
      id: widget.schedule?.id,
      namaPemilik: namaController.text,
      platNomor: platController.text,
      jenisKendaraan: jenisController.text,
      tanggalService: tanggalController.text,
      catatan: catatanController.text,
    );

    if (widget.schedule == null) {
      await service.addSchedule(data);
    } else {
      await service.updateSchedule(data);
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schedule == null
            ? "Tambah Jadwal Service"
            : "Edit Jadwal Service"),
      ),

      body: Container(
        color: const Color(0xFFE0E0E0),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Form(
            key: _formKey,

            child: ListView(
              children: [

                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: "Nama Pemilik",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Harus diisi" : null,
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: platController,
                  decoration: const InputDecoration(
                    labelText: "Plat Nomor",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: jenisController,
                  decoration: const InputDecoration(
                    labelText: "Jenis Kendaraan",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: tanggalController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Tanggal Service",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: pickDate,
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: catatanController,
                  decoration: const InputDecoration(
                    labelText: "Catatan",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: saveData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Simpan",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}