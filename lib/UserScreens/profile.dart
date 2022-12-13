import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Forms/edit_profile.dart';
import '../repositories/authentication.dart';

class Profile extends StatefulWidget {
  String? phoneNumber;
  String? id;
  Profile({Key? key, this.phoneNumber, this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(phoneNumber: phoneNumber);
}

class _ProfileState extends State<Profile> {
  String? phoneNumber;
  _ProfileState({this.phoneNumber});
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60.6), bottomRight: Radius.circular(60.6))),
         elevation: 1.6,
         centerTitle: true,
         title: Container(
           child: Text("Account",style: TextStyle(color: Colors.white,
               fontFamily: "Poppins-Medium",letterSpacing: 0.5,
               fontSize: 18,fontWeight: FontWeight.w600
           ),),
         ),
      ),
    );

  }
}
