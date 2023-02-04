import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magzgrowth/repositories/common_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
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
  var id;
  var mobilenumber;
  String otpCode = "";
  String otp = "";
  bool status = false;
  String? verify="";
  final formKey = GlobalKey<FormState>();
  int count =0;
  @override
  void initState() {
    super.initState();
    _listenOtp();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode();
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
                          Container(height: 60,),
                          Text("Welcome",
                              style: Theme.of(context).textTheme.headlineSmall),
                          Text("Please Login First",
                              style: Theme.of(context).textTheme.headlineSmall),
                          SizedBox(height: 40,),
                          Column(
                            children: [
                              Container(
                                child: Text("Enter Phonenumber : -",style: TextStyle(color: Colors.purpleAccent,
                                    fontSize: 15.3,letterSpacing: 1.0,
                                    fontFamily: "Poppins"
                                ),),
                                padding: EdgeInsets.only(left: 25.3, right: 25.3,bottom: 12.3),
                                alignment: Alignment.topLeft,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25.3, right: 25.3),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 18.6,
                                      color: Colors.black87,
                                      fontFamily: "Poppins-Light"),
                                  controller: _mobile,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20.0),
                                      focusedBorder:  OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.lightGreen, width: 1.8),
                                          borderRadius: BorderRadius.circular(12.0)
                                      ),
                                      hintText: "Enter your mobile number",
                                      labelStyle: const TextStyle(
                                          color: Colors.black, fontSize: 16.6,
                                          letterSpacing: 1.0,
                                          fontFamily: "Poppins-Light"
                                      ),
                                      enabledBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.lightGreen, width: 1.5),
                                        borderRadius: BorderRadius.circular(13.5),),
                                      hintStyle: const TextStyle(
                                          color: Colors.brown, fontSize: 15.6,
                                          fontFamily: "Poppins-Medium")),
                                ),
                              ),
                            ],
                          ),
                          status==true?Column(
                            children: [
                              Container(
                                child: Text("Enter Otp : -",style: TextStyle(color: Colors.purpleAccent,
                                  fontSize: 15.3,letterSpacing: 1.0,
                                  fontFamily: "Poppins-Medium"
                                ),),
                                padding: EdgeInsets.only(left: 25.3, right: 25.3),
                                alignment: Alignment.topLeft,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
                                  child: PinFieldAutoFill(
                                    controller: _otp,
                                    currentCode: otpCode,
                                    decoration: BoxLooseDecoration(
                                      strokeWidth: 1.8,
                                        textStyle: TextStyle(color: Colors.black,fontSize: 21),
                                        strokeColorBuilder: PinListenColorBuilder(Colors.brown,Colors.purple)),
                                    codeLength: 6,
                                    onCodeChanged: (code) {
                                      otpCode = code.toString();
                                    },
                                    onCodeSubmitted: (val) {
                                    },
                                  )),
                            ],
                          ):Container(),
                          Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
                              child: Text(
                                errorMessage,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                    color: Colors.red,
                                    fontFamily: "Poppins-Medium"),
                                textAlign: TextAlign.center,
                              )),

                           build_button(),
                          SizedBox(height: 30,),

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
      return "Please enter  phone number";
    if (!regExp.hasMatch(input) && input.length != 10)
      return "Please enter valid phone number";
    return null;
  }

  build_button() {
    return Container(
      margin: EdgeInsets.only(top: 12.3),
      child: TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size(180, 55),
              elevation: 1.5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.3)),
              backgroundColor: Colors.indigoAccent),
          onPressed: () async{
            setState(()  {
              if(phoneValidator(_mobile.text)!=null){
                errorMessage = phoneValidator(_mobile.text)!;
              }else if(count==0&&status==false){
                status = true;
                CommonUtils.firebasePhoneAuth(phone: "+91"+_mobile.text, context: context);
                count++;
                errorMessage ="";
              }
            },);
            if(status ==true){
              final FirebaseAuth auth = FirebaseAuth.instance;
              try {
                PhoneAuthCredential credential =
                PhoneAuthProvider.credential(
                    verificationId: CommonUtils.verify,
                    smsCode: otpCode);
                await auth.signInWithCredential(credential);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>  userPannel(phonenumber: _mobile.text,)));
              } catch (e) {
                setState(() {
                  if(_otp.text.isEmpty)
                    errorMessage =  "Please enter  OTP";
                  else
                    errorMessage = "Failed to  validate Otp";
                });
              }
            }
          },
          child:Text(status==false?"Send Otp":"Validate Otp",style: TextStyle(color: Colors.white,
              fontSize: 17,fontFamily:"Poppins-Medium",letterSpacing: 0.9),)),
    );
  }

/*
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return userPannel(
                      id: id,
                      phonenumber: _mobile.text,
                    );
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
*/

}
