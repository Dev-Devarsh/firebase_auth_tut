// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  TextEditingController _con1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    log('message ${600}');
    return Scaffold(
      appBar: AppBar(title: Text('App')),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('150534860440'),
              ),
              SizedBox(
                height: 650,
              ),
              Container(
                margin: EdgeInsets.all(8),
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: TextField(
                      controller: _con1,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
