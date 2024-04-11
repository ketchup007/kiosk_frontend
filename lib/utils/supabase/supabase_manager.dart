import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_constants.dart';

class SupabaseManager {
  SupabaseManager._privateConstructor();

  static final SupabaseManager _instance = SupabaseManager._privateConstructor();

  static SupabaseManager get instance => _instance;

  late SupabaseClient clientLocalDB;
  late SupabaseClient clientGlobalDB;

  void initLocalDB() {
    clientLocalDB = SupabaseClient(SupabaseConstants.localDBUrl, SupabaseConstants.localDBKey);
  }

  void initGlobalDB() {
    clientGlobalDB = SupabaseClient(SupabaseConstants.globalDBUrl, SupabaseConstants.globalDBKey);
  }

  Future<AuthResponse> signInToLocalDB() async {
    final response = await clientLocalDB.auth.signInWithPassword(phone: SupabaseConstants.localDBAuthPhoneNumber, password: SupabaseConstants.localDBAuthPassword);
    return response;
  }
  // autentykacja w bazie globalnej nie jest włączona, zrobiłem funkcje na przyszlosc
  // Future<AuthResponse> signInToGlobalDB() async {
  //   final response = await clientGlobalDB.auth.signInWithPassword(phone: SupabaseConstants.globalDBAuthPhoneNumber, password: SupabaseConstants.globalDBAuthPassword);
  //   return response;
  //}
}
