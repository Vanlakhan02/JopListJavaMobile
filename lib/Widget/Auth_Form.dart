import 'package:chating_app/Widget/Pickers.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final Function handler;
  final bool isloading;
  const AuthForm({required this.handler,required this.isloading, Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
    final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImageFile;
 void _pickImage(File image){
   
  _userImageFile = image;
 }
  void _trySubmit(){
    print(_userEmail);
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(_userImageFile == null){
      Scaffold.of(context).showSnackBar(  SnackBar(content:Text("Please. pick Image"), backgroundColor: Theme.of(context).errorColor,));
      return;
    }
    if(isValid){
      _formKey.currentState!.save();
      widget.handler(_userEmail.trim(),_userName.trim(),_userPassword.trim(), _isLogin,_userImageFile, context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(title: const Text("LOGIN")),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    if(!_isLogin)
                    UserImagePicker(pickFunction: _pickImage,),
                  TextFormField(
                    key: ValueKey("Email"),
                   validator: (value){
                     if(value!.isEmpty || !value.contains("@")){
                          return "Please Enter a valid Email address";
                     }
                     return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                    ),
                    onSaved: (value){
                          _userEmail = value.toString();
                    }
                  ),
                if(!_isLogin)
                  TextFormField(
                    key: ValueKey("user"),
                    validator: (value){
                      if(value!.isEmpty || value.length < 4){
                        return "Please password have to be at least 8 character long";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "User-Name"),
                    onSaved: (value){
                      _userName = value.toString();
                    }
                  ),
                  TextFormField(
                    key: ValueKey("password"),
                   validator: (value){
                      if(value!.isEmpty || value.length < 7){
                        return "Please password have to be at least 8 character long";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    onSaved: (value){
                      _userPassword = value.toString();
                    }
                  ),
                  SizedBox(height: 12),
                  if(widget.isloading)
                  CircularProgressIndicator(),
                  if(!widget.isloading)
                  ElevatedButton(onPressed: _trySubmit, child: Text("LOGIN"), style: ElevatedButton.styleFrom(primary: Theme.of(context).backgroundColor)),
                  TextButton(onPressed: (){
                    setState(() {
                       _isLogin = !_isLogin;     
                    });
                  }, child: Text(_isLogin ? "Create news Account" : 'i already have an account'))
                ]))),
          ),
        ),
      ),
    );
  }
}