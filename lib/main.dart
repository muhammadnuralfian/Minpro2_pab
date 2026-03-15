import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/schedule_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manajemen Jadwal Service Kendaraan',
      debugShowCheckedModeBanner: false,

      // Light Mode
theme: ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorSchemeSeed: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFFEAF2FF),
),

darkTheme: ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorSchemeSeed: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFF121212),
),

      // Otomatis mengikuti sistem
      themeMode: ThemeMode.system,

      home: const ScheduleListPage(),
    );
  }
}