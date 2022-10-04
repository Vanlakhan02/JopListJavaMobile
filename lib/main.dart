import 'package:chating_app/screen/chating_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './screen/Auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor:  Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness:  Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        )
      ),
      home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
             builder: (ctx, snapshot){
             if(snapshot.hasError){
              return Scaffold(body: Text(snapshot.error.toString()),);
             }
             if(snapshot.hasData){
               return ChatScreen();
             }
              return  AuthScreen();
      
       })
      );
 }
}

