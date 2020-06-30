import 'package:flutter/material.dart';

class Browse extends StatefulWidget {
  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: 'Search',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Colors.grey[900],
            filled: true
          ),
        )
      ),

      body: Center(child: Text('BROWSE'),),
    );
  }
}