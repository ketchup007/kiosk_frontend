import 'package:kiosk_flutter/config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  SupabaseManager._privateConstructor();

  static final SupabaseManager _instance = SupabaseManager._privateConstructor();

  static SupabaseManager get instance => _instance;

  SupabaseClient clientLocalDB = SupabaseClient(
    AppConfig.instance.localDatabaseUrl,
    AppConfig.instance.localDatabaseKey,
  );

  SupabaseClient clientGlobalDB = SupabaseClient(
    AppConfig.instance.globalDatabaseUrl,
    AppConfig.instance.globalDatabaseKey,
  );
}
