import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magzgrowth/UserScreens/userPannel.dart';
import 'package:magzgrowth/repositories/authentication.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'Home.dart';

class payments extends StatefulWidget {
  String? phonenumber;
  String? username;
  var image;
  payments({this.phonenumber, this.username, this.image});
  @override
  paymentsstate createState() => paymentsstate();
}

class paymentsstate extends State<payments> {
  var _locale = 'Hi';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  bool inprogress = false;
  bool pressed = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController creditController = TextEditingController();
  var razorpay;
  var value;
  Authentication authentication = Authentication();
  @override
  void initState() {
    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    value = "Success";
    if (value == "Success") {
      var invests = await authentication.get_investments(widget.phonenumber!);
       get_succes(invests);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    String amount = creditController.text + '00';
    String value = amount.replaceAll(",", "");
    var options = {
      'key': 'rzp_test_NNbwJ9tmM0fbxj',
      'amount': value,
      'name': 'Shaiq',
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.brown,
                  ),
                ),
                margin: EdgeInsets.only(top: 5.6, left: 12.3),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(13.3),
                alignment: Alignment.topLeft,
                child: Text(
                  "(Minimum  Amount of Investment  is 5,000)",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: "Poppins_Light"),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "I want to Invest ",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: "Poppins",
                          letterSpacing: 1.0,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 5.8, left: 6.3, bottom: 14.3),
                        child: TextFormField(
                          style: TextStyle(color: Colors.indigo,fontFamily: "Poppins",fontSize: 17),
                          onChanged: (string) {
                            string = '${_formatNumber(string.replaceAll(',', ''))}';
                            creditController.value = TextEditingValue(
                              text: string,
                              selection: TextSelection.collapsed(offset: string.length),
                            );
                          },
                          keyboardType: TextInputType.number,
                          validator: (amount) {
                            if (amount!.isEmpty) {
                              return 'Please enter Amount';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              prefixIcon: Icon(
                                Icons.currency_rupee_outlined,
                                color: Colors.purple,
                                size: 20,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 2.0),
                              ),
                              labelText: "Enter Invest  Amount",
                              labelStyle:
                                  const TextStyle(color: Color(0xff576630)),
                              border: OutlineInputBorder(
                                gapPadding: 1.3,
                                borderRadius: BorderRadius.circular(4.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade400, width: 2.0),
                              ),
                              hintStyle: const TextStyle(color: Colors.brown)),
                          controller: creditController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: const Size(180, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.8)),
                              backgroundColor: Colors.green),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                String str = creditController.text;
                                str = str.replaceAll(",", "");
                                double amount = double.parse(str);
                                if (amount >=5000) {
                                  pressed = true;
                                  inprogress =true;
                                  razorpay.open(options);
                                } else {
                                  pressed = false;
                                  inprogress = false;
                                }
                              });

                            }
                          },
                          child: const Text(
                            "Invest ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 0.6,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins-Medium"),
                          ),
                        ),
                        inprogress
                            ? const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: CircularProgressIndicator())
                            : Container()
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    pressed == true
                        ? const Text("")
                        : Text("Minimum amount of investment is 5,000 ")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   get_succes(DocumentSnapshot?invests) async {
     var users = await authentication.users(widget.phonenumber);
     DateTime startDate = DateTime.now();
     DateTime endDate = DateTime.now().add(Duration(days: 90));
     if (invests != null) {
       String value = creditController.text;
       String amount = value.replaceAll(",", "");
       List values = invests.get("Portfolio");
       List startdate = invests.get("startDate");
       List enddate = invests.get("endDate");
       values.add(amount);
       startdate.add(startDate);
       enddate.add(endDate);
       Map<String,dynamic>data={
         "Portfolio":values,
         "endDate":enddate,
         "startDate":startdate
       };
       await FirebaseFirestore.instance
           .collection("razor_investments")
           .doc(invests.id)
           .update(data);
       Navigator.of(context).push(
           MaterialPageRoute(
             builder: (context) => userPannel(phonenumber: widget.phonenumber),
           ));
     }else {
       String amount = creditController.text;
       String value = amount.replaceAll(",", "");
       Map<String, dynamic> data = {
         "username": users!.get("Name"),
         "phonenumber": users.get("mobilenumber"),
         "Portfolio": [
           value
         ],
         "endDate": [endDate],
         "startDate": [startDate],
         "type":"Credit",
       };
       print(data);
       await FirebaseFirestore.instance
           .collection("razor_investments")
           .add(data);
       Navigator.of(context).push(
         MaterialPageRoute(
           builder: (context) => userPannel(phonenumber: widget.phonenumber),
         ),
       );
     }
   }
}
