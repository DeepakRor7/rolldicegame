

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rolldicegame/ui/login/OtpUI.dart';
import 'package:rolldicegame/ui/login/bloc/ValidationBloc.dart';
import 'package:rolldicegame/utils/AppConstants.dart';


class LoginUI extends StatelessWidget{

  final TextEditingController _controllerPhoneNumber =
  TextEditingController();





  var validBloc = ValidationBloc();



BuildContext context;
  @override
  Widget build(BuildContext context) {

    context = context;


    return Scaffold(

      backgroundColor: Colors.blue[50],

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder<bool>(
          stream: validBloc.validation,
          initialData: false,
          builder: (context, snapshot) {
            return FloatingActionButton.extended(

              backgroundColor: snapshot.data ? Colors.blue :Colors.grey,

              label: Text("Login"), onPressed: () {

              if(snapshot.data)
              _submitPhoneNumber(_controllerPhoneNumber.text);

            },);
          }
        ),
      ),

      body: Container(
       child: ListView(
         children: <Widget>[

         SizedBox(height: 100,),
          context.logoIconWidget(),
           SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text("Login",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600) ,),
                Text("Proceed with mobile number"),
                SizedBox(height: 20,) ,

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("+91"),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: Container(
                                height: 15, width: 1, color: Colors.grey,),
                            ),

                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 134,
                      child: TextField(
                        onChanged: (t){
                          validBloc.validatePhoneNumber(t);
                        },
                        keyboardType: TextInputType.number,
                        controller: _controllerPhoneNumber,
                        style: TextStyle(
                            fontSize: 16
                            , color: Colors.black),
                        decoration: InputDecoration(


                            hintStyle: TextStyle(color: Colors.grey),
                            labelText: "Mobile Number",
                            hintText: "0987654321"
                        ),
                      ),
                    )



                  ],),



              ],),
          ),

        ],),
      ),

    );

  }




  Future<void> _submitPhoneNumber(String phone) async {

    String phoneNumber = "+91 " + phone;

    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
     }
     void codeSent(String verificationId, [int code]) {

      print('codeSent $verificationId');
      context.open(OtpUI(phoneNumber: phone,));

    }
    void codeAutoRetrievalTimeout(String verificationId) {

      print('codeAutoRetrievalTimeout');
    }

    await FirebaseAuth.instance.verifyPhoneNumber(

      phoneNumber: phoneNumber,
      timeout: Duration(milliseconds: 10000),
      verificationCompleted: verificationCompleted,
       /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,
     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }









}