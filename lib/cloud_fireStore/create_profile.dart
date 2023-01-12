// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
  const CreateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SubmitForm());
  }
}

class SubmitForm extends StatefulWidget {
  const SubmitForm({super.key});

  @override
  State<SubmitForm> createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: nameController,
                // keyboardType: TextInputType.,
                decoration: const InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    labelText: 'Name',
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600),
                onPressed: () async {
                  await createUser(name: nameController.text.trim());
                },
                child: Text('Submit')),
            StreamBuilder(
                stream: readData(),
                builder: (context, snapshoot) {
                  if (snapshoot.hasData) {
                    final users = snapshoot.data!;
                    return Column(
                      children: [
                        Text('age ${snapshoot.data!.map((e) => e.age)}'),
                        Text('name ${snapshoot.data!.map((e) => e.name)}'),
                        Text('bithdate ${snapshoot.data!.map((e) => e.birthdate)}'),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }

  Future<void> createUser({required String name}) async {
    // if you remove id from [doc] then firebase will generate id automatically
    final docUser = FirebaseFirestore.instance.collection('dev').doc('fsf');
    // insted of json you can make model class with to json method
    final json = {'name': name, 'age': 21, 'birth': DateTime(2000, 5, 22)};
    final user = UserData(age: 21, birthdate: '23-3-2002', name: name);
    final json2 = user.toJson();

    // await docUser.set(json);
    await docUser.set(json2);
  }
}

Stream<List<UserData>> readData() => FirebaseFirestore.instance
    .collection('dev')
    .snapshots()
    .map((snapShoot) => snapShoot.docs.map((doc) => UserData.fromJson(doc.data())).toList());

class UserData {
  int age;
  String name;
  String birthdate;
  UserData({
    required this.age,
    required this.name,
    required this.birthdate,
  });
  toJson() => {'age': this.age, 'name': this.name, 'birthdate': this.birthdate};

  static UserData fromJson(Map<String, dynamic> json) =>
      UserData(age: json['age'], name: json['name'], birthdate: json['birthdate']);
}
