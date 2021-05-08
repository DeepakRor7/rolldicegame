
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// Colors
const  appPrimaryColor = Colors.blue;

// values
const appName = "Roll Dice";
const totalAttempts = 10;
const docPlayers = "Players";

//icons
const ic_logo = "assets/images/ic_logo.png";




//Extentions

extension widget on BuildContext {

  double height({percentage = 100}) =>
      MediaQuery.of(this).size.height * (percentage / 100);

  double width({percentage = 100}) =>
      MediaQuery.of(this).size.width * (percentage / 100);

  BorderRadius radius(
      {double topL = 0,
        double bottomL = 0,
        double topR = 0,
        double bottomR = 0}) =>
      BorderRadius.only(
        topRight: Radius.circular(topR),
        bottomRight: Radius.circular(bottomR),
        bottomLeft: Radius.circular(bottomL),
        topLeft: Radius.circular(topL),
      );

  Widget logoIconWidget({title = appName}){
    return Column(
      children: [

        Image.asset(ic_logo),
        SizedBox(height: 20,),

        Text(title,style: TextStyle(fontSize: 22),),
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


  Future<bool> showBottomMsgWithAction(msg,{String actionText = "OK", String dismissText = "Dismiss"}) async{
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: this,
        builder: (BuildContext bc) {
          return Container(
            height: bc.height(percentage: 22),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: bc.radius(topR: 40, topL: 40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                    height: 50,
                    width: 50,
                    child: Center(
                        child: Icon(Icons.logout,
                            color:  Colors.black))),
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(onPressed: (){
                      Navigator.pop(this,true);
                    }, child: Text(actionText,style: TextStyle(color: Colors.red[400]))),
                    FlatButton(onPressed: (){
                      Navigator.pop(this,false);
                    }, child: Text(dismissText,style: TextStyle(color: Colors.blue[400]),))
                  ],
                )
              ],
            ),
          );
        });
  }


  Future<bool> showBottomMsg(context, msg) async{
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: bc.height(percentage: 22),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: bc.radius(topR: 40, topL: 40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                    height: 50,
                    width: 50,
                    child: Center(
                        child: Icon(Icons.mark_chat_unread_sharp,
                            color:  Colors.black))),
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10,),
                FlatButton(onPressed: (){
                  Navigator.pop(context,true);
                }, child: Text("OK"))
              ],
            ),
          );
        });
  }
}




