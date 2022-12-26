import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Forms/edit_bankdetails.dart';
import '../repositories/authentication.dart';

class Banking extends StatefulWidget {
  String? bank_id;
  String? phoneNumber;
  Banking({this.bank_id, this.phoneNumber});
  @override
  _BankingState createState() => _BankingState(phoneNumber: this.phoneNumber);
}

class _BankingState extends State<Banking> {
  String? phoneNumber;
  _BankingState({this.phoneNumber});
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
            "Bank Details",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins-Medium",
                letterSpacing: 0.5,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.all(12.3),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.lightBlue,width: 2.5)),
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left:12.3,top: 5.6),
                    child: const Text(
                      "Account details",
                      style: TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.teal,
                          fontFamily: "Poppins-Medium",
                          fontSize: 16),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  const Divider(color: Colors.blueAccent, thickness: 1.8),
                   build_data(phoneNumber),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  build_data(String? phoneNumber) {
    var id;
    return Container(
      margin: EdgeInsets.only(right: 12.3),
      child: Column(
        children: [
          FutureBuilder<DocumentSnapshot?>(
              future:  authentication.bank_inf(widget.phoneNumber),
              builder:(context,snapshot){
                if(snapshot.hasData&&snapshot.requireData!.exists){
                  var details = snapshot.data;
                  id = snapshot.data!.id;
                  return Container(
                    margin: EdgeInsets.only(top: 5.6,left: 12.3),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                         Row(
                           children: [
                             Container(child: Text("Account Holder Name : -  ",style:
                             TextStyle(letterSpacing:1.0,fontFamily: "Poppins")),
                             ),
                             Container(child: Text(details!.get("holderName"),style:
                               TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,
                                letterSpacing: 1.0,fontSize: 15
                               )
                             ),),
                           ],
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         ),
                        SizedBox(height: 14,),
                        Container(
                          child: Row(
                            children: [
                              Text("Account Number :- ",style: TextStyle(letterSpacing:1.0,fontFamily: "Poppins"),),
                              Container(
                                child: Text(details.get("accountnumber"),
                                    style: TextStyle(letterSpacing: 1.0,fontSize: 16.5)),
                                margin: EdgeInsets.only(left: 15.3),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                         SizedBox(height: 20,),
                        Container(
                          child: Row(
                            children: [
                              Text("Ifsc :- ".toUpperCase(),style: TextStyle(letterSpacing: 1.0,fontFamily: "Poppins"),),
                              Container(
                                child: Text(details.get("ifsc"),style: TextStyle(letterSpacing: 1.0,fontSize: 16)),
                                margin: EdgeInsets.only(left: 15.3),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: SizedBox(
                            height:38,
                            width:100,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  elevation: 1.0,
                                    backgroundColor: Colors.brown.shade400,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.3))
                                ),
                                onPressed: (){
                                  Navigator.push (
                                    context,
                                    MaterialPageRoute (
                                      builder: (BuildContext context) => edit_details(id: id,
                                        phonenumber:widget.phoneNumber,
                                        Accountnumber: details.get("accountnumber"),
                                        ifsc: details.get("ifsc"),
                                      ),
                                    ),
                                  );
                                }, child: const Text("Edit",style: TextStyle(color: Colors.white,fontFamily:"Poppins-Medium",
                                fontWeight: FontWeight.bold,letterSpacing: 1.0,fontSize: 15.6),),

                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  );
                }
                return CircularProgressIndicator();
              }),

        ],
      ),
    );
  }
}
