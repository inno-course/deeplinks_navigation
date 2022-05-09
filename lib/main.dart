import 'package:flutter/material.dart';
import 'app.dart';

import 'url_strategy_noop.dart' if (dart.library.html) 'url_strategy_web.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}
