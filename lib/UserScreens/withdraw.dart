import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magzgrowth/UserScreens/userPannel.dart';

import '../repositories/authentication.dart';

class withdraw extends StatefulWidget {
  String? id;
  String?phonenumber;
  String?username;
  withdraw({Key? key, this.id,this.phonenumber,this.username}) : super(key: key);

  @override
  _withdrawState createState() => _withdrawState(id: this.id);
}

class _withdrawState extends State<withdraw> {
  TextEditingController debitController = TextEditingController();
  String? id;
  Authentication authentication = Authentication();
  int? Investments;
  bool pressed = true;
  final formKey = GlobalKey<FormState>();
   bool inprogress = false;
  var formatter = NumberFormat('#,##0.${"#" * 5}');

  _withdrawState({this.id});
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot<Object?>?amount;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 10,),
            Container(
                margin: EdgeInsets.all(12.3),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.deepOrangeAccent,size: 19,)),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Center(
                              child: Container(
                                  margin: const EdgeInsets.only(bottom: 13.5),
                                  child: const Text(
                                    "Funds Available Amount",
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 14.3,
                                      fontFamily: "Poppins"
                                    ),
                                  ))),
                          build_data(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16.3, bottom: 5.3),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Withdrawl Amount",
                        style: TextStyle(color: Colors.deepOrange,fontFamily: "Poppins"),
                      ),
                    ),
                   Form(
                    key: formKey,
                     child: Column(
                       children: [
                         SizedBox(
                           child: Container(
                             margin: const EdgeInsets.only(
                                 top: 5.8, left: 12.3, bottom: 12.3,right: 12.3),
                             child: TextFormField(
                               validator: (amount) {
                                 if (amount!.isEmpty||!amount.isNum) {
                                   return 'Please enter Amount';
                                 }
                                 return null;
                               },
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                   prefix: Container(
                                     margin: const EdgeInsets.only(right: 8.3),
                                     child: const Text("₹",
                                         style: TextStyle(fontSize: 15)),
                                   ),
                                   focusedBorder: const OutlineInputBorder(
                                     borderSide: BorderSide(
                                         color: Colors.greenAccent, width: 2.0),
                                   ),
                                   labelText: "Enter Amount",
                                   labelStyle:
                                   const TextStyle(color: Color(0xff576630)),
                                   border: OutlineInputBorder(
                                     gapPadding: 1.3,
                                     borderRadius: BorderRadius.circular(4.5),
                                   ),
                                   enabledBorder: const OutlineInputBorder(
                                     borderSide: BorderSide(
                                         color: Color(0xcc9fce4c), width: 1.5),
                                   ),
                                   hintStyle: const TextStyle(color: Colors.brown)),
                               controller: debitController,
                             ),
                           ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             TextButton(
                               style: TextButton.styleFrom(
                                   minimumSize: const Size(140, 40),
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.8)),
                                   backgroundColor: Colors.deepOrange.shade400),
                               onPressed: () async {

                                 setState(() {
                                   var investamount = double.parse(amount!.get("InvestAmount"));
                                   var debit = double.parse(debitController.text);
                                   if(investamount>=debit){
                                     pressed = true;
                                     inprogress =true;
                                   }
                                   else if(investamount<debit){
                                     pressed =false;
                                     inprogress =false;
                                   }

                                 });
                                 if(formKey.currentState!.validate()&&pressed){
                                   Map<String, dynamic> data = {
                                     "phonenumber": widget.phonenumber,
                                     "InvestAmount": debitController.text.toString(),
                                     "CreatedAt": DateTime.now(),
                                     "status": "pending",
                                     "Type" : "Debit",
                                     "username":widget.username.toString(),
                                   };
                                   await FirebaseFirestore.instance.collection("requestwithdrawls").add(data);
                                   Navigator.of(context).pushReplacement(MaterialPageRoute(
                                       builder: (BuildContext context) =>
                                           userPannel(phonenumber: widget.phonenumber,pressed: true,)));
                                 }

                               },

                               child:  const Text(
                                 "Withdraw",
                                 style: TextStyle(color: Colors.white,fontSize:15, fontFamily: "Poppins"),
                               ),
                             ),
                             inprogress?const Padding(
                                 padding: EdgeInsets.only(left: 10),
                                 child: CircularProgressIndicator())
                                 : Container()
                           ],
                         ),
                       ],
                     ),
                   ),
                    pressed==false?Text("Available amount is greater than Debit Amount",style: TextStyle(color: Colors.red),):Text(""),
                    SizedBox(height: MediaQuery.of(context).size.height/9),
                    SizedBox(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4.3),
                            alignment: Alignment.topLeft,
                            child: Text("Note : - ", style: TextStyle(fontFamily: "Poppins-Medium",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500),)),),
                    ),
                    SizedBox(
                      child: Align(alignment: Alignment.bottomCenter,
                           child: Text("For requests initiated before 4 PM Amount will be reaching your BANKACCOUNT on next Day." + "\n\n"+ "All Saturdays, Sundays Exchange Holidays Non working Days",
                            style: TextStyle(fontFamily: "Poppins",fontSize: 14,color: Colors.blueGrey,fontWeight: FontWeight.w500),),
                      ),
                    ),

                  ],
                )),
          ],
        ),
      ),
    );
  }



  build_data() {
    return Container(
      margin: const EdgeInsets.only(left: 12.3, right: 12.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 12.3),
            decoration: BoxDecoration(
                color: Colors.lightGreenAccent.shade200,
                borderRadius: BorderRadius.circular(5.3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 2.59,
                    margin: const EdgeInsets.only(
                        top: 5.3, bottom: 3.3, left: 3.3, right: 5.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                            child: Text("Current Balance",
                                style: TextStyle(
                                    letterSpacing: 0.9,
                                    color: Colors.black,
                                    fontFamily: "Poppins"))),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: get_invests(),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.lightGreenAccent.shade200,
                borderRadius: BorderRadius.circular(5.3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width /2.8,
                    margin: const EdgeInsets.only(
                        top: 5.3, bottom: 3.3, left: 3.3,),
                    child:  Center(
                        child: Text(
                          "Current Profit",
                          style: TextStyle(
                            color: Colors.black, fontFamily:"Poppins",
                            letterSpacing: 1.0,
                          ),
                        ))),
                const SizedBox(
                  height: 8,
                ),
                get_gains(),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  get_invests() {
    return Container(
    );
  }
  get_total(List<DocumentSnapshot<Object?>?>? details) {
    double total=0.0;
    for(int i =0;i<details!.length;i++){
      total = total +details[i]!.get("Portfolio");
    }return total;
  }
  get_gains() {
    return FutureBuilder<DocumentSnapshot?>(
      future: authentication.get_curentgains(widget.phonenumber),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.requireData!.exists) {
          var gains = snapshot.data;
          var afterFormat = formatter.format(double.parse(
              gains!.get("CurrentGains").replaceAll(",", "")));
          return Row(
            children: [
              const Text(
                "₹",
                style: TextStyle(color: Colors.white),
              ),
              Text(" ₹ $afterFormat",
                style: const TextStyle(color: Colors.green,
                    fontFamily: "Poppins-Medium"
                ),)
            ],
          );
        }
        return Center();
      },
    );
  }

}
