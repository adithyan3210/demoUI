import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uidemo/home.dart';
import 'package:uidemo/screens/logIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? username = prefs.getString('name');

  runApp(MyApp(username));
}

class MyApp extends StatelessWidget {
  final String? username;

  const MyApp(this.username, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: username != null ? const MyHomePage() : const LoginScreen(),
      
    );
  }
}
