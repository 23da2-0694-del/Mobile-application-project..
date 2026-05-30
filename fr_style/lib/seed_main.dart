import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/db_seeder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SeedApp());
}

class SeedApp extends StatefulWidget {
  const SeedApp({super.key});

  @override
  State<SeedApp> createState() => _SeedAppState();
}

class _SeedAppState extends State<SeedApp> {
  bool _isSeeding = false;
  String _status = 'Ready to seed database';

  void _startSeeding() async {
    setState(() {
      _isSeeding = true;
      _status = 'Seeding in progress...';
    });

    try {
      await DbSeeder.seedProducts();
      setState(() {
        _status = 'Database seeded successfully!';
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    } finally {
      setState(() {
        _isSeeding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Firestore Seeder')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_status, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              if (_isSeeding)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _startSeeding,
                  child: const Text('Start Seeding'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
