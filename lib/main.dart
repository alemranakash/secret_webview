import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SecretWebViewApp());
}

class SecretWebViewApp extends StatelessWidget {
  const SecretWebViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secret WebView',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
