import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:juma/pages/app/routes/baseScaffold.dart';

class CreateProgramTemplate extends StatefulWidget {
  @override
  _CreateProgramTemplateState createState() => _CreateProgramTemplateState();
}

class _CreateProgramTemplateState extends State<CreateProgramTemplate> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('Create Program Template', style: TextStyle(fontFamily: 'Oswald'),),
      ),

      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
              ),
              Expanded(
                child: Text('The PowerBuilding Program', style: TextStyle(fontSize: 20),),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File imageFile;

  Future<void> _pickImage(ImageSource source) async {
    var pickedFile = await ImagePicker().getImage(source: source);

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  Future<void> _cropImage() async {
    var croppedFile = await ImageCropper.cropImage(sourcePath: imageFile.path);

    setState(() {
      imageFile = croppedFile ?? imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}