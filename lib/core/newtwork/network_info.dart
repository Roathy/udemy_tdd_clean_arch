import 'dart:async';

import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImp implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImp(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

  // Future<bool>? get isConnected {
  //   connectionChecker.hasConnection;
  //   return Future.value(true);
  // }