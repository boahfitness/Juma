import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:juma/pages/app/routes/baseScaffold.dart';
import 'package:juma/theme/Colors.dart';

class CreateProgramTemplate extends StatefulWidget {
  @override
  _CreateProgramTemplateState createState() => _CreateProgramTemplateState();
}

class _CreateProgramTemplateState extends State<CreateProgramTemplate> {
  File imageFile;
  TextEditingController programTitleController;
  ThemeType selectedTheme;
  TextEditingController descriptionController;

  @override
  void initState() {
    selectedTheme = ThemeType.red;
    programTitleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    programTitleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('Create Program Template', style: TextStyle(fontFamily: 'Oswald'),),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/media-capture');
                },
                child: Container(
                  height: 120,
                  width: 120,
                  color: Colors.grey,
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(Icons.landscape, size: 50, color: Colors.grey[400],),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            color: Colors.black.withOpacity(0.7),
                            height: 20,
                            width: 120,
                            child: Center(child: Text('Select Image', textAlign: TextAlign.center, style: TextStyle(fontSize: 11),)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
              ),
              Expanded(
                child: TextFormField(
                  controller: programTitleController,
                  maxLines: null,
                  style: TextStyle(fontSize: 20.0),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Input Title...',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text('Theme', style: TextStyle(fontSize: 18),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ThemeType.values.map<Widget>((themeType) {
              ColorTheme theme = ColorTheme.getTheme(themeType);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTheme = themeType;
                  });
                },
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    gradient: theme.gradient,
                    border: selectedTheme == themeType ? Border.all(
                      color: themeType != ThemeType.black ? Colors.white : Colors.red,
                      width: 3.0,
                    ) : null,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              );
            }).toList(),
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