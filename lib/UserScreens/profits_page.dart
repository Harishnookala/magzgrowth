import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:magzgrowth/UserScreens/Home.dart';
import 'package:magzgrowth/UserScreens/userPannel.dart';
import 'package:magzgrowth/UserScreens/withdraw.dart';
import 'package:magzgrowth/repositories/authentication.dart';
class Profitspage extends StatefulWidget {
  var phonenumber;
  Profitspage({this.phonenumber});
  @override
  State<Profitspage> createState() => ProfitspageState();
}

class ProfitspageState extends State<Profitspage> {
  Authentication authentication =Authentication();
  TextEditingController debitController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var profit;
  bool inprogress = false;
  bool? pressed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.center,
              child: Card(
                color: Colors.lightGreenAccent,
                elevation: 2.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.5),
                ),
                child: Container(
                  alignment: Alignment.centerRight,
                  height: MediaQuery.of(context).size.height/6.5,
                  width: MediaQuery.of(context).size.width/2.0,
                  margin: const EdgeInsets.only(left: 12.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              top: 5.3, bottom: 3.3, left: 3.3, right: 5.3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                  child: Text("Current Profit",
                                      style: TextStyle(
                                          letterSpacing: 0.9,
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontFamily: "Poppins"))),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: get_gains(),
                              ),
                            ],
                          )),
                      
                    ],
                  ),
                ),
              ),
            ),
             SizedBox(height: 25,),
             Container(
               margin: EdgeInsets.symmetric(horizontal: 15,vertical: 25),
               child: Column(
                 children: [
                   Container(
                     margin: EdgeInsets.only(left: 16.3, bottom: 5.3),
                     alignment: Alignment.topLeft,
                     child: const Text(
                       "Enter Withdrawl Amount",
                       style: TextStyle(
                           color: Colors.deepOrange, fontFamily: "Poppins-Medium"),
                     ),
                   ),
                   build_field(),
                   SizedBox(height: 20,),
                   build_button(),
                   pressed==false?Container(
                     margin: EdgeInsets.only(top: 12.3),
                     child: Text("Your Profit is not  greater than 500",
                     style: TextStyle(color: Colors.red,letterSpacing: 1.0,fontSize: 15),),

                   ):Container(),
                 ],
               ),
             ),
          ],
        )
      ),
    );
  }
  get_gains() {
    return FutureBuilder<DocumentSnapshot?>(
      future: authentication.get_profit(widget.phonenumber!),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.requireData!.exists) {
          var gains = snapshot.data;
          profit = authentication.get_format(gains!.get("Profit").toStringAsFixed(2));
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                profit.toString(),
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 16.2,
                    letterSpacing: 0.6,
                    fontFamily: "Poppins-Medium"),
              ),
            ],
          );
        }
        return Container(child: Text("₹" + 0.0.toString(),style: TextStyle(
            color: Colors.indigo,
            fontSize: 16.2,
            letterSpacing: 0.6,
            fontFamily: "Poppins-Medium"),
        ),);
      },
    );
  }
  get_profits(List<DocumentSnapshot<Object?>>? profits) {
    double total = 0.0;
    for (int i = 0; i < profits!.length; i++) {
      total = total + profits[i].get("Profit");
    }
    return total;
  }

  build_field() {
    const _locale = 'Hi';
    String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            child: Container(
              margin: const EdgeInsets.only(
                  top: 5.8, left: 12.3, right: 12.3),
              child: TextFormField(
                inputFormatters:<TextInputFormatter> [
                ],
                onChanged: (string) {
                  string = '${_formatNumber(string.replaceAll(',', ''))}';
                  debitController.value = TextEditingValue(
                    text: string,
                    selection: TextSelection.collapsed(offset: string.length),
                  );
                },
                keyboardType:TextInputType.numberWithOptions(decimal: true),
                validator: (amount) {
                  if (amount!.isEmpty) {
                    return 'Please enter Amount';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    prefix: Container(
                      margin: const EdgeInsets.only(right: 8.3),
                      child: const Text("₹", style: TextStyle(fontSize: 16,
                          color: Colors.indigo,
                          fontFamily: "Poppins"
                      )),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.greenAccent, width: 2.0),
                    ),
                    labelText: "Enter Amount",
                    labelStyle: const TextStyle(color: Color(0xff576630)),
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
                style: TextStyle(color: Colors.indigo,fontFamily: "Poppins",fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
  build_button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              minimumSize: const Size(160, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.8)),
              backgroundColor: Colors.green),
          onPressed: () async {
            var profits = await authentication.get_profit(widget.phonenumber);
            setState(()  {
              if(formKey.currentState!.validate()){
                inprogress=true;
                double amount = double.parse(debitController.text);
                if(amount>=500.0){
                  inprogress=true;
                  if(profits!=null){
                    var amount = profits.get("Profit");
                    double totalAmount = amount-double.parse(debitController.text);
                    Map<String,dynamic>data={
                      "Profit":totalAmount
                    };
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => userPannel(phonenumber: widget.phonenumber,)));
                    FirebaseFirestore.instance.collection("Profit").doc(profits.id).update(data);
                  }
                }else{
                  inprogress =false;
                  pressed = false;
                }
                
              }
            });
          },
          child: const Text(
            "Withdrawl",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w900,
                fontFamily: "Poppins-Medium"),
          ),
        ),
          inprogress?Container(child: CircularProgressIndicator(),):Container(),

      ],
    );
  }

}

