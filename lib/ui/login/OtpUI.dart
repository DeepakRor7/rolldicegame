
import 'package:flutter/material.dart';
import 'package:rolldicegame/ui/login/LoginUI.dart';
import 'package:rolldicegame/ui/login/bloc/ValidationBloc.dart';

import 'package:rolldicegame/utils/AppConstants.dart';

class OtpUI  extends StatelessWidget{


  final String phoneNumber;
  OtpUI({Key key, this.phoneNumber}) : super(key: key);

  final TextEditingController _controllerPhoneNumber =
  TextEditingController();


  var validBloc = ValidationBloc();
  @override
  Widget build(BuildContext context) {

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

                label: Text("Verify Mobile"), onPressed: () {



              },);
            }
        ),
      ),

      body: Container(
        child: ListView(children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(top: 160),
            child: context.logoIconWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text("OTP",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600) ,),
                Row(
                  children: [
                    Expanded(child: Text("We have sent otp to you give mobile number $phoneNumber")),
                    InkWell(
                      onTap: (){
                        context.openReplace(LoginUI());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.edit),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,) ,

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      width: MediaQuery.of(context).size.width - 134,
                      child: TextField(
                        controller: _controllerPhoneNumber,
                        keyboardType: TextInputType.number,
                        onChanged: (t){
                          validBloc.validateOTP(t);
                        },
                        style: TextStyle(
                            fontSize: 20
                            , color: Colors.black),
                        decoration: InputDecoration(

                            labelText: "6 digit OTP",
                            hintText: "- - - - - -"
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









}