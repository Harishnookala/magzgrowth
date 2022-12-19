import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:magzgrowth/Custom_widgets/wrappers.dart';
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
  File? _profilePicFile;

  void _directUpdateImage(File? file) async {
    if (file == null) return;
    setState(() {
      _profilePicFile = file;
    });
  }
  @override
  Widget build(BuildContext context) {
    print(phoneNumber);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(96, 46),
                bottomRight: Radius.circular(30.6))),
        elevation: 1.6,
        centerTitle: true,
        title: Container(
          child: Text(
            "Account",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins-Medium",
                letterSpacing: 0.5,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Container(
        color: Colors.white,
        margin: EdgeInsets.all(12.3),
          child: Column(children: [
                    FutureBuilder<DocumentSnapshot?>(
                      future: authentication.users(phoneNumber),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          var details  = snapshot.data;
                          return Column(
                            children: [
                              Container(

                                child: Row(
                                  children: [
                                    Container(
                                      margin:EdgeInsets.only(right:12.3),
                                      child: EditableImage(
                                        onChange: (file) => _directUpdateImage(file),

                                        image: _profilePicFile != null
                                            ? Image.file(_profilePicFile!, fit: BoxFit.cover)
                                            : null,
                                        size: 80.0,
                                        imagePickerTheme: ThemeData(
                                          primaryColor: Colors.white,
                                          iconTheme: const IconThemeData(color: Colors.black87),
                                        ),
                                        imageBorder: Border.all(color: Colors.blue, ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          child: Text(details!.get("Name"),
                                              style: TextStyle(color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                 fontSize: 16,
                                                fontFamily: "Poppins"
                                              )),
                                        ),
                                        Container(
                                          child: Text(details.get("mobilenumber"),
                                              style: TextStyle(color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: "Poppins"
                                              )),
                                        ),
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          );
                        }return Container();
                      },
                    ),
                SizedBox(height: 16,),
              Divider(height: 1.5,color: Colors.grey.shade400,),
             SizedBox(height: 10,),
             TextIcon(
               leading: Icon(Icons.dataset_linked_sharp,color: Colors.black,),
               title: Text("eKYC",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
             ),
            TextIcon(
              leading: Icon(Icons.account_balance,color: Colors.black),
              title: Text("Bank details",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
            ),
            TextIcon(
              leading: Icon(Icons.person_add_alt_outlined,color: Colors.black,),
              title: Text("Add Nominee",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
              onTap: (){

              },
            ),
            TextIcon(
              leading: Icon(Icons.task_alt,color: Colors.black),
              title: Text("Terms & conditions",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
            ),
            TextIcon(
              leading: Icon(Icons.lock_clock_outlined,color: Colors.black,),
              title: Text("Privacy Policy",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
            )
      ])),
    );
  }

}
