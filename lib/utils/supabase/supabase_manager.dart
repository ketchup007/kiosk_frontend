import 'package:kiosk_flutter/config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  SupabaseManager._privateConstructor();

  static final SupabaseManager _instance = SupabaseManager._privateConstructor();

  static SupabaseManager get instance => _instance;

  late SupabaseClient clientLocalDB;
  late SupabaseClient clientGlobalDB;

  void initLocalDB() {
    clientLocalDB = SupabaseClient(AppConfig.instance.localDatabaseUrl, AppConfig.instance.localDatabaseKey);
  }

  void initGlobalDB() {
    clientGlobalDB = SupabaseClient(AppConfig.instance.globalDatabaseUrl, AppConfig.instance.globalDatabaseKey);
  }

  // Future<AuthResponse> signInToLocalDB() async {
  //   final response = await clientLocalDB.auth.signInWithPassword(
  //     phone: AppConfig.instance.databaseAuthPassword,
  //     password: AppConfig.instance.databaseAuthPassword,
  //   );
  //   return response;
  // }

  // autentykacja w bazie globalnej nie jest włączona, zrobiłem funkcje na przyszlosc
  // Future<AuthResponse> signInToGlobalDB() async {
  //   final response = await clientGlobalDB.auth.signInWithPassword(phone: SupabaseConstants.globalDBAuthPhoneNumber, password: SupabaseConstants.globalDBAuthPassword);
  //   return response;
  //}
}
