# Mini Project 2 PAB

## Deskripsi Aplikasi
Aplikasi Manajemen Jadwal Service Kendaraan adalah aplikasi Flutter yang digunakan untuk mengelola data jadwal service kendaraan dengan integrasi database Supabase.

## Fitur Aplikasi
- Menambah data jadwal service
- Melihat daftar jadwal service
- Mengedit data jadwal service
- Menghapus data jadwal service
- Menggunakan date picker untuk memilih tanggal service
- Menggunakan file .env untuk menyimpan Supabase URL dan API Key
- Mendukung light mode dan dark mode

## Teknologi yang Digunakan
- Flutter
- Dart
- Supabase

## Widget yang Digunakan
- MaterialApp
- Scaffold
- AppBar
- ListView
- Card
- ListTile
- TextFormField
- ElevatedButton
- FloatingActionButton
- FutureBuilder
- AlertDialog

## Struktur Folder
minpro2pab
├── lib
│   ├── config
│   │   └── supabase_config.dart
│   ├── models
│   │   └── service_schedule_model.dart
│   ├── services
│   │   └── service_schedule_service.dart
│   ├── pages
│   │   ├── schedule_list_page.dart
│   │   └── schedule_form_page.dart
│   └── main.dart
├── .env
├── .gitignore
├── pubspec.yaml
└── README.md

## Database
Aplikasi menggunakan Supabase dengan tabel `service_schedules` untuk menyimpan data:
- id
- nama_pemilik
- plat_nomor
- jenis_kendaraan
- tanggal_service
- catatan


## Tampilan

### Tampilan Halaman Utama (Data Kosong)
![image alt](https://github.com/muhammadnuralfian/Minpro2_pab/blob/2198c5f2937164746dbc8576fef7e813a5604f91/Cuplikan%20layar%202026-03-16%20000816.png)
Pada gambar pertama ditampilkan halaman utama aplikasi **Jadwal Service Kendaraan** ketika belum ada data yang tersimpan di database. Di bagian tengah halaman terdapat teks **"Belum ada data"** yang menandakan bahwa daftar jadwal service masih kosong. Pada bagian kanan bawah terdapat tombol **Tambah** berbentuk Floating Action Button (FAB) yang digunakan untuk menambahkan jadwal service kendaraan baru. Tampilan halaman menggunakan background berwarna abu rokok agar tampilan lebih jelas dan tidak terlihat terlalu polos.

## Halaman Form Tambah Jadwal Service
![image alt](https://github.com/muhammadnuralfian/Minpro2_pab/blob/5dce303ae2ca0de4b5e1e48f7233a75265b6c94e/Cuplikan%20layar%202026-03-16%20000924.png)
Pada gambar kedua ditampilkan halaman **form untuk menambahkan jadwal service kendaraan**. Pengguna dapat mengisi beberapa informasi seperti **nama pemilik, plat nomor, jenis kendaraan, tanggal service, dan catatan tambahan** mengenai service kendaraan. Pada bagian tanggal service terdapat fitur **date picker** yang memudahkan pengguna memilih tanggal. Setelah semua data diisi, pengguna dapat menekan tombol **Simpan** untuk menyimpan data ke database Supabase sehingga data tersebut akan muncul pada daftar jadwal service.


## Halaman Daftar Jadwal Service
![image alt](https://github.com/muhammadnuralfian/Minpro2_pab/blob/0787fff5eea9e9ecb6515e250c6f137e9dff28dd/Cuplikan%20layar%202026-03-16%20001215.png)
Pada gambar ketiga ditampilkan halaman **daftar jadwal service kendaraan** yang sudah tersimpan di database. Setiap data ditampilkan dalam bentuk **card** yang berisi informasi seperti **nama pemilik, plat nomor, jenis kendaraan, tanggal service, dan catatan**. Pada setiap card juga terdapat dua tombol aksi yaitu **edit** untuk memperbarui data yang sudah ada dan **hapus** untuk menghapus data jadwal service dari database.

## Dialog Konfirmasi Hapus
![image alt](https://github.com/muhammadnuralfian/Minpro2_pab/blob/bcb83f9b7d987cd6484f4ee6bcba739bdd4ff03e/Cuplikan%20layar%202026-03-16%20001253.png)
Pada gambar keempat ditampilkan **dialog konfirmasi penghapusan data** yang muncul ketika pengguna menekan tombol hapus pada salah satu data jadwal service. Dialog ini berfungsi untuk memastikan bahwa pengguna benar-benar ingin menghapus data tersebut sehingga tidak terjadi kesalahan penghapusan data. Di dalam dialog terdapat dua pilihan yaitu **Batal** untuk membatalkan proses penghapusan dan **Hapus** untuk melanjutkan penghapusan data dari database Supabase.

