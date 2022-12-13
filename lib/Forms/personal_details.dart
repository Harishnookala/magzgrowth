import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../UserScreens/userPannel.dart';
import '../repositories/authentication.dart';
import 'Address.dart';

class personal_details extends StatefulWidget {
  String?phonenumber;
   personal_details({Key? key, this.phonenumber}) : super(key: key);

  @override
  _personal_detailsState createState() => _personal_detailsState();
}

class _personal_detailsState extends State<personal_details> {
  TextEditingController? mobileController;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController =TextEditingController();
  SharedPreferences? prefs ;
  bool? error = true;
  List gender = ['Male','Female'];
   List martialStatus = ["Married","Unmarried"];
   String? selected_value;
   String?date;
   String? status;
  DateTime? pickupDate;
  Authentication authentication = Authentication();
  bool login_success = false;
  final formKey = GlobalKey<FormState>();
  @override
    void initState() {
    mobileController = TextEditingController();
    mobileController!.text = widget.phonenumber!;
    BackButtonInterceptor.add(myInterceptor);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    mobileController!.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Container(
          margin: const EdgeInsets.all(12.3),
             child: Form(
               key: formKey,
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height/16),
                    Divider(height: 1, thickness: 1.5, color: Colors.green.shade400),
                    Container(
                        margin: EdgeInsets.all(5.3),
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 6.3, ),
                            child: const Text(
                              "Personal Details",
                              style: TextStyle(
                                  letterSpacing: 0.6,
                                  color: Colors.indigoAccent,
                                  fontFamily: "Poppins-Light",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ))),
                    Divider(height: 1, thickness: 1.5, color: Colors.green.shade400),
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 12.3),
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left:16.3,bottom: 8.5),
                            child: const Text(
                              "Mobile number : -",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 15,
                                  letterSpacing: 0.6,
                                  fontFamily: "Poppins-Light"),
                            ),
                          ),
                           Container(
                             margin: EdgeInsets.only(left: 16.3,right: 16.3,bottom: 5.6),
                             child: build_mobile(),),
                          Container(
                            margin: const EdgeInsets.only(left: 16.3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: const Text(
                                    "Name : -",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 15,
                                        letterSpacing: 0.8,
                                        fontFamily: "Poppins-Light"),
                                  ),
                                  margin: EdgeInsets.only(bottom: 8.5),
                                ),
                                build_name(),
                                SizedBox(height: 5,),
                                Container(
                                  child: const Text(
                                    "Email : -",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 15,
                                        letterSpacing: 0.8,
                                        fontFamily: "Poppins-Light"),
                                  ),
                                  margin: EdgeInsets.only(bottom: 8.5),
                                ),
                                SizedBox(height: 5,),
                                build_email(),
                                SizedBox(height: 8,),
                                build_button(),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
             ),


        ),
      ),
    );
  }

  build_name() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.2,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(fontFamily: "Poppins-Light",),
        validator: (name){
          if(name==null||name.isEmpty){
            return "please enter name";
          }
          return null;
        },
        controller: nameController,
        decoration: InputDecoration(
            contentPadding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: " Enter Name",
            labelText: " Name",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
      ),
    );
  }

  build_mobile() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.2,
      child: TextFormField(
        readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding:  EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "Mobile",
            labelText: "Mobile number",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller:mobileController,
        cursorColor: Colors.orange,
        style: const TextStyle(color: Colors.grey,fontFamily: "Poppins",
            letterSpacing: 1.0,
        ),
        validator: (phone) {
          bool validate = validatePhone(phone!);
          if (phone.isEmpty) {
            return 'Please enter phone';
          } else if (!validate) {
            return "Enter a valid phone number";
          }  else if (phone.length!= 10) {
            return "Enter 10 numbers";
          }
          return null;
        },
      ),
    );
  }
  build_button() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: Size(80, 20),
            elevation: 1.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.6)),
        ),
        onPressed: () async {
          prefs = await SharedPreferences.getInstance();
             if(formKey.currentState!.validate()){
                Map<String,dynamic> details = {
                  "Name" : nameController.text,
                  "mobilenumber" : widget.phonenumber,
                  "email" : emailController.text
                };
                await FirebaseFirestore.instance.collection("Users").add(details);
                prefs!.setString('phonenumber', widget.phonenumber!);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return userPannel(
                        phonenumber: widget.phonenumber,
                      );
                    }));
             }
           },
        child: Container(
          width: 160,
           height: 25,
           alignment: Alignment.center,
           margin: EdgeInsets.only(left: 5.3,right: 5.3),
            child: Text("Submit",
              style: TextStyle(fontSize:17.5,color: Colors.white,
                  fontFamily: "Poppins-Medium"),)),
      ),
    );
  }

  validatePhone(String phone) {
    bool passValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone);

    if (passValid) {
      return true;
    } else {
      return false;
    }
  }

  get_data(String mobilenumber) async{
    var Users = await FirebaseFirestore.instance.collection("Users").get();
    for(int i =0;i<Users.docs.length;i++){
      if(mobilenumber == Users.docs[i].get("mobilenumber")){
        return mobilenumber;
      }
    }
    return null;
  }

  build_email() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.2,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(fontFamily: "Poppins-Light",),
        validator: (email){
          if(email==null||email.isEmpty){
            return "please enter Email";
          }
          else if(!EmailValidator.validate(emailController.text)&&email.isNotEmpty){
            return "Please enter valid Email Address";
          }
          return null;
        },
        controller: emailController,
        decoration: InputDecoration(
            contentPadding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "Enter email address",
            labelText: "Email",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
      ),
    );
  }
}

