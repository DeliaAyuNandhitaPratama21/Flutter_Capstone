import 'package:flutter/material.dart';
import 'constants/theme.dart';
import 'screens/splash.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/dashboard.dart';
import 'screens/upload.dart';
import 'screens/history.dart';

void main() {
  runApp(const CarbonScanApp());
}

class CarbonScanApp extends StatelessWidget {
  const CarbonScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CarbonScan',
      theme: AppTheme.light(),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/upload': (_) => const UploadScreen(),
        '/history': (_) => const HistoryScreen(),
      },
    );
  }
}
