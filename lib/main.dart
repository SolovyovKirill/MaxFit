import 'package:flutter/material.dart';
import 'package:maxfit/pages/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maxfit/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'domain/AuthUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaxFitApp());
}

class MaxFitApp extends StatelessWidget {
  const MaxFitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        title: 'MaxFitness',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(50, 65, 85, 1),
          textTheme: TextTheme(titleLarge: TextStyle(color: Colors.white)),
        ),
        home: LandingPage(),
      ),
    );
  }
}

