enum Flavor {
  mock,
  development,
  staging,
  production,
}

class AppConfig {
  static AppConfig get instance {
    assert(
      _instance._initialized,
      'You must initialize the supabase instance before calling Supabase.instance',
    );
    return _instance;
  }

  static Future<AppConfig> initialize({required Flavor flavor}) async {
    assert(
      !_instance._initialized,
      'This instance is already initialized',
    );

    _instance._init(flavor);

    return _instance;
  }

  AppConfig._();
  static final AppConfig _instance = AppConfig._();

  bool _initialized = false;
  late Flavor _flavor;

  void _init(Flavor flavor) {
    _flavor = flavor;
    _initialized = true;
  }

  bool get isMock => _flavor == Flavor.mock;
  bool get isDevelopment => _flavor == Flavor.development;
  bool get isStaging => _flavor == Flavor.staging;
  bool get isProduction => _flavor == Flavor.production;

  String get title => switch (_flavor) {
        Flavor.mock => 'mock',
        Flavor.development => 'development',
        Flavor.staging => 'staging',
        Flavor.production => 'production',
      };

  int get apsId => switch (_flavor) {
        Flavor.mock => 1,
        Flavor.development => 1,
        Flavor.staging => 1,
        Flavor.production => 1,
      };

  String get localDatabaseUrl => switch (_flavor) {
        Flavor.mock => '4',
        Flavor.development => 'http://127.0.0.1:64321',
        Flavor.staging => '4',
        Flavor.production => 'http://10.3.15.11:8084',
      };

  String get globalDatabaseUrl => switch (_flavor) {
        Flavor.mock => '4',
        Flavor.development => 'http://127.0.0.1:54321',
        Flavor.staging => '4',
        Flavor.production => 'http://10.3.14.15:8000',
      };

  String get localDatabaseKey => switch (_flavor) {
        Flavor.mock => '4',
        Flavor.development => 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU',
        Flavor.staging => '4',
        Flavor.production =>
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNzEwMjg0NDAwLAogICJleHAiOiAxODY4MDUwODAwCn0.0-ul2rGrRETZXr7faeGml6E6gZkrV8e2TbIcIfXbtOo',
      };

  String get globalDatabaseKey => switch (_flavor) {
        Flavor.mock => '4',
        Flavor.development => 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU',
        Flavor.staging => '4',
        Flavor.production =>
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE',
      };

  String get databaseAuthPhoneNumber => '48502854988';
  String get databaseAuthPassword => 'Qwerty123y!';
}
