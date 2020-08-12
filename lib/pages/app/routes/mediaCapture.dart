import 'package:flutter/material.dart';
import 'package:juma/pages/app/routes/baseScaffold.dart';

class MediaCapture extends StatefulWidget {
  @override
  _MediaCaptureState createState() => _MediaCaptureState();
}

class _MediaCaptureState extends State<MediaCapture> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Text('UPLOAD IMAGE...'),
      ),

      bottomNavigationBar: Container(height: 0, width: 0,),
    );
  }
}