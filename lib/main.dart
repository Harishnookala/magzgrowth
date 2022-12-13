import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:magzgrowth/UserScreens/userPannel.dart';
import 'package:magzgrowth/splash_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SharedPreferences prefsdata = await SharedPreferences.getInstance();
  var value = prefsdata.getBool("bank");
  var token = prefs.getString('phonenumber');
  print(token);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token==null?const SplashScreen():userPannel(phonenumber: token,pressed: value,)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home:SplashScreen()
    );
  }
}


