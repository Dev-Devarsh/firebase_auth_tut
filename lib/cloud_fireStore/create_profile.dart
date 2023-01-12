// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  final ageController = TextEditingController();
  final birthdateController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: ageController,
                // keyboardType: TextInputType.,
                decoration: const InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    labelText: 'age',
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: birthdateController,
                // keyboardType: TextInputType.,
                decoration: const InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    labelText: 'birth',
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600),
                onPressed: () async {
                  await createUser(
                      name: nameController.text.trim(),
                      age: int.parse(ageController.text.trim()),
                      birth: ageController.text.trim());
                },
                child: Text('Submit')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600),
                onPressed: () async {
                  updateData(
                      age: int.parse(ageController.text.trim()),
                      birth: ageController.text.trim(),
                      name: nameController.text.trim());
                },
                child: Text('Update Data')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600),
                onPressed: () async {
                  await deleteData();
                },
                child: Text('Delete Data')),
            StreamBuilder(
                stream: readData(),
                builder: (context, snapshoot) {
                  if (snapshoot.hasData) {
                    final users = snapshoot.data!;
                    return Column(
                      children: [
                        Text('age ${snapshoot.data!.map((e) => e.age)}'),
                        Text('name ${snapshoot.data!.map((e) => e.name)}'),
                        Text('bithdate ${snapshoot.data!.map((e) => e.birthdate.toString())}'),
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

  Future<void> createUser({required String name, required int age, required String birth}) async {
    // if you remove id from [doc] then firebase will generate id automatically
    final docUser = FirebaseFirestore.instance.collection('dev').doc('fsf');
    // insted of json you can make model class with to json method
    final json = {'name': name, 'age': age, 'birth': birth};
    final user = UserData(age: 21, birthdate: '23-3-2002', name: name);
    final json2 = user.toJson();

    // await docUser.set(json);
    await docUser.set(json2);
  }
}

updateData({required String name, required int age, required String birth}) {
  final updateData = FirebaseFirestore.instance.collection('dev').doc('fsf');
  final user = UserData(age: age, birthdate: birth, name: name);
  final jsonData = user.toJson();
  updateData.update(jsonData);
}

Stream<List<UserData>> readData() => FirebaseFirestore.instance
    .collection('dev')
    .snapshots()
    .map((snapShoot) => snapShoot.docs.map((doc) => UserData.fromJson(doc.data())).toList());

deleteData() {
  final updateData = FirebaseFirestore.instance.collection('dev').doc('fsf');
  //To access nested valued user [.] oprator in key of that like
  /* 
            name : {
              firstName: 'abc',
              lastNmae : 'xyz'
            },
            age : 22,
            birth: 1-1-2001
            
            => to delete nested field
            updateData.update({'name.firstName': FieldValue.delete()});

            => to update nested field
            updateData.update({'name.firstName': 'pqr'});

  */
  updateData.update({'name': FieldValue.delete()});
}

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
