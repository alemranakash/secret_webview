import 'dart:async';
import 'package:flutter/material.dart';
import '../services/storage.dart';
import 'settings_screen.dart';
import 'webview_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = StorageService();
  String? _appName;
  String? _url;
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkSettings();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkSettings() async {
    final settings = await _storage.getSettings();
    setState(() {
      _appName = settings['appName'];
      _url = settings['url'];
      _isLoading = false;
    });

    if (_appName != null && _url != null && _url!.isNotEmpty) {
      // Configured: Wait and launch
      _timer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
           Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => WebViewScreen(url: _url!)),
          );
        }
      });
    }
  }

  void _goToSettings() {
    _timer?.cancel(); // Cancel auto-nav if we go to settings
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final bool isConfigured = _appName != null && _url != null;
    final String displayText = isConfigured ? _appName! : "Setup Required";

    return Scaffold(
      body: Center(
        child: GestureDetector(
          // Secret: Long press to edit settings if configured.
          // If not configured, just tap to open.
          onLongPress: isConfigured ? _goToSettings : null,
          onTap: isConfigured ? null : _goToSettings,
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.transparent, // Hit test
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  displayText,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isConfigured)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("(Tap to Configure)", style: TextStyle(color: Colors.grey)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
