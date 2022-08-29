import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Forms/edit_bankdetails.dart';
import '../repositories/authentication.dart';

 class Banking extends StatefulWidget {
   String?bank_id;
   String?phoneNumber;
    Banking({this.bank_id,this.phoneNumber});
   @override
   _BankingState createState() => _BankingState(phoneNumber:this.phoneNumber);
 }

 class _BankingState extends State<Banking> {
   String?phoneNumber;
   _BankingState({this.phoneNumber});
   Authentication authentication = Authentication();
   @override
   Widget build(BuildContext context) {
     var id;
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         SizedBox(height: 40,),
         Container(
           margin: EdgeInsets.all(12.3),
           decoration: BoxDecoration(border: Border.all(color: Colors.lightBlue)),
             child: Container(
               alignment: Alignment.topLeft,
               margin: EdgeInsets.only(top: 8.6),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:  [
                   Container(
                       child: const Text("Banking Details",style: TextStyle(letterSpacing:2.0,color: Colors.teal,fontFamily:"Poppins-Medium",fontSize: 16),),
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 6.3),
                   ),
                   const Divider(color: Colors.blueAccent,thickness: 1.5),
                   const SizedBox(height: 10,),
                   FutureBuilder<DocumentSnapshot?>(
                       future:  authentication.bank_inf(widget.phoneNumber),
                       builder:(context,snapshot){
                       if(snapshot.hasData&&snapshot.requireData!.exists){
                         var details = snapshot.data;
                          id = snapshot.data!.id;
                         return details!.get("status")=="Accept"?Container(
                           margin: EdgeInsets.all(12.3),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                           physics: ScrollPhysics(),
                           children: [
                             Container(
                               child: Column(
                                 children: [
                                   Text("Account Number :- ".toUpperCase(),style: TextStyle(letterSpacing:1.0,fontWeight: FontWeight.bold),),
                                   SizedBox(height: 14,),
                                   Container(
                                       child: Text(details.get("accountnumber"),
                                           style: TextStyle(letterSpacing: 1.0,fontSize: 16.0)),
                                     margin: EdgeInsets.only(left: 15.3),
                                   )
                                 ],
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                               ),
                               margin: EdgeInsets.all(12.3),
                             ),
                             SizedBox(height: 14,),

                             Container(
                               child: Column(
                                 children: [
                                   Text("Ifsc :- ".toUpperCase(),style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.bold),),
                                   SizedBox(height: 14,),
                                   Container(
                                     child: Text(details.get("ifsc"),style: TextStyle(letterSpacing: 1.0,fontSize: 16)),
                                     margin: EdgeInsets.only(left: 15.3),
                                   )
                                 ],
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                               ),
                               margin: EdgeInsets.all(12.3),
                             ),
                             SizedBox(height: 14,),

                             Container(
                               child: Column(
                                 children: [
                                   Text("Pan Number :- ".toUpperCase(),style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.bold),),
                                   SizedBox(height: 14,),
                                   Container(
                                     child: Text(details.get("pannumber"),style: TextStyle(letterSpacing: 1.0,fontSize: 16)),
                                     margin: EdgeInsets.only(left: 15.3),
                                   )
                                 ],
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                               ),
                               margin: EdgeInsets.all(12.3),
                             ),
                             SizedBox(height: 30,),
                             Center(
                               child: TextButton(
                                   style: TextButton.styleFrom(
                                       minimumSize: const Size(160, 40),
                                       backgroundColor: Colors.orangeAccent,
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
                                   }, child: const Text("Edit",style: TextStyle(color: Colors.black,fontFamily:"Poppins",fontSize: 15.5,fontWeight: FontWeight.w600),)),
                             )
                           ],
                          ),
                         ):Container();
                       }
                       return CircularProgressIndicator();
                   }),


                 ],
               ),
             ),
         ),
       ],
     );
   }
 }
