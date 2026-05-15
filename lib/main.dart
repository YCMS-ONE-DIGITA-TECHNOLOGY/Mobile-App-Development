import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this for state management
import 'screens/main_wrapper.dart';     // The navigation hub
import 'providers/expense_provider.dart'; // To track your money data

void main() {
  runApp(
    // Wrapping with Provider so all screens can see the expense data
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ],
      child: const LuminaApp(),
    ),
  );
}

class LuminaApp extends StatelessWidget {
  const LuminaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lumina Finance',

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Your deep navy
        useMaterial3: true,
        fontFamily: 'Poppins', // Make sure Poppins is in your pubspec.yaml
      ),

      // CHANGE THIS: MainWrapper now controls which screen is shown
      home: const MainWrapper(), 
    );
  }
}