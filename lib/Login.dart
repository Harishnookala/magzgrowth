import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Forms/personal_details.dart';
import 'UserScreens/userPannel.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mobile = TextEditingController();
  TextEditingController _otp = TextEditingController();
  String? verificationId;
  bool inProgress = false;
  String errorMessage = "";
  bool error = false;
  User? user;
  SharedPreferences? prefs;
  String? status;
  var id;
  var mobilenumber;
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Text("Welcome",
                            style: Theme.of(context).textTheme.headline5),
                        Text("Please Login First",
                            style: Theme.of(context).textTheme.headline5),
                        SizedBox(height: 40,),
                        Padding(
                          padding: EdgeInsets.only(left: 25.3, right: 25.3),
                          child: TextField(
                            style: TextStyle(fontSize: 16.6,
                                color: Colors.black,
                                fontFamily: "Poppins-Light"),
                            controller: _mobile,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightGreen, width: 1.8),
                                    borderRadius: BorderRadius.circular(12.0)
                                ),
                                hintText: "Enter your mobile number",
                                labelText: " Phonenumber",
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 13.6,
                                    letterSpacing: 1.0,
                                   fontFamily: "Poppins-Light"
                                ),
                                enabledBorder:  OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.greenAccent, width: 1.5),
                                  borderRadius: BorderRadius.circular(13.5),),
                                hintStyle: const TextStyle(
                                    color: Colors.brown, fontSize: 13,
                                    fontFamily: "Poppins-Medium")),
                          ),
                        ),
                        verificationId==null?SizedBox(height: 20,):Container(),
                        if (verificationId != null) ...[
                          SizedBox(
                            height: 7.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.3, right: 25.3, bottom: 12.3),
                            child: TextField(
                              style: TextStyle(fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: "Poppins-Light"),
                              controller: _otp,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 20.0),
                                  focusedBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.lightGreen, width: 1.8),
                                      borderRadius: BorderRadius.circular(12.0)
                                  ),
                                  hintText: "Enter Otp",
                                  labelText: "Otp",
                                  labelStyle:
                                  TextStyle(color: Color(0xcc576630),fontSize: 15.6,
                                      fontFamily: "poppins-Medium",letterSpacing: 1.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35.0),),
                                  enabledBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff5E099BEA), width: 2.0),
                                      borderRadius:BorderRadius.circular(12.0)
                                  ),
                                  hintStyle: const TextStyle(color: Colors.brown,
                                      fontSize: 13,fontFamily: "Poppins-Medium")),
                            ),
                          )
                        ],
                        verificationId != null
                            ? Container(
                          padding: EdgeInsets.only(bottom: 13),
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              get_otp(verificationId);
                            },
                            child: const Text(
                              "Resend Otp",
                              style: TextStyle(
                                  color: Colors.pinkAccent,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                            : Container(),
                        GestureDetector(
                          onTap: () async {
                            get_data();
                          },
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8.5),
                            decoration: BoxDecoration(
                                color: Colors.blue.shade700,
                                borderRadius:
                                BorderRadius.all(const Radius.circular(20.0))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text((this.verificationId == null)
                                        ? "Send OTP"
                                        : "Validate OTP",
                                    style: TextStyle(
                                        fontSize: 15.6,
                                        color: Colors.white,
                                        fontFamily: "Poppins-Medium",
                                        fontWeight: FontWeight.w600)),
                                inProgress
                                    ? Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: CircularProgressIndicator())
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 5),
                            child: Text(
                              errorMessage,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                  color: Colors.red,
                                  fontFamily: "Poppins-Medium"),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  String? phoneValidator(String input) {
    final String regexSource = r'[0-9]{10}';
    RegExp regExp = RegExp(regexSource);
    if (input.trim().isEmpty)
      return "Please enter valid phone number";
    if (!regExp.hasMatch(input) && input.length != 10)
      return "Please enter valid phone number";
    return null;
  }

  get_data() async {
    prefs = await SharedPreferences.getInstance();
    bool validate = false;
    var id;
    setState(() {
      errorMessage = "";
      error = false;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    if (phoneValidator(_mobile.text) != null) {
      setState(() {
        errorMessage = phoneValidator(_mobile.text)!;
        error = true;
      });
      return;
    }
    if (verificationId == null) {
      setState(() {
        inProgress = true;
      });
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + _mobile.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          var userCredential = await auth.signInWithCredential(credential);
          var user = userCredential.user!.providerData[0].phoneNumber;
          if (user!=null) {
            var users = await FirebaseFirestore.instance.collection("Users").get();
            for(int i =0;i<users.docs.length;i++){
              if(users.docs[i].data()["mobilenumber"]==_mobile.text){
                validate = true;
                id = users.docs[i].id;
              }
            }
            if(validate){
              print("Second Time");
              prefs!.setString('phonenumber', _mobile.text);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return userPannel(id: id,
                      phonenumber: _mobile.text,);
                  }));
            }else{
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return personal_details(
                      phonenumber: _mobile.text,
                    );
                  }));
            }
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            inProgress = true;
            errorMessage = e.message!;
            error = true;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            errorMessage = "Please enter the OTP sent to your mobile number.";
            error = false;
            inProgress = false;
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String? verificationId) {},
      );
    } else {
      if (this.verificationId != null) {
        if (_otp.text.isEmpty || _otp.text.length < 6) {
          setState(() {
            errorMessage =
            "Please enter a valid OTP.\nIt should be at least 6 digits.";
          });
          return;
        }
        setState(() {
          inProgress = true;
        });
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId!, smsCode: _otp.text);
        try {
          UserCredential user = await auth.signInWithCredential(credential);
          if (user.user!=null) {
            var users = await FirebaseFirestore.instance.collection("Users").get();
            for(int i =0;i<users.docs.length;i++){

              if(users.docs[i].data()["mobilenumber"]==_mobile.text){
                validate = true;
                id = users.docs[i].data()["id"];
              }
            }
            if(validate){
              prefs!.setString('phonenumber', _mobile.text);
              print("Second Time");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return userPannel(
                      id: id,
                      phonenumber: _mobile.text,
                    );
                  }));
            }else{
              print("First Time");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return personal_details(
                      phonenumber: _mobile.text,
                    );
                  }));
            }
          }
          if (user.user!.phoneNumber != null) {
            setState(() {
              inProgress = false;
            });
          }
        } catch (e) {
          setState(() {
            inProgress = false;
            errorMessage = "Failed to validate OTP";
          });
        }
      }
    }
  }

  get_otp(String? verificationId) async {
    prefs = await SharedPreferences.getInstance();
    bool validate = false;
    FirebaseAuth auth = FirebaseAuth.instance;
    var users = await FirebaseFirestore.instance.collection("Users").get();
    if (verificationId != null) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + _mobile.text,
        timeout: const Duration(seconds: 20),
        verificationCompleted: (PhoneAuthCredential credential) async {
          var userCredential = await auth.signInWithCredential(credential);
          var user = userCredential.user!.providerData[0].phoneNumber;

        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            errorMessage = e.message!;
            error = true;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            errorMessage = "Please enter the OTP sent to your mobile number.";
            error = false;
            inProgress = false;
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String? verificationId) {},
      );
    } else {
      if (this.verificationId != null) {
        if (_otp.text.isEmpty || _otp.text.length < 6) {
          setState(() {
            errorMessage =
            "Please enter a valid OTP.\nIt should be at least 6 digits.";
          });
          return;
        }

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId!, smsCode: _otp.text);

        try {
          UserCredential user = await auth.signInWithCredential(credential);
          if (user != null) {
            for(int i =0;i<users.docs.length;i++){
              if(users.docs[i].data()["mobilenumber"]==_mobile.text){
                validate = true;
                id = users.docs[i].id;
              }
            }
            if(validate){
              prefs!.setString('phonenumber', _mobile.text);
              print("Second Time");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return userPannel(
                      id: id,
                      phonenumber: _mobile.text,
                    );
                  }));
            }else{
              print("First Time");
              print(_mobile.text);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return personal_details(
                      phonenumber: _mobile.text,
                    );
                  }));
            }
          }
          if (user.user!.phoneNumber != null) {
            setState(() {
              inProgress = false;
            });
          }
        } catch (e) {
          setState(() {
            errorMessage = "Failed to validate OTP";
          });
        }
      }
    }
  }
}
