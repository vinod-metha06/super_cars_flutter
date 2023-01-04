import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_cars_/Screens/Home.dart';
import 'package:super_cars_/Screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  await Firebase.initializeApp();

  runApp(MyApp(
    email: email,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, @required this.email});
  String? email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Super cars",
      home: email == null ? LoginPage() :const Home(),
    );
  }
}
