import 'package:flutter/material.dart';

class InputDisplayName extends StatefulWidget {
  final TextEditingController controller;
  InputDisplayName(this.controller);
  @override
  _InputDisplayNameState createState() => _InputDisplayNameState();
}

class _InputDisplayNameState extends State<InputDisplayName> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('What would you like to be called?', textAlign: TextAlign.left,),
          Text('Your display name is how other users will\nrecognize you.', textAlign: TextAlign.left, style: TextStyle(fontSize: 12, color: Colors.grey),),
          SizedBox(height: 20,),
          TextFormField(
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
            controller:  widget.controller,
            decoration: InputDecoration(
              labelText: 'Display Name',
              labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w200, fontSize: 18),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never
            ),
            validator: (val) {
              if (val.isEmpty) return 'please enter a display name';
              if (val.contains(' ')) return 'no spaces';
              if (val.length > 29) return 'too long';
              if (val.endsWith('.') || val.contains('..') || val.startsWith('.')) return 'invalid input';
              if (val.contains(RegExp(r'[^\w.]'))) return 'no special characters';
              return null;
            },
          )
        ],
      ),
    );
  }
}