class ServiceScheduleModel {
  final int? id;
  final String namaPemilik;
  final String platNomor;
  final String jenisKendaraan;
  final String tanggalService;
  final String catatan;

  ServiceScheduleModel({
    this.id,
    required this.namaPemilik,
    required this.platNomor,
    required this.jenisKendaraan,
    required this.tanggalService,
    required this.catatan,
  });

  factory ServiceScheduleModel.fromJson(Map<String, dynamic> json) {
    return ServiceScheduleModel(
      id: json['id'] as int?,
      namaPemilik: json['nama_pemilik'] ?? '',
      platNomor: json['plat_nomor'] ?? '',
      jenisKendaraan: json['jenis_kendaraan'] ?? '',
      tanggalService: json['tanggal_service'] ?? '',
      catatan: json['catatan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_pemilik': namaPemilik,
      'plat_nomor': platNomor,
      'jenis_kendaraan': jenisKendaraan,
      'tanggal_service': tanggalService,
      'catatan': catatan,
    };
  }
}