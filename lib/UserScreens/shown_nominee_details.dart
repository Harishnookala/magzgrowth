import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magzgrowth/repositories/authentication.dart';
class nominee_details extends StatefulWidget {
  String?phonenumber;
   nominee_details({Key? key,this.phonenumber}) : super(key: key);

  @override
  State<nominee_details> createState() => _nominee_detailsState();
}

class _nominee_detailsState extends State<nominee_details> {
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(45))),
        elevation: 1.6,
        centerTitle: true,
        title: Container(
          child: Text(
            "nominee Details",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins-Medium",
                letterSpacing: 0.5,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body:  Container(
        child: Column(
          children: [
            SizedBox(height: 5,),
            FutureBuilder<DocumentSnapshot?>(
              future: authentication.nominee(widget.phonenumber),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var details = snapshot.data;
                  return Container(
                    margin: EdgeInsets.only(left: 12.3,right: 12.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Divider(color: Colors.black26,thickness:1.0),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(details!.get("username"),style: TextStyle(
                                  color: Colors.black, fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.6,
                                  fontSize: 15
                              ),),
                              Text(details.get("userPhoneNumber"),style: TextStyle(
                                  color: Colors.black, fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.6,
                                  fontSize: 15
                              ),),
                            ],
                          ),
                          margin: EdgeInsets.only(left: 16.3,right: 16.3),
                        ),
                        Divider(color: Colors.black26,thickness:1.0),
                        SizedBox(height: 20,),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Name : -",
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              Container(
                                child: Text(
                                  details.get("Name"),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(margin: EdgeInsets.symmetric(vertical: 10),),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Email Id : -",
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              Container(
                                child: Text(
                                  details.get("email"),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(margin: EdgeInsets.symmetric(vertical: 10),),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "mobilenumber : -",
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              Container(
                                child: Text(
                                  details.get("phonenumber"),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(margin: EdgeInsets.symmetric(vertical: 10),),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Relationship : -",
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              Container(
                                child: Text(
                                  details.get("relation"),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(margin: EdgeInsets.symmetric(vertical: 10),),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Aadhar number : -",
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              Container(
                                child: Text(
                                  details.get("Aadhaarnumber"),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
