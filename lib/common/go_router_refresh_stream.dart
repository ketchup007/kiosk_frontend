import 'dart:async';

import 'package:flutter/material.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class GoRouterRefreshMultiStream extends ChangeNotifier {
  late final List<StreamSubscription> _subscriptions;

  GoRouterRefreshMultiStream(List<Stream<dynamic>> streams) {
    _subscriptions = streams.map((stream) {
      return stream.listen((_) {
        notifyListeners(); // Powiadamia GoRouter o konieczności odświeżenia
      });
    }).toList();
  }

  @override
  void dispose() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
