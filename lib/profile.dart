import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() =>
      this.image = imageTemporary);
      
}   on PlatformException catch (e) {
    print ('Failed to pick image: $e');
  }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF162A49),
      body: Container(
        child: Column(
          children: [
            image != null?
            ImageWidget(
              image: image!,
              onClicked: (source) => pickImage(source);
            )
              : Container(
                height: 100,
                width: 100,
                child: Icon(Icons.person, size: 100),
              ),
            buildButton(
                title: 'Gallery',
                icon: Icons.image_outlined,
                onClicked: () => pickImage(ImageSource.gallery)),
            buildButton(
                title: 'Camera',
                icon: Icons.image_outlined,
                onClicked: () => pickImage(ImageSource.camera)),
          ],
        ),
      ),
    );
  }
}

Widget buildButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromRadius(10),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 15),
        ),
        onPressed: onClicked,
        child: Row(
          children: [
            Icon(icon, size: 15),
            SizedBox(
              width: 16,
            ),
            Text(title),
          ],
        ));
