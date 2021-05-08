
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// Colors
const  appPrimaryColor = Colors.blue;

// Strings
const appName = "Roll Dice";

//icons
const ic_logo = "assets/images/ic_logo.png";


//Extentions

extension widget on BuildContext {

  Widget logoIconWidget(){
    return Column(
      children: [

        Image.asset(ic_logo),
        SizedBox(height: 20,),

        Text(appName,style: TextStyle(fontSize: 22),),
      ],
    );
  }

  openReplace(  Widget whichIsOpen) {
    Navigator.pushReplacement(
        this, CupertinoPageRoute(builder: (context) => whichIsOpen));
  }

  open(  Widget whichIsOpen) {
    Navigator.push(
        this, CupertinoPageRoute(builder: (context) => whichIsOpen));
  }

  Future openWait(  Widget whichIsOpen) async {
    final result = await Navigator.push(
      this,
      CupertinoPageRoute(builder: (context) => whichIsOpen),
    );

    return result;
  }
}




