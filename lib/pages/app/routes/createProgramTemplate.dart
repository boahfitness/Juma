import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:juma/pages/app/routes/baseScaffold.dart';
import 'package:juma/theme/Colors.dart';

class CreateProgramTemplate extends StatefulWidget {
  @override
  _CreateProgramTemplateState createState() => _CreateProgramTemplateState();
}

class _CreateProgramTemplateState extends State<CreateProgramTemplate> {
  File imageFile;
  TextEditingController programTitleController;
  int selectedTheme;
  TextEditingController descriptionController;
  TextEditingController imagePathController;

  @override
  void initState() {
    selectedTheme = 1;
    programTitleController = TextEditingController();
    descriptionController = TextEditingController();
    imagePathController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    programTitleController.dispose();
    descriptionController.dispose();
    imagePathController.dispose();
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
              Stack(
                children: [
                  ImageCapture(imagePathController: imagePathController, overlayTheme: selectedTheme,),
                ],
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
            children: ColorThemes.themeList.map<Widget>((theme) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTheme = ColorThemes.getIndex(theme);
                  });
                },
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    gradient: theme.gradient,
                    border: selectedTheme == ColorThemes.getIndex(theme) ? Border.all(
                      color: ColorThemes.getIndex(theme) != ColorThemes.getIndex(ColorThemes.black) ? Colors.white : Colors.red,
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
  final TextEditingController imagePathController;
  final int overlayTheme;
  ImageCapture({this.imagePathController, this.overlayTheme=1});
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File imageFile;
  ColorTheme theme;

  Future<void> _pickImage(ImageSource source) async {
    var pickedFile = await ImagePicker().getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        if (widget.imagePathController != null) widget.imagePathController.text = pickedFile.path;
      }
    });
  }

  // Future<void> _cropImage() async {
  //   var croppedFile = await ImageCropper.cropImage(sourcePath: imageFile.path);

  //   setState(() {
  //     imageFile = croppedFile ?? imageFile;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    theme = ColorThemes.getThemeByIndex(widget.overlayTheme);

    return GestureDetector(
      onTap: () async {
        await _pickImage(ImageSource.gallery);
      },
      child: Container(
        height: 120,
        width: 120,
        color: Colors.grey,
        child: imageFile == null ? Stack(
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
        ) :
        Stack(
          children: [
            Container(
              width: 120, height: 120,
              child: Image.file(imageFile, fit: BoxFit.cover)
            ),
            Container(
              width: 120, height: 120,
              decoration: BoxDecoration(
                gradient: imageFile != null ?
                  LinearGradient(
                    colors: [theme.solid, theme.solid.withOpacity(0.5), theme.solid.withOpacity(0.0)],
                    begin: Alignment.bottomLeft, end: Alignment.topRight,
                    stops: [0.0, 0.2, 0.6]
                  )
                  :
                  null
              ),
            )
          ],
        ),
      ),
    );
  }
}