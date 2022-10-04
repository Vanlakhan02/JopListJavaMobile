import 'package:chating_app/Widget/Auth_Form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
 void _submitAuthForm(String email, String userName, String password, bool isLogin, File fileImage, BuildContext ctx) async {
   UserCredential authResult;
   try{
     setState(() {
       _isLoading = true;
     });
    if(isLogin){
      authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    }else{
     authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final ref =  FirebaseStorage.instance.ref().child('user_image').child(authResult.user!.uid + '.jpg');
     await ref.putFile(fileImage);
     final url = await ref.getDownloadURL();
     await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
               'username' : userName,
               'email' : email,
               'image_url': url
      }
      );
    }
   }on PlatformException catch(err){
         var messager = 'An error occured, pleased check your credential';

         if(err.message != null){
           messager = err.message.toString();
         }
        
         Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(messager),backgroundColor: Theme.of(ctx).errorColor,));
         setState(() {
           _isLoading = false;
         });
   }catch(err){
    print(err);
   }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).primaryColor,
    body: AuthForm(handler: _submitAuthForm, isloading:_isLoading ));
  }
}
