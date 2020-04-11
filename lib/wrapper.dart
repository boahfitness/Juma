import 'package:flutter/material.dart';
import 'package:juma/pages/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:juma/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // Home or Auth
    return Authenticate();
  }
}