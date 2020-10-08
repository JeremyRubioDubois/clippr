import 'package:clippr/screens/profile/auth/facebook_auth.dart';
import 'package:clippr/screens/profile/auth/google_auth.dart';
import 'package:clippr/screens/profile/local-widget/one_time_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginMethods extends StatefulWidget {
  LoginMethods({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginMethodsState createState() => _LoginMethodsState();
}

class _LoginMethodsState extends State<LoginMethods> {
  TextEditingController _phoneNumberController = TextEditingController();
  String _countryCode = '+33';

  User _firebaseUser;
  String _status;

  AuthCredential _phoneAuthCredential;
  String _verificationId;
  int _code;

  @override
  void initState() {
    super.initState();
    _getFirebaseUser();
  }

  Future<void> _getFirebaseUser() async {
    this._firebaseUser = await FirebaseAuth.instance.currentUser;
    if (_firebaseUser != null) {
      setState(() {
        _status = 'Utilisateur connecté';
      });
      print(_status);
    } else {
      setState(() {
        _status = 'Utilisateur non connecté';
      });
      print(_status);
    }
  }

  void _onCountryChange(CountryCode countryCode) {
    print("Nouveau pays selectionné : " + countryCode.toString());
    _countryCode = countryCode.toString();
  }

  Future<void> _submitPhoneNumber() async {
    /// NOTE: Either append your phone number country code or add in the code itself
    /// Since I'm in India we use "+91 " as prefix `phoneNumber`
    String phoneNumber =
        _countryCode + _phoneNumberController.text.toString().trim();
    print(phoneNumber);

    /// The below functions are the callbacks, separated so as to make code more redable
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      setState(() {
        _status += 'verificationCompleted\n';
      });
      this._phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      print('verificationFailed');
      setState(() {
        _status += '$error\n';
      });
      print(error);
    }

    void codeSent(String verificationId, [int code]) {
      print('codeSent');
      this._verificationId = verificationId;
      print(verificationId);
      this._code = code;
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return FractionallySizedBox(
                heightFactor: 0.80,
                child: OneTimePassword(
                    phoneNumber, _phoneAuthCredential, verificationId, code));
          }).whenComplete(() => Navigator.pop(context));
      print(code.toString());
      print("test");
      setState(() {
        _status += 'Code Sent\n';
      });
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
      });
      print(verificationId);
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: phoneNumber,

      /// `seconds` didn't work. The underlying implementation code only reads in `millisenconds`
      timeout: Duration(milliseconds: 10000),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: verificationFailed,

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,

      /// After automatic code retrival `tmeout` this function is called
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(children: [
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                left: BorderSide(color: Colors.grey[300]),
                top: BorderSide(color: Colors.grey[300]),
                right: BorderSide(color: Colors.grey[300]),
                bottom: BorderSide(color: Colors.grey[300]),
              ),
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.zero, top: Radius.circular(10.0)),
            ),
            child: CountryCodePicker(
              onChanged: _onCountryChange,
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'FR',
              favorite: ['FR'],
              // optional. Shows only country name and flag
              showCountryOnly: true,
              // optional. Shows only country name and flag when popup is closed.
              showOnlyCountryWhenClosed: true,
              flagWidth: 30,
              padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
              //hideMainText: true,
              // optional. aligns the flag and the Text left
              alignLeft: true,
            ),
          ),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 20),
              hintText: 'Votre numéro de téléphone',
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Colors.grey[300]),
                borderRadius: BorderRadius.vertical(
                    top: Radius.zero, bottom: Radius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(height: 15),
          /*Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: TextField(
              controller: _otpController,
              decoration: InputDecoration(
                hintText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
              onPressed: _submitOTP,
              child: Text('Submit'),
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),*/
          /*MaterialButton(
        onPressed: _login,
        child: Text('Login'),
        color: Theme.of(context).accentColor,
      ),
      MaterialButton(
        onPressed: _logout,
        child: Text('Logout'),
        color: Theme.of(context).accentColor,
      ),*/
          FlatButton(
            onPressed: _submitPhoneNumber,
            child: Text('Continuer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                )),
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
          Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: <Widget>[
                Expanded(
                    child: Divider(
                  color: Colors.grey[500],
                )),
                Text("    ou    "),
                Expanded(
                    child: Divider(
                  color: Colors.grey[500],
                )),
              ])),
          SizedBox(
              width: double.infinity,
              child: FlatButton(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  onPressed: () {
                    print('Button Clicked.');
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset(
                        'assets/custom-icons/apple.svg',
                        height: 20,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Continuer avec Apple',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(width: 60),
                  ]))),
          SizedBox(height: 15),
          SizedBox(
              width: double.infinity,
              child: FlatButton(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  onPressed: () {
                    print('Google button clicked.');
                    signInWithGoogle()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/custom-icons/google.svg',
                            height: 20,
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Continuer avec Google',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(width: 60),
                  ]))),
          SizedBox(height: 15),
          SizedBox(
              width: double.infinity,
              child: FlatButton(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  onPressed: () {
                    print('Button Clicked.');
                    loginWithFacebook(context)
                        .whenComplete(() => Navigator.pop(context));
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset(
                        'assets/custom-icons/facebook.svg',
                        height: 20,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Continuer avec Facebook',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(width: 60),
                  ]))),
          SizedBox(height: 25),
        ]));
  }
}
