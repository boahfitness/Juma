import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends Scaffold {

  BaseScaffold({Key key, PreferredSizeWidget appBar, Widget body, Widget floatingActionButton, 
    FloatingActionButtonLocation floatingActionButtonLocation, FloatingActionButtonAnimator floatingActionButtonAnimator, 
    List<Widget> persistentFooterButtons, Widget drawer, Widget endDrawer, Widget bottomNavigationBar, Widget bottomSheet, 
    Color backgroundColor, bool resizeToAvoidBottomPadding, bool resizeToAvoidBottomInset, bool primary = true, 
    DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start, bool extendBody = false, bool extendBodyBehindAppBar = false, Color drawerScrimColor, 
    double drawerEdgeDragWidth, bool drawerEnableOpenDragGesture = true, bool endDrawerEnableOpenDragGesture = true})
    :
    super(key: key, appBar: appBar, floatingActionButton: floatingActionButton, 
    floatingActionButtonLocation: floatingActionButtonLocation, floatingActionButtonAnimator: floatingActionButtonAnimator, 
    persistentFooterButtons: persistentFooterButtons, drawer: drawer, endDrawer: endDrawer,bottomNavigationBar: bottomNavigationBar, bottomSheet: bottomSheet, 
    resizeToAvoidBottomPadding: resizeToAvoidBottomPadding, resizeToAvoidBottomInset: resizeToAvoidBottomInset, primary: primary, 
    drawerDragStartBehavior: drawerDragStartBehavior, extendBody: extendBody, extendBodyBehindAppBar: extendBodyBehindAppBar, drawerScrimColor: drawerScrimColor, 
    drawerEdgeDragWidth: drawerEdgeDragWidth, drawerEnableOpenDragGesture: drawerEnableOpenDragGesture, endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
    
    // CONSTANTS
    body: Padding(
      padding: EdgeInsets.only(left: 30.0),
      child: body,
    ),

    backgroundColor: backgroundColor ?? Color(0xff121212)
    );
}