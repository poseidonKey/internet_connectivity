import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_internet_connectivity/connectivity_observer.dart';
import 'package:flutter_internet_connectivity/network_connectivity_observer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ConnectivityObserver _connectivityObserver =
      NetworkConnectivityObserver();
  Status _status = Status.unavailable;
  StreamSubscription<Status>? _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = _connectivityObserver.observe().listen((status) {
      setState(() {
        _status = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
        child: Text('Network Status : ${_status.name}'),
      ),
    );
  }
}
