import 'package:flutter/material.dart';
import 'package:inno_example/pages/home.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routerDelegate = RouterDelegateExample();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Navigation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: RouteInformationParserExample(),
    );
  }
}

class RouterDelegateExample extends RouterDelegate<String>
    with PopNavigatorRouterDelegateMixin<String> {
  final _state = ValueNotifier<String>(Navigator.defaultRouteName);

  @override
  String get currentConfiguration => _state.value;

  @override
  void addListener(VoidCallback listener) => _state.addListener(listener);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _state,
        builder: (BuildContext context, value, Widget? child) => Navigator(
          onPopPage: (_, __) {
            _state.value = currentConfiguration.replaceAll('about', '');
            return false;
          },
          pages: [
            const MaterialPage(child: HomePage()),
            if (currentConfiguration.contains('about'))
              DialogPage(child: AboutDialog()),
            // if (currentConfiguration.contains('license'))
          ],
        ),
      );

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void removeListener(VoidCallback listener) => _state.removeListener(listener);

  @override
  Future<void> setNewRoutePath(String configuration) async {
    _state.value = configuration;
  }
}

class RouteInformationParserExample extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(
      RouteInformation routeInformation) async {
    return routeInformation.location ?? '/';
  }

  @override
  RouteInformation? restoreRouteInformation(String configuration) {
    return RouteInformation(location: configuration);
  }
}

class DialogPage extends Page {
  final Widget child;

  const DialogPage({required this.child});

  @override
  Route createRoute(BuildContext context) => DialogRoute(
      context: context, builder: (context) => child, settings: this);
}
