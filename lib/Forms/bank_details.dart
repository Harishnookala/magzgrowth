import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Custom_widgets/wrappers.dart';
import 'package:get/get.dart';

class BankAccount extends StatefulWidget {
  String? phonenumber;
  String? id;
  BankAccount({this.phonenumber, this.id});

  @override
  _BankAccountState createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController Reenternumber = TextEditingController();
  TextEditingController Ifsc = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(45))),
        elevation: 1.6,
        title: Text("Bank details",
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
        margin: const EdgeInsets.only(left: 12.3,right: 12.3,top: 8.3),
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: formKey,
              child: Container(
                margin: EdgeInsets.only(left: 12.3, right: 12.3, top: 12.3),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    Container(
                      child: Text(
                        "Account Number : -".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrangeAccent,
                            letterSpacing: 0.6,
                            fontFamily: "Poppins-Light"),
                      ),
                      margin: EdgeInsets.only(bottom: 8.5),
                    ),
                    buildAccountNumber(),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: const Text(
                        "ReEnterAccount Number : -",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrangeAccent,
                            letterSpacing: 0.6,
                            fontFamily: "Poppins-Light"),
                      ),
                      margin: EdgeInsets.only(bottom: 8.5),
                    ),
                    build_reEnternumber(),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        "Ifsc  : -".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrangeAccent,
                            letterSpacing: 0.6,
                            fontFamily: "Poppins-Light"),
                      ),
                      margin: EdgeInsets.only(bottom: 8.5),
                    ),
                    build_Ifsc(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: const Text(
                        "Account holder name : -",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrangeAccent,
                            letterSpacing: 0.6,
                            fontFamily: "Poppins-Light"),
                      ),
                      margin: EdgeInsets.only(bottom: 8.5),
                    ),
                     build_name(),
                     SizedBox(height: 20,),
                    build_button(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildAccountNumber() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(
          fontFamily: "Poppins-Light",
        ),
        validator: (value) {
          if (value == null || value.isEmpty || !value.isNum) {
            return 'Please enter Valid Account number';
          }
          return null;
        },
        controller: accountNumberController,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "Account Number",
            labelText: "Account Number",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
      ),
    );
  }

  build_reEnternumber() {
    return SizedBox(
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        style: TextStyle(
          fontFamily: "Poppins-Light",
        ),
        validator: (value) {
          if (value == null || value.isEmpty || !value.isNum) {
            return 'Please enter Account number';
          } else if (accountNumberController.text != Reenternumber.text) {
            return "Account number does not matches";
          }
          return null;
        },
        controller: Reenternumber,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "ReenterAccount Number",
            labelText: "ReenterAccount Number",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
      ),
    );
  }

  build_Ifsc() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
        inputFormatters: [
          UpperCaseTextFormatter(),
        ],
        style: TextStyle(
          fontFamily: "Poppins-Light",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        controller: Ifsc,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 17.0, horizontal: 10.0),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "Ifsc ",
            labelText: "Ifsc ",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
      ),
    );
  }

  build_button() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.orange,
          minimumSize: Size(140, 30),
          elevation: 1.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.6)),
        ),
        onPressed: () async{
          if (formKey.currentState!.validate()) {
            String? bank_id;
            String? id = await get_id();
            bank_id = id;
            if (id == null) {
              bank_id = "1000";
            } else {
              var bank = int.parse(bank_id!) + 1;
              bank_id = bank.toString();
            }
            Map<String,dynamic> bank_details = {
              "phonenumber":widget.phonenumber,
              "accountnumber" :accountNumberController.text,
              "ifsc" : Ifsc.text,
              "holderName" : namecontroller.text,
            };
            await FirebaseFirestore.instance
                .collection("bank_details").doc(bank_id.toString()).set(bank_details);
            Navigator.pop(context);
          }
        },
        child: Container(
            margin: EdgeInsets.only(left: 5.3, right: 5.3),
            child: Text("Save",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.5,
                  letterSpacing: 0.6,
                  fontFamily: "Poppins-Medium"),
            )),
      ),
    );
  }

  get_id() async {
    var id;
    var data =
    await FirebaseFirestore.instance.collection("bank_details").get();
    for (int i = 0; i < data.docs.length; i++) {
      id = data.docs[i].id;
    }
    if (id != null) {
      return id;
    } else {
      return null;
    }
  }

  build_name() {
    return TextFormField(
      controller: namecontroller,
      style: TextStyle(
        fontFamily: "Poppins-Light",
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
}
