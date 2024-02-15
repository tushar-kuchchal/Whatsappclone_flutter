import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:full_stack_whatsapp_flutter/screens/camera_screen.dart';
import 'package:full_stack_whatsapp_flutter/screens/home.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras=await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'OpenSans',
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 19, 149, 134),
            
              ),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 19, 149, 134),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
              iconTheme: IconThemeData(color: Colors.white, size: 25))),
      home: const Home(),
    );
  }
}
