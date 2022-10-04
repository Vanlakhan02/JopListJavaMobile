import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) pickFunction;
  const UserImagePicker({required this.pickFunction, Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final picker = ImagePicker();
  File? fileImage;
  void _imagePicker() async{
   final image = await picker.getImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150, );
   setState(() {
       fileImage = File(image!.path);
   });
   widget.pickFunction(fileImage!);
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: fileImage != null? FileImage(fileImage!) : null,
      ),
      TextButton.icon(
          onPressed: _imagePicker, icon: Icon(Icons.image), label: Text("Add image")),
    ]);
  }
}
