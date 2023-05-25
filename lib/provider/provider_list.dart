import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';

class ProviderList{
  static var authProvider =  ChangeNotifierProvider<AuthProvider>(
    (ref) => AuthProvider(),
  );
}