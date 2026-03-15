import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../models/service_schedule_model.dart';

class ServiceScheduleService {
  final SupabaseClient supabase = SupabaseConfig.client;
  final String tableName = 'service_schedules';

  Future<List<ServiceScheduleModel>> getSchedules() async {
    final response =
        await supabase.from(tableName).select().order('id', ascending: false);

    return (response as List)
        .map((item) => ServiceScheduleModel.fromJson(item))
        .toList();
  }

  Future<void> addSchedule(ServiceScheduleModel data) async {
    await supabase.from(tableName).insert(data.toJson());
  }

  Future<void> updateSchedule(ServiceScheduleModel data) async {
    await supabase.from(tableName).update(data.toJson()).eq('id', data.id!);
  }

  Future<void> deleteSchedule(int id) async {
    await supabase.from(tableName).delete().eq('id', id);
  }
}