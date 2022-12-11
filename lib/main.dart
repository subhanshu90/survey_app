import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/screens/admeme.dart';
import 'package:quiz/screens/login.dart';
import 'package:quiz/services/auth.dart';
import 'package:quiz/services/points.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz/services/store.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthServiceProvider()),
        ChangeNotifierProvider(create: (context) => PointsCountProvider()),
        ChangeNotifierProvider(create: (context) => DataBaseProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorSchemeSeed: Colors.deepPurple[200], useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
