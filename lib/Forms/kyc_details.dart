import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magzgrowth/repositories/authentication.dart';

class kyc extends StatefulWidget{
  String?phonenumber;
  kyc({this.phonenumber});
  @override
  kycState createState() => kycState();
}

class kycState extends State<kyc>{
  Authentication authentication = Authentication();
  TextEditingController aadhaarController = TextEditingController();
  TextEditingController panController = TextEditingController();
  final dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  final formKey = GlobalKey<FormState>();

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(45))),

        elevation: 1.6,
        title: Text(
          "eKyc details",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins-Medium",
              fontSize: 17,
              letterSpacing: 0.6),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(8.3),
        child: ListView(
           shrinkWrap: true,
            children: [
              SizedBox(height: 5,),
              Divider(color: Colors.black26,thickness:1.0),
              FutureBuilder<DocumentSnapshot?>(
                future: authentication.users(widget.phonenumber),
                builder: (context,snapshot){
                   if(snapshot.hasData){
                      var details = snapshot.data;
                      return Container(
                         margin: EdgeInsets.only(left:12.3,right: 12.3),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Text(details!.get("Name"),style: TextStyle(
                              color: Colors.black, fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.6,
                              fontSize: 15
                            ),),
                            Row(
                              children: [
                                Icon(Icons.phone_in_talk_rounded,color: Colors.blueAccent),
                                Container(
                                  child: Text(details.get("mobilenumber"),style: TextStyle(
                                      color: Colors.black, fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6,
                                      fontSize: 15
                                  ),),
                                  margin: EdgeInsets.only(left: 10.3),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                   } return Container();
                },
              ),
              Divider(color: Colors.black26,thickness:1.0),
              SizedBox(height: 10,),
              Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.all(14.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Aadhaar Number : -",
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.6,
                              fontSize: 15,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.3),
                        child: build_aadhaar(),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Text(
                          "Pan Number : -",
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.6,
                              fontSize: 15,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.3),
                        child: build_pannumber(),
                      ),
                      SizedBox(height: 15,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Date of birth : -",
                                  style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.6,
                                      fontSize: 15,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              Align(
                                widthFactor: 1.5,
                                child: Container(
                                  child: Text(
                                    "Gender : -",
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 0.6,
                                        fontSize: 15,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding:EdgeInsets.symmetric(vertical: 4)),
                          Row(
                            children: [
                              dateofbirthfield(),
                              Container(
                                margin: EdgeInsets.only(left: 9.6),
                                child: buildgender(),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(
                        child: Text(
                          "Residential address : -",
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.6,
                              fontSize: 15,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      Container(
                          margin:  EdgeInsets.only(top:8.3),
                          child: build_address()
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: build_button(),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

  build_aadhaar() {
    return TextFormField(
      controller: aadhaarController,
      style: TextStyle(
        fontFamily: "Poppins-Light",
        color: Colors.black,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter aadhaar';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.9),
          ),
          hintText: "Enter aadhaar Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff9fce4c), width: 1.5),
          ),
          hintStyle: const TextStyle(color: Colors.brown)),
    );
  }

  build_pannumber() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: panController,
      style: TextStyle(
        fontFamily: "Poppins-Light",
        color: Colors.black,
      ),
      validator: (value) {
        if (value == null || value.isEmpty|| value.length != 10) {
          return 'Please enter  Correct Pan number';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.9),
          ),
          hintText: "Enter Pan Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff9fce4c), width: 1.5),
          ),
          hintStyle: const TextStyle(color: Colors.brown)),
    );
  }

  dateofbirthfield() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/2.25,
      child: TextFormField(
        readOnly:  true,
        focusNode: FocusNode(),
        onTap: () async{
          var date =  await showDatePicker(
              context: context,
              initialDate:DateTime.now(),
              firstDate:DateTime(1900),
              lastDate: DateTime(2100));
             if(date!=null){
               String formattedDate = DateFormat('dd-MM-yyyy').format(date);
               setState(() {
                 dateController.text = formattedDate; //set output date to TextField value.
               });
             }

          },
        controller: dateController,
        style: TextStyle(
          fontFamily: "Poppins-Light",
          color: Colors.black,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter  dateofbirth';
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding:
            EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.9),
            ),
            hintText: "Enter Dateofbirth",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
      ),
    );
  }

  buildgender() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/2.5,
      child:  DropdownButtonFormField2(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
           fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.9),
            borderSide: BorderSide(color: Colors.green)
          ),
          //Add more decoration as you want here
          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
        ),
        isExpanded: true,
        hint: const Text(
          'Select  Gender',
          style: TextStyle(fontSize: 14),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
        buttonHeight: 60,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: genderItems
            .map((item) =>
            DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              onTap: (){
                setState(() {
                  selectedValue  = item;
                  print(selectedValue);
                });
              },
            ))
            .toList(),

        validator: (value) {
          if (value == null) {
            return 'Please select gender.';
          }
        },
        onChanged: (value) {
          //Do something when changing the item if you want.
        },
        onSaved: (value) {
          selectedValue = value.toString();
        },
      ),

    );
  }

  build_address() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: addressController,
      style: TextStyle(
        fontFamily: "Poppins-Light",
        color: Colors.black,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Address';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.9),
          ),
          hintText: "Enter residential address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff9fce4c), width: 1.5),
          ),
          hintStyle: const TextStyle(color: Colors.brown)),
    );

  }

  build_button() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.5,
      height: 55 ,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.indigo.shade500,
            elevation: 1.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.6))
          ),
          onPressed: ()async{
               if(formKey.currentState!.validate()){
                 Map<String,dynamic> kyc_details = {
                   "aadhaar" : aadhaarController.text,
                   "Pannumber" : panController.text,
                   "dateofbirth":dateController.text,
                   "gender" : selectedValue,
                   "address" :addressController.text,
                   "phonenumber" :widget.phonenumber,
                 };
                 await FirebaseFirestore.instance.collection("Kyc_details").add(kyc_details);
                  Navigator.pop(context);
               }
          }, child: Text(" Update e-Kyc",style: TextStyle(color: Colors.white,
           fontWeight: FontWeight.w600,
           fontFamily: "Poppins",
           fontSize: 16,
      ),)),
    );
  }


}