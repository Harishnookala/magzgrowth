import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:magzgrowth/UserScreens/profits_page.dart';
import 'package:magzgrowth/UserScreens/userPannel.dart';
import '../repositories/authentication.dart';
import 'Home.dart';

class withdraw extends StatefulWidget {
  String? id;
  String? phonenumber;
  String? username;
  String? data;
  List? values;
  int? selectedpage = 0;
  withdraw(
      {Key? key,
      this.id,
      this.phonenumber,
      this.username,
      this.data,
      this.values,this.selectedpage})
      : super(key: key);

  @override
  _withdrawState createState() =>
      _withdrawState(id: this.id, data: this.data, values: this.values);
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
  String? data;
  var current_balance;
  List? endDate;
  int? index_value =0;
  List? values;
  bool check = false;

  _withdrawState({this.id, this.data, this.values});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Container(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.brown,
                          size: 23,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 2.3),
                            child: Text("Back",style: TextStyle(color: Colors.brown,fontSize: 16,
                                fontFamily: "Poppins",
                                letterSpacing: 0.5
                            ),))
                      ],
                    ),
                  ),
                  margin: EdgeInsets.only(top: 5.6,bottom: 12.3, left: 12.3),
                ),
                        DefaultTabController(
                            length: 2,
                            child: Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(12.3),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue.shade100,
                                      borderRadius: BorderRadius.circular(15.3),
                                    ),
                                    child: TabBar(
                                      unselectedLabelColor: Colors.grey.shade600,
                                      indicatorColor: Colors.lightBlue,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorWeight: 0.1,
                                      labelPadding: EdgeInsets.all(0),
                                      indicatorPadding: EdgeInsets.all(0),
                                      labelColor: Colors.deepPurple,
                                      tabs: [
                                        Container(
                                          height: 50 +
                                              MediaQuery.of(context).padding.bottom,
                                          padding: EdgeInsets.all(0),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border(right: BorderSide(width: 1.2,
                                                       style: BorderStyle.solid,color: Colors.black45

                                              ))),
                                          child: Tab(
                                            child: Text("Current Balance",style:TextStyle(fontSize: 16,
                                            letterSpacing: 0.6
                                            ),),
                                          ),

                                        ),
                                        Container(
                                          //decoration:  BoxDecoration(border: Border(right: BorderSide( width: 1, style: BorderStyle.solid))),
                                          child: Tab(
                                            child: Text("Profit",style: TextStyle(fontSize: 16,letterSpacing: 0.7),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: TabBarView(
                                    children: [
                                      SingleChildScrollView(
                                        child: build_data(),
                                        physics: BouncingScrollPhysics(),
                                      ),
                                      Profitspage(phonenumber:widget.phonenumber)
                                    ],
                                  )),


                                ],
                              ),
                            ),

                        ),


              ],
            ),
      ),
    );
  }

  build_data() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
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
                height: MediaQuery.of(context).size.height/6.3,
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
                                child: Text("Current Balance",
                                    style: TextStyle(
                                        letterSpacing: 0.9,
                                        fontSize: 15,
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
            ),
          ),
            SizedBox(height: 25,),
            build_portfolio(),
          build_field(),
          build_button(),

          SizedBox(height: 20,),
        ],
      ),
    );
  }
  get_invests() {
    double? value = 0.0;
    return Container(
      child: FutureBuilder<DocumentSnapshot?>(
        future: authentication.get_investments(widget.phonenumber!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var portfolio = snapshot.data;
            current_balance = get_total(portfolio);
            current_balance = authentication.get_format(current_balance.toStringAsFixed(2));
            return Container(
              margin: EdgeInsets.only(bottom: 5.6),
              child: Text(
                current_balance.toString(),
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 16.2,
                    letterSpacing: 0.6,
                    fontFamily: "Poppins-Medium"),
              ),
            );
          }
          return Container(
              child: Text( value.toString(),
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 16.2,
                      letterSpacing: 0.6,
                      fontFamily: "Poppins-Medium")));
        },
      ),
    );
  }


  get_total(DocumentSnapshot<Object?>? portfolio) {
    List values = portfolio!.get("Portfolio");
    double total = 0.0;
    for (int i = 0; i < values.length; i++) {
      total = total + double.parse(values[i]);
    }
    return total;
  }

  build_portfolio() {
    return Container(
      child: FutureBuilder<DocumentSnapshot?>(
        future: authentication.get_investments(widget.phonenumber!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? data_length;
            var detail = snapshot.data;
            List investAmount = detail!.get("Portfolio");
            endDate = detail.get("endDate");
            return Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Invest Amount",
                        style: TextStyle(
                            color: Colors.brown, fontFamily: "Poppins-Medium"),
                      ),
                      Text("End Date",
                          style: TextStyle(
                              color: Colors.brown, fontFamily: "Poppins-Medium"))
                    ],
                  ),
                ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: investAmount.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: 12.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: RadioListTile(
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      authentication.get_format(investAmount[index]),
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          letterSpacing: 0.5,
                                          fontSize: 15.3,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins-Light"),
                                    ),
                                    Container(
                                      child: Text(
                                        endDate![index].toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 0.5,
                                            fontSize: 15,
                                            fontFamily: "Poppins"),
                                      ),
                                      alignment: Alignment.topRight,
                                    )
                                  ],
                                ),
                                value: investAmount[index].toString(),
                                groupValue: data,
                                onChanged: (value) {
                                  setState(() {
                                    data = value.toString();
                                    check = true;
                                    if(check==true){
                                      values=[];
                                      values!.add(data);
                                      index_value = index;
                                      values!.add(endDate![index].toString());
                                    }
                                  });
                                },
                                toggleable: true,
                                activeColor: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                      );
                    })
              ],
            );
          } if(snapshot.hasError) {
            return Container();
          }return Center(child: CircularProgressIndicator(color: Colors.green,),);
        },
      ),
    );
  }
  build_field() {
    const _locale = 'Hi';
    String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(horizontal: 25.3,vertical: 5.3),
            child: const Text(
              "Enter Withdrawl Amount",
              style: TextStyle(
                  color: Colors.deepOrange, fontFamily: "Poppins-Medium"),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 5.8, left: 12.3, right: 12.3),
                    child: TextFormField(
                      onChanged: (string) {
                        string = '${_formatNumber(string.replaceAll(',', ''))}';
                        debitController.value = TextEditingValue(
                          text: string,
                          selection: TextSelection.collapsed(offset: string.length),
                        );
                      },
                      keyboardType:TextInputType.number,
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
          ),
          pressed == false
              ? Text(
            "Available amount is greater than Debit Amount",
            style: TextStyle(color: Colors.red),
          )
              : Text(""),
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
            DateTime todaydate = DateTime.now();
            var date = DateFormat("dd-MM-yyy").format(todaydate);

            setState(() {
              if(formKey.currentState!.validate()){
                String str = debitController.text;
                str = str.replaceAll(",", "");
                double debit_amount = double.parse(str);
                add_data(date,debit_amount);
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
  add_data(String date, double debit_amount) async {
    var data = await authentication.get_investments(widget.phonenumber!);
    if (check == false) {
      double amount = double.parse(values![0]);
      if (amount >= debit_amount) {
        setState(() {
          inprogress = true;
          pressed = true;
          double after_withdraw = amount - debit_amount;
          List listofvalues = data!.get("Portfolio");
          listofvalues[index_value!] = after_withdraw.toString();
          Map<String, dynamic>updatedata = {
            "Portfolio": listofvalues
          };
          FirebaseFirestore.instance.collection("razor_investments").doc(
              data.id).update(updatedata);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  userPannel(phonenumber: widget.phonenumber,)));
        });
      } else {
        inprogress = false;
        pressed = false;
      }
    } else {
      double amount = double.parse(values![0]);
      if (amount >= debit_amount) {
        setState(() {
          inprogress = true;
          pressed = true;
          double after_withdraw = amount - debit_amount;
          List listofvalues = data!.get("Portfolio");
          listofvalues[index_value!] = after_withdraw.toString();
          Map<String, dynamic>updatedata = {
            "Portfolio": listofvalues
          };
          FirebaseFirestore.instance.collection("razor_investments").doc(
              data.id).update(updatedata);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  userPannel(phonenumber: widget.phonenumber,)));
        });
      }
    }
  }
}
