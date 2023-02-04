import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:magzgrowth/Custom_widgets/wrappers.dart';
import 'package:magzgrowth/UserScreens/shown_nominee_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Forms/bank_details.dart';
import '../Forms/kyc_details.dart';
import '../Forms/nominee_details.dart';
import '../Login.dart';
import '../repositories/authentication.dart';
import 'banking.dart';
import 'e-kyc.dart';

class Profile extends StatefulWidget {
  String? phoneNumber;
  String? id;
  Profile({Key? key, this.phoneNumber, this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(phoneNumber: phoneNumber);
}

class _ProfileState extends State<Profile> {
  String? phoneNumber;
  var image;
  _ProfileState({this.phoneNumber});
  Authentication authentication = Authentication();
  File? _profilePicFile;
  var pressed =false;
  bool color = false;
  void _directUpdateImage(File? file) async {
    var details = await authentication.users(widget.phoneNumber);

    setState(() {
      if (file == null) return ;
      setState(() {
        _profilePicFile = file;
        image = authentication.moveToStorage(_profilePicFile, details!.get("Name"), "Profile");
      });
    });
    if(image!=null){
      image = await image;
      Map<String,dynamic> images ={
        "image":image,
      };
      await FirebaseFirestore.instance.collection("Users").doc(details!.id.toString()).update(images);
    }
  }
  @override
  void initState() {
    color=false;
    print(color);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(image);
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
          child: SingleChildScrollView(
            child: Column(children: [
                      FutureBuilder<DocumentSnapshot?>(
                        future: authentication.users(phoneNumber),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            var details  = snapshot.data;
                              return build_details(details);
                          }return Center(child: CircularProgressIndicator(),);
                        },
                      ),
                  SizedBox(height: 16,),
                Divider(height: 1.5,color: Colors.grey.shade400,),
               SizedBox(height: 10,),
               build_buttons(authentication),
      ]),
          )),
    );
  }


  build_details(DocumentSnapshot<Object?>? details) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Container(
                margin:EdgeInsets.only(right:12.3),
                child: EditableImage(
                  onChange: (file) => _directUpdateImage(file),
                  image: details!.get("image")!=null?Image.network(details.get("image",),
                    fit: BoxFit.cover,):Image.asset("assets/Images/play_store.png"),
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
                    child: Text(details.get("Name"),
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
  }

  build_buttons(Authentication authentication) {
    print(color);
    return Column(
      children: [
        Container(
            color: color==false?Colors.white:Colors.grey.shade400,
          child: TextIcon(
            leading: Icon(Icons.dataset_linked_sharp,color: Colors.black,),
            title: Text("e-Kyc ",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
            onTap: () async{
              var details = await authentication.kyc_details(phoneNumber);
              if(details!=null){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            kyc_details(phonenumber: phoneNumber,)));
              }else{
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            kyc(phonenumber: phoneNumber,)));
              }
              pressed =true;


            },
          ),
        ),
        TextIcon(
          leading: Icon(Icons.account_balance,color: Colors.black),
          title: Text("Bank details",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
          onTap: ()async{
            var details = await authentication.users(phoneNumber);
            var bank = await authentication.bank_inf(phoneNumber);
            if(bank!=null){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Banking(phoneNumber: details!.get("mobilenumber"),bank_id: bank.id,)));
            }else{
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BankAccount(phonenumber:details!.get("mobilenumber"))));
            }
          },
        ),
        TextIcon(
            leading: Icon(Icons.person_add_alt_outlined,color: Colors.black,),
            title: Text("Add Nominee",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
            onTap: ()async{
              var details = await authentication.nominee(widget.phoneNumber);

              if(details!=null){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            nominee_details(phonenumber: phoneNumber,)));
              }else{
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            nominee(phonenumber: phoneNumber,)));
              }
            }
        ),
        TextIcon(
          leading: Icon(Icons.task_alt,color: Colors.black),
          title: Text("Terms & conditions",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
          onTap: (){

          },
        ),
        TextIcon(
          leading: Icon(Icons.lock_clock_outlined,color: Colors.black,),
          title: Text("Privacy Policy",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500)),
          onTap: () {

          },
        ),

        TextIcon(
          leading: Icon(Icons.logout_rounded,color: Colors.black,),
          title: Text("Logout",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,
              letterSpacing: 0.6,
              fontSize: 16)),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => LoginPage()),);
          },
        )
      ],
    );
  }


}
