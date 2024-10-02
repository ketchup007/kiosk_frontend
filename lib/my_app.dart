import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_flutter/features/language/cubit/language_cubit.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/features/order/services/order_service.dart';
import 'package:kiosk_flutter/path_selector.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiosk_flutter/utils/supabase/aps_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/aps_order_repository.dart';
import 'package:kiosk_flutter/utils/supabase/database_service.dart';
import 'package:kiosk_flutter/utils/supabase/item_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/menu_repository.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_function_repository.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    RepositoryProvider.of<ApsOrderService>(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        //
        RepositoryProvider(create: (context) => ApsDescriptionRepository()),
        RepositoryProvider(create: (context) => ItemDescriptionRepository()),
        RepositoryProvider(create: (context) => MenuRepository()),
        RepositoryProvider(create: (context) => ApsOrderRepository()),
        RepositoryProvider(create: (context) => SupabaseFunctionRepository()),
        //
        RepositoryProvider(create: (context) => DatabaseService()),
        RepositoryProvider(
          create: (context) => ApsOrderService(
            orderRepository: RepositoryProvider.of(context),
            apsRepository: RepositoryProvider.of(context),
            itemRepository: RepositoryProvider.of(context),
            menuRepository: RepositoryProvider.of(context),
            supabaseFunctionRepository: RepositoryProvider.of(context),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LanguageCubit(),
          ),
          BlocProvider(
            create: (context) => OrderBloc(apsOrderService: RepositoryProvider.of(context))
              ..add(const OrderEvent.loadAvailableItems())
              ..add(const OrderEvent.loadMenuItemsWithDescriptions())
              ..add(const OrderEvent.loadOrderItems()),
          ),
        ],
        child: Builder(
          builder: (context) {
            final Locale locale = context.select((LanguageCubit cubit) => cubit.state);
            return MaterialApp(
              locale: locale,
              title: 'Munchies Kiosk',
              localizationsDelegates: const [
                AppText.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppText.delegate.supportedLocales,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                useMaterial3: true,
              ),
              home: const PathSelector(),
            );
          },
        ),
      ),
    );
  }
}
