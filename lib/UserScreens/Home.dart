import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magzgrowth/UserScreens/payments.dart';
import 'package:magzgrowth/UserScreens/withdraw.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/authentication.dart';

class Home extends StatefulWidget {
  String? id;
  String? phonenumber;
  String? bank_id;
  bool? pressed;
  SharedPreferences? prefs;
  Home({Key? key, this.id, this.phonenumber, this.bank_id,this.pressed}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  var data;
  var formatter = NumberFormat('#,##0.${"#" * 5}');
  Authentication authentication = Authentication();
  String? value;
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
    return Container(
      child: ListView(
        shrinkWrap: true,

        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FutureBuilder<DocumentSnapshot?>(
                      future: authentication.users(widget.phonenumber),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          DocumentSnapshot<Object?>? users = snapshot.data;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              get_name(users)
                            ],
                          );
                        }
                        return Center(
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width/1.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(35)),
                              gradient: LinearGradient(colors: [Colors.teal.shade100,Colors.deepOrange.shade300]),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(top: 12.3,left: 15.3),
                              child: const Text(
                                "Welcome  --- Loading ---",
                                style: TextStyle( color: Color(0xc3ce2fea)),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.3),
            child: Column(
              children: [
                Container(
                  child: Text("Balance's",style: TextStyle(color: Colors.black,
                    fontSize: 14.5,fontFamily: "Poppins-Medium",letterSpacing: 0.6),),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 15.3,bottom: 15.3),
                ),
                build_data(),
                SizedBox(height:40),
                build_Investments(),
                SizedBox(height: 40),
                Container(
                  child: Text("Portfolio's",style: TextStyle(color: Colors.black,
                    fontSize: 14.5,fontFamily: "Poppins-Medium",letterSpacing: 0.6),),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 15.3,bottom: 12.3),
                ),
                build_portfolio(),
              ],
            ),
          )
        ],
      ),
    );
  }

    get_name(users) {
    return Container(
      width: MediaQuery.of(context).size.width/1.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(35)),
        gradient: LinearGradient(colors: [Colors.teal.shade100,Colors.deepOrange.shade300]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Welcome, " + '${users!.get("Name")}',
                    style: const TextStyle(
                        color: Color(0xc3ce2fea),
                        fontSize: 17,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Poppins"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 1.0),
                  child: const Text(
                    "This is the way to build your Future",
                    style: TextStyle(
                        fontSize: 14.5,
                        letterSpacing: 0.5,
                        color: Colors.white,
                        fontFamily: "Poppins-Medium"),
                  ),
                ),

              ],
            ),
          ),
        ],
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
            margin: const EdgeInsets.only(left: 12.3, right: 12.3),
            decoration: BoxDecoration(
                color: Colors.lightGreenAccent.shade200,
                borderRadius: BorderRadius.circular(5.3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 2.8,
                    margin: const EdgeInsets.only(
                        top: 5.3, bottom: 3.3, left: 3.3, right: 5.3),
                    child: const Center(
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
    double? value = 0.0;
    return Container(
      child: FutureBuilder<DocumentSnapshot?>(
        future: authentication.get_investments(widget.phonenumber!),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var portfolio = snapshot.data;
            var total = get_total(portfolio);
            return Container(
              margin: EdgeInsets.only(bottom: 5.6),
              child: Text( total.toString(),style: TextStyle(color: Colors.indigo,
                  fontSize: 16.2,
                  letterSpacing: 0.6,
                  fontFamily: "Poppins-Medium"
              ),),
            );
          }return Container(child: Text("₹ " + value.toString(),style: TextStyle(color: Colors.indigo,
              fontSize: 16.2,
              letterSpacing: 0.6,
              fontFamily: "Poppins-Medium"
          )));
        },
      ),
    );
  }


  build_Investments() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            style: TextButton.styleFrom(
                minimumSize: Size(125, 45),
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.6)),
                backgroundColor: Colors.green.shade600),
            onPressed: () async {
              var bankDetails = await authentication.users(widget.phonenumber);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => payments(
                      phonenumber: widget.phonenumber,
                    )),
              );
            },
            child:Text("  Investment", style: TextStyle  (
                color: Colors.white,
                fontSize: 15.8,
                letterSpacing: 0.6,
                fontFamily: "Poppins-Medium"),),
          ),
          TextButton(
            style: TextButton.styleFrom(
                minimumSize: Size(130, 45),
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.6)),
              backgroundColor: Colors.orange.shade900,
            ),
            onPressed: ()  async {
              var data = await authentication.get_investments(widget.phonenumber!);
              if(data!=null){
                List values =[];
                List value = data.get("Portfolio");
                List enddate = data.get("endDate");
                var firstdate = enddate[0];
                var firstvalue = value[0];
                values.add(firstvalue);
                values.add(firstdate);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    withdraw(phonenumber: widget.phonenumber,
                      values: values,data: firstvalue,
                    )));

              }
             else{
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    withdraw(phonenumber: widget.phonenumber,)));

              }
            },
            child:  Text("Withdrawl",
              style: TextStyle(color: Colors.white, fontSize: 15.8,
                  letterSpacing: 0.6, fontFamily: "Poppins-Medium"),
            ),
          ),
        ],
      ),
    );
  }

  get_gains() {
    return FutureBuilder<DocumentSnapshot?>(
      future: authentication.get_profit(widget.phonenumber!),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.requireData!.exists) {
          var gains = snapshot.data;
          var value = gains!.get("Profit").toStringAsFixed(2);
          var profits = authentication.get_format(value);
          return Row(
            children: [
              Text(profits.toString(),style: TextStyle(color: Colors.indigo,
                  fontSize: 16.2,
                  letterSpacing: 0.6,
                  fontFamily: "Poppins-Medium"
              ),),
            ],
          );
        }
        return Center();
      },
    );
  }

  build_portfolio() {
    Authentication authentication = Authentication();
    return Container(
      margin: EdgeInsets.only(right: 9.3),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          FutureBuilder<DocumentSnapshot?>(
            future:authentication.get_investments(widget.phonenumber!) ,
            builder: (context,snapshot){
               if(snapshot.hasData){
                  var data = snapshot.data;
                  List investAmount = data!.get("Portfolio");
                  List startDate = data.get("startDate");
                  List endDate = data.get("endDate");
                 return Column(
                   children: [
                     Divider(thickness: 1.0,color: Colors.black54,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           child: Text("Start Date", style: TextStyle(
                               color: Colors.purple,
                               fontSize: 15,
                               letterSpacing: 0.6,
                               fontFamily: "Poppins")),
                         ),
                         Container(child: Text("Invest Amount", style: TextStyle(
                             color: Colors.purple,
                             fontSize: 15,
                             letterSpacing: 0.6,
                             fontFamily: "Poppins")),),
                         Container(
                           child: Text("End Date", style: TextStyle(
                               color: Colors.purple,
                               fontSize: 15,
                               letterSpacing: 0.6,
                               fontFamily: "Poppins")),
                         ),

                       ],
                     ),
                     Divider(thickness: 1.0,color: Colors.black54,),

                     Container(
                       child:ListView.builder(
                         physics: ScrollPhysics(),
                         shrinkWrap: true,
                         itemCount: investAmount.length,
                         itemBuilder: (context,index){

                           var startdate = authentication.get_dateformat(startDate[index]);
                           var enddate = authentication.get_dateformat(endDate[index]);
                           return Container(
                             margin: EdgeInsets.only(bottom: 14.6,top: 12.3),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(child: Text(startdate,
                                  style: TextStyle(color: Colors.black,
                                   letterSpacing: 0.5,
                                    fontFamily: "Poppins"
                                  ),
                                 ),),
                                 Container(child: Text(authentication.get_format(investAmount[index]),
                                   style: TextStyle(color: Colors.deepPurple,
                                       letterSpacing: 0.5,
                                       fontSize: 15.3,
                                       fontWeight: FontWeight.w500,
                                       fontFamily: "Poppins-Medium"
                                   ),
                                 )),
                                 Container(child: Text(enddate,
                                   style: TextStyle(color: Colors.black,
                                       letterSpacing: 0.5,
                                       fontFamily: "Poppins"
                                   ),
                                 ),)
                               ],
                             ),
                           );
                         },
                       ),
                     ),
                   ],
                 );
               }else if(!snapshot.hasData){
                 return Center(
                   heightFactor: 5.3,
                   child: Container(
                     margin: EdgeInsets.only(top: 18.3),
                     alignment: Alignment.center,
                     child: Text("---  No Portfolio's Yet  ---",style: TextStyle(
                     color: Colors.deepOrange,
                   ),),),
                 );
               }return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }



  get_profits(List<DocumentSnapshot<Object?>>? profits) {
    double total =0.0;
    for(int i=0;i<profits!.length;i++){
      total = total + profits[i].get("Profit");
    }return total;
  }

  get_total(DocumentSnapshot<Object?>? portfolio) {
    List values = portfolio!.get("Portfolio");
    double total = 0.0;
    for(int i=0;i<values.length;i++){
      total = total+ double.parse(values[i]);
    }
    var format = NumberFormat.currency(symbol: "₹ ");
    return format.format(total);
  }






 
  




}
