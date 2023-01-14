import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magzgrowth/repositories/authentication.dart';

class nominee extends StatefulWidget {
  String? phonenumber;
  nominee({this.phonenumber});
  @override
  nomineeState createState() => nomineeState();
}

class nomineeState extends State<nominee> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController EmailIdcontroller = TextEditingController();
  TextEditingController aadhaarcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(45))),
        elevation: 1.6,
        title: Text(
          "Nominee details",
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
        margin: EdgeInsets.symmetric(horizontal: 23.3, vertical: 26.3),
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Name : -",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.6,
                          fontSize: 16,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.3),
                    child: build_fieldName(),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Text(
                      "Relationship with you : -",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.6,
                          fontSize: 16,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.3, bottom: 8.3),
                    child: buildrelation(),
                  ),
                  Container(
                    child: Text(
                      "Phone : -",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.6,
                          fontSize: 16,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.3),
                    child: buildfieldPhone(),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Text(
                      "Email Id : -",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.6,
                          fontSize: 16,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.3),
                    child: buildEmailid(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Aadhaar Number : -",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.6,
                          fontSize: 16,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.3),
                    child: buildaadhar(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  build_button(),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  build_fieldName() {
    return TextFormField(
      onTap: () {},
      inputFormatters: [],
      controller: namecontroller,
      style: TextStyle(
        fontFamily: "Poppins",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter name';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.9),
          ),
          hintText: "Enter Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
          ),
          hintStyle: const TextStyle(color: Colors.brown)),
    );
  }

  buildfieldPhone() {
    return TextFormField(
      controller: phonecontroller,
      style: TextStyle(
        fontFamily: "Poppins",
      ),
      validator: (value) {
        if (value == null || value.isEmpty || value.length==10) {
          return 'Please enter phone';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.9),
          ),
          hintText: "Enter Phone",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
          ),
          hintStyle: const TextStyle(color: Colors.brown)),
    );
  }

  buildEmailid() {
    return TextFormField(
      controller: EmailIdcontroller,
      style: TextStyle(
        fontFamily: "Poppins",
      ),
      validator: (email) {
        if (email == null || email.isEmpty) {
          return 'Please enter email';
        } else if (!EmailValidator.validate(EmailIdcontroller.text) &&
            email.isNotEmpty) {
          return "Please enter valid Email Address";
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.9),
          ),
          hintText: "Enter Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
          ),
          hintStyle: const TextStyle(color: Colors.brown)),
    );
  }

  buildaadhar() {
    return TextFormField(
      controller: aadhaarcontroller,
      style: TextStyle(
        fontFamily: "Poppins",
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
          hintText: "Enter aadhaar",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
          ),
          hintStyle: const TextStyle(color: Colors.brown)),
    );
  }

  buildrelation() {
    final List<String> relationship = [
      'Father',
      'Mother',
      'Husband',
      'Wife',
      'Son',
      'Daughter',
      'Brother',
      'Sister',
      'Other'
    ];
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.9),
            borderSide: BorderSide(color: Colors.green)),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: const Text(
        'Select  Relationship',
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
      items: relationship
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
                ),
                onTap: () {
                  setState(() {
                    selectedValue = item;
                  });
                },
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select relationship.';
        }
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );
  }

  build_button() {
    return Container(
        alignment: Alignment.center,
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.5)),
                minimumSize: Size(130, 45)),
            onPressed: () async {
               if(formKey.currentState!.validate()){
                 Authentication authentication = Authentication();
                 var details = await authentication.users(widget.phonenumber);
                 Map<String, dynamic> nominee_details = {
                   "username": details!.get("Name"),
                   "userPhoneNumber": details.get("mobilenumber"),
                   "Name": namecontroller.text,
                   "relation": selectedValue,
                   "phonenumber": phonecontroller.text,
                   "email": EmailIdcontroller.text,
                   "Aadhaarnumber": aadhaarcontroller.text,
                 };
                 await FirebaseFirestore.instance.collection("nominee").add(nominee_details);
                 Navigator.pop(context);
               }
            },
            child: Text(
              "Save",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.5,
                  fontFamily: "Poppins-Medium"),
            )));
  }
}
