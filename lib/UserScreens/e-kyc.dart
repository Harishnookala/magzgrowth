
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magzgrowth/repositories/authentication.dart';

class kyc_details extends StatefulWidget {
   String?phonenumber;
   kyc_details({Key? key,this.phonenumber}) : super(key: key);

  @override
  State<kyc_details> createState() => _kyc_detailsState();
}

class _kyc_detailsState extends State<kyc_details> {
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
            "e-Kyc details",
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
        child: build_details(),
      ),
    );
  }

  build_details() {
    return Container(
      margin: EdgeInsets.all(12.3),
      child: Column(
        children: [
          FutureBuilder<DocumentSnapshot?>(
            future: authentication.kyc_details(widget.phonenumber),
            builder: (context,snapshot){
              if(snapshot.hasData){
                 var details = snapshot.data;
                 print(details!.data());
                 return Container(
                   decoration: BoxDecoration(border: Border.all(color: Colors.tealAccent,width: 1.54)),
                   child: Column(
                     children: [
                       Container(
                           child: Text("Kyc_details",style: TextStyle(fontFamily: "Poppins",
                               fontSize: 15,color: Colors.deepOrange),),
                        margin: EdgeInsets.only(top: 6.3,left: 12.3),
                         alignment: Alignment.topLeft,
                       ),
                       Divider(color: Colors.tealAccent,thickness: 1.54),
                       Container(
                         child: Row(
                           children: [
                             Container(
                               child: Text(
                                 "Aadhaar number : -".toUpperCase(),
                                 style: TextStyle(
                                     color: Colors.brown,
                                     fontWeight: FontWeight.w500,
                                     letterSpacing: 0.6,
                                     fontFamily: "Poppins"),
                               ),
                             ),
                             Container(
                               child: Text(
                                 details.get("aadhaar"),
                                 style: TextStyle(
                                     color: Colors.black,
                                     letterSpacing: 0.6,
                                     fontSize: 16.5,
                                     fontFamily: "Poppins"),
                               ),
                             ),                           ],
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                         ),
                         margin: EdgeInsets.only(top: 4.5,bottom: 4.5),
                       ),
                       Container(
                         child: Row(
                           children: [
                             Container(
                               child: Text(
                                 "Pan number : -".toUpperCase(),
                                 style: TextStyle(
                                     color: Colors.brown,
                                     fontWeight: FontWeight.w500,
                                     letterSpacing: 0.6,
                                     fontFamily: "Poppins"),
                               ),
                             ),
                             Container(
                               child: Text(
                                 details.get("Pannumber"),
                                 style: TextStyle(
                                     color: Colors.black,
                                     letterSpacing: 0.6,
                                     fontSize: 16.5,
                                     fontFamily: "Poppins"),
                               ),
                             ),                           ],
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                         ),
                         margin: EdgeInsets.only(top: 4.5,bottom: 4.5),
                       ),
                       Container(
                         child: Row(
                           children: [
                             Container(
                               child: Text(
                                 "Date of Birth : -".toUpperCase(),
                                 style: TextStyle(
                                     color: Colors.brown,
                                     fontWeight: FontWeight.w500,
                                     letterSpacing: 0.6,
                                     fontFamily: "Poppins"),
                               ),
                             ),
                             Container(
                               child: Text(
                                 details.get("dateOfBirth"),
                                 style: TextStyle(
                                     color: Colors.black,
                                     letterSpacing: 0.6,
                                     fontSize: 16.5,
                                     fontFamily: "Poppins"),
                               ),
                             ),                           ],
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                         ),
                         margin: EdgeInsets.only(top: 4.5,bottom: 4.5),
                       ),
                       Container(
                         child: Row(
                           children: [
                             Container(
                               child: Text(
                                 "Phonenumber :-",
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
                                     letterSpacing: 0.6,
                                     fontSize: 16.5,
                                     fontFamily: "Poppins"),
                               ),
                             ),                           ],
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                         ),
                         margin: EdgeInsets.only(top: 4.5,bottom: 4.5),
                       ),



                     ],
                   ),
                 );
              }return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
