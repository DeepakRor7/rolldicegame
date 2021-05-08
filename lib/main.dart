import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rolldicegame/ui/dashboard/DashboardUI.dart';
import 'package:rolldicegame/ui/login/LoginUI.dart';
import 'package:rolldicegame/utils/AppConstants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roll Dice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash() ,
    );
  }





}

class Splash extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {

    return SplashState();

  }



}

class SplashState extends State<Splash>{



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



    isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    print(user);
    if(user != null){

      context.openReplace(DashboardUI());

    }else{
      context.openReplace(LoginUI());
    }
  }

  @override
  void initState() {
    super.initState();
    isUserLoggedIn();
  }



  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.blue,
       body: Center(child: context.logoIconWidget()),

     );
  }

}


