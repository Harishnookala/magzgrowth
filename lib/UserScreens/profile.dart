import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Forms/edit_profile.dart';
import '../repositories/authentication.dart';
class Profile extends StatefulWidget {
  String?phoneNumber;
  String?id;
   Profile({Key? key,this.phoneNumber,this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(phoneNumber:phoneNumber);
}

class _ProfileState extends State<Profile> {
  String?phoneNumber;
  _ProfileState({this.phoneNumber});
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.3),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/16),
          Container(
            alignment: Alignment.topLeft,
            child: const Text("Profile Details",style: TextStyle(color: Colors.green,fontSize:16,fontWeight: FontWeight.w500),),
          ),
          Divider(color: Colors.grey,thickness: 0.6,),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView(
             physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Container(
                  child: Container(
                    child: Column(
                      children:  [
                        FutureBuilder<DocumentSnapshot?>(
                          future: authentication.users(widget.phoneNumber),
                          builder: (context,snap){
                            if(snap.hasData){
                              var users = snap.data;
                              return Container(
                                decoration: BoxDecoration(border: Border.all(color: Colors.green,width: 1.5)),
                                child: Container(
                                  margin: EdgeInsets.all(12.3),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 20.3,top: 20.3),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Username :-",style: TextStyle(fontSize: 15,letterSpacing: 1.0,fontWeight: FontWeight.w400,fontFamily: "Poppins-Medium"),),
                                            users!.get("username")!=null?Text(users.get("username",),style: TextStyle(fontSize: 15,letterSpacing: 1.0)):Container()
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Name :-",style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.w400,fontFamily: "Poppins-Medium"),),
                                            Text(users.get("firstname"),)
                                          ],
                                        ),
                                        margin: EdgeInsets.only(bottom: 20.3),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text("Gender:-",style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.w400,fontFamily: "Poppins-Medium")),
                                            Text(users.get("gender"))
                                          ],
                                        ),
                                        margin: EdgeInsets.only(bottom: 20.3),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text("Mobilenumber:-",style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.w400,fontFamily: "Poppins-Medium")),
                                            Text(users.get("mobilenumber"))
                                          ],
                                        ),
                            margin: EdgeInsets.only(bottom: 20.3),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text("Email:-",style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.w400,fontFamily: "Poppins-Medium")),
                                            Container(
                                                child: Text(users.get("email")),
                                            )
                                          ],
                                        ),
                                        margin: EdgeInsets.only(bottom: 20.3),

                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text("Dateofbirth:-",style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.w400,fontFamily: "Poppins-Medium")),
                                            users.get("dateofbirth".toString())==null?Container():Text(users.get("dateofbirth"))
                                          ],
                                        ),
                                        margin: EdgeInsets.only(bottom: 20.3),

                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text("Status:-",style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.w400,fontFamily: "Poppins-Medium")),
                                            Text(users.get("status"))
                                          ],
                                        ),
                                        margin: EdgeInsets.only(bottom: 20.3),

                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text("Address:-",style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.w400,fontFamily: "Poppins-Medium")),
                                            Container(
                                                width:160,
                                                child: Text(users.get("address")))
                                          ],
                                        ),
                                        margin: EdgeInsets.only(bottom: 20.3),

                                      ),
                                      SizedBox(height: 20,),
                                      Center(
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                minimumSize: const Size(120, 20),
                                                backgroundColor: Colors.limeAccent,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.3))
                                            ),
                                            onPressed: (){
                                              var id = users.id;
                                              Navigator.push (
                                                context,
                                                MaterialPageRoute (
                                                  builder: (BuildContext context) => edit_profile(id: id,
                                                      mobilenumber:users.get("mobilenumber"),
                                                     email :users.get("email"),
                                                    status :users.get('status'),
                                                    address:users.get("address"),
                                                    username:users.get("username")
                                                  ),
                                                ),
                                              );
                                            }, child: const Text("Edit",style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w600),)),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }return CircularProgressIndicator();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),



        ],
      ),
    );
  }
}
