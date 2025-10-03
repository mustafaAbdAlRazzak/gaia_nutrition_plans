import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServicesProvider extends GetxService {
  late final SupabaseClient supabaseClient;
  final String url = 'https://czphzygzsrnukenrwyqc.supabase.co';
  final String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN6cGh6eWd6c3JudWtlbnJ3eXFjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkyNDI5NjUsImV4cCI6MjA3NDgxODk2NX0.zxK6nRNMPUD5C4UTWf2ng8dhPDd2kfYfQ3QTJJa4O5M';
  Future<SupabaseServicesProvider> init() async {
    await Supabase.initialize(anonKey: anonKey, url: url);
    supabaseClient = Supabase.instance.client;
    return this;
  }
}
