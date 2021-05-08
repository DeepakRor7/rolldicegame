import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rolldicegame/ui/dashboard/DashboardUI.dart';
import 'package:rolldicegame/ui/login/LoginUI.dart';
import 'package:rolldicegame/ui/login/bloc/ValidationBloc.dart';
import 'package:rolldicegame/utils/AppConstants.dart';

class OtpUI extends StatelessWidget {
  final String phoneNumber;
  final String verificationID;

  OtpUI({Key key, this.phoneNumber, this.verificationID}) : super(key: key);

  final TextEditingController _controllerOTP = TextEditingController();
  AuthCredential _phoneAuthCredential;

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
                backgroundColor: snapshot.data ? Colors.blue : Colors.grey,
                label: Text("Verify Mobile"),
                onPressed: () {
                  if (snapshot.data) _login(context);
                },
              );
            }),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: context.logoIconWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "OTP",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              "We have sent otp to you give mobile number $phoneNumber")),
                      InkWell(
                        onTap: () {
                          context.openReplace(LoginUI());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.edit),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 134,
                        child: TextField(
                          controller: _controllerOTP,
                          keyboardType: TextInputType.number,
                          onChanged: (t) {
                            validBloc.validateOTP(t);
                          },
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "6 digit OTP",
                              hintText: "- - - - - -"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  /// This method is used to login the user
  /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
  /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)

  Future<void> _login(BuildContext context) async {
    /// get the `smsCode` from the user
    String smsCode = _controllerOTP.text.toString().trim();

    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    this._phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationID, smsCode: smsCode);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((AuthResult authRes) {


        if (authRes.user != null) {
          context.openReplace(DashboardUI());
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
