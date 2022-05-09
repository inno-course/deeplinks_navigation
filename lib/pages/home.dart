import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const title = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        actions: [
          IconButton(
              onPressed: () => Router.of(context).routerDelegate.setNewRoutePath('/about'),
              icon: const Icon(Icons.account_balance_outlined)),
        ],
      ),
      body: Row(
        children: [],
      ),
    );
  }
}
