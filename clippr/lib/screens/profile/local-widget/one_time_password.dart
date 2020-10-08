import 'package:clippr/widgets/text_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../main_navigation_screen.dart';
import '../profile.dart';

class OneTimePassword extends StatefulWidget {
  final String _phoneNumber;
  final AuthCredential _phoneAuthCredential;
  final String _verificationId;
  final int _code;
  OneTimePassword(this._phoneNumber, this._phoneAuthCredential,
      this._verificationId, this._code);

  @override
  _OneTimePasswordState createState() => _OneTimePasswordState(
      this._phoneNumber,
      this._phoneAuthCredential,
      this._verificationId,
      this._code);
}


class _OneTimePasswordState extends State<OneTimePassword> {
  final String _phoneNumber;
  AuthCredential _phoneAuthCredential;
  final String _verificationId;
  final int _code;
  _OneTimePasswordState(this._phoneNumber, this._phoneAuthCredential,
      this._verificationId, this._code);
  var _isLoggedIn;

  TextEditingController _otpController = TextEditingController();

  User _firebaseUser;
  String _status;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _login() async {
    /// This method is used to login the user
    /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
    /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((UserCredential authRes) {
        _firebaseUser = authRes.user;
        print(_firebaseUser.toString());
      });
      await FirebaseFirestore.instance
      .collection('users')
      .doc(_firebaseUser.uid)
      .set({
        'firstName': '',
        'email' : _phoneNumber,
        'phone': '',
        'grade': '',
        'profilePicture' : '',
      });
      setState(() {
        _status = 'Signed In\n';
        print('Signed In');
      });
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _status = e.toString() + '\n';
      });
      print(e.toString());
    }
  }

  

  void _submitOTP() {
    /// get the `smsCode` from the user
    String smsCode = _otpController.text.toString().trim();
    print(smsCode);

    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    _phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);

    _login();
  }

  @override
  Widget build(BuildContext context) {
    print('OTP-Page _phoneNumber : ' + '$_phoneNumber');
    print('OTP-Page _phoneAuthCredential : ' + '$_phoneAuthCredential');
    print('OTP-Page _verificationId : ' + '$_verificationId');
    print('OTP-Page _code : ' + '$_code');

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextSection('Code envoyé !',
                'Nous avons envoyé un code de vérificatin au $_phoneNumber'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: PinCodeTextField(
                appContext: (context),
                controller: _otpController,
                backgroundColor: Colors.transparent,
                length: 6,
                autoFocus: true,
                onCompleted: (value) {
                  print('completed');
                  _submitOTP();
                },
                onChanged: (String value) {},
              ),
            ),

            /*TextField(
              controller: _otpController,
              decoration: InputDecoration(
                hintText: 'Code de vérification',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),*/
            SizedBox(height: 15),
            /*SizedBox(
              width: double.infinity,
              child: FlatButton(
                /*onPressed: () {
                      Navigator.pushNamed(context, '/login-methods');
                    },*/
                onPressed: _submitOTP,
                child: Text('Continuer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                color: Colors.blue[900],
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
