// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_tut/verify.dart';
import 'package:flutter/material.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final phoneNumberController = TextEditingController();
    final auth = FirebaseAuth.instance;
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img1.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We need to register your phone without getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        auth.verifyPhoneNumber(
                        autoRetrievedSmsCodeForTesting: '000000',
                          codeAutoRetrievalTimeout: (e) {
                            // showDialog(
                            //     context: context,
                            //     builder: ((BuildContext context) {
                            //       return AlertDialog(
                            //         content: Text('Retry please1 , $e'),
                            //         actions: [
                            //           GestureDetector(
                            //               onTap: () {
                            //                 Navigator.pop(context);
                            //               },
                            //               child: const Text('ok'))
                            //         ],
                            //       );
                            //     }));
                          },
                          phoneNumber:
                              '${countryController.text.trim()}${phoneNumberController.text.trim()}',
                          verificationCompleted: (_) {},
                          verificationFailed: (e) {
                            showDialog(
                                context: context,
                                builder: ((BuildContext context) {
                                  return AlertDialog(
                                    content:
                                        Text('Retry2 please , $e', overflow: TextOverflow.visible),
                                    actions: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('ok'))
                                    ],
                                  );
                                }));
                          },
                          codeSent: (String verificationId, int? token) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyVerify(
                                          verficationId: verificationId,
                                        )));
                          },
                          // codeAutoRetrievalTimeout:codeAutoRetrievalTimeout
                        );
                        // Navigator.pushNamed(context, 'verify');
                      },
                      child: Text("Send the code")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
