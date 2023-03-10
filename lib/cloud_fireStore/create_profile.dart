// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_tut/cloud_fireStore/garage_details.dart';
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
  final dbInstance = FirebaseFirestore.instance;
  @override
  void initState() {
    // dbInstance = FirebaseFirestore.instance;
    super.initState();
  }

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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600),
                onPressed: () async {
                  await createUser(
                      name: nameController.text.trim(),
                      age: 2,
                      birth: ageController.text.trim());
                },
                child: Text('Submit')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600),
                onPressed: () async {
                  updateData(
                      age: int.parse(ageController.text.trim()),
                      birth: ageController.text.trim(),
                      name: nameController.text.trim());
                },
                child: Text('Update Data')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600),
                onPressed: () async {
                  await deleteData();
                },
                child: Text('Delete Data')),
            StreamBuilder(
                stream: readData(),
                builder: (context, snapshoot) {
                  if (snapshoot.hasData) {
                    final users = snapshoot.data!;
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text('lat ${users[index].coordinates.lat}'),
                            Text('long ${users[index].coordinates.long}'),
                            Text('data ${users[index].firstName}'),
                            Text('data ${users[index].garageAddress}'),
                            Text('data ${users[index].garageName}'),
                            Text('data ${users[index].garageSubtitle}'),
                            Text('data ${users[index].lastName}'),
                            Text('data ${users[index].phoenNumber}'),
                            Text('data ${users[index].rating}'),
                          ],
                        );
                      },
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

  Future<void> createUser(
      {required String name, required int age, required String birth}) async {
    // if you remove id from [doc] then firebase will generate id automatically
    // insted of json you can make model class with to json method
    final user = GarageDetailsData(
        uid: '123310',
        coordinates: Coordinates(lat: 200.541534, long: 2515.0510),
        firstName: 'John',
        garageAddress: 'address 1',
        garageName: 'abcd',
        garageSubtitle: 'subtitle 1',
        lastName: 'Doe',
        phoenNumber: '21581384',
        rating: 4);
    final userData = GarageDetails(garageDetails: user);
    final json2 = userData.toJson();
   await dbInstance.collection('garege').doc('xTIKXdggaRta7UhUGYZc').set(json2);
  }
}

updateData({required String name, required int age, required String birth}) {
  // final updateData = FirebaseFirestore.instance
  //     .collection('xTIKXdggaRta7UhUGYZc')
  //     .doc('garage_list');
  // final user = GarageItem(age: age, birthdate: birth, name: name);
  // final jsonData = user.toJson();
  // updateData.update(jsonData);
}

Stream<List<GarageDetailsData>> readData() => FirebaseFirestore.instance
    .collection('garege')
    .snapshots()
    .map((snapShoot) => snapShoot.docs
        .map((doc) => GarageDetailsData.fromJson(doc.data()))
        .toList());

deleteData() {
  final updateData = FirebaseFirestore.instance
      .collection('xTIKXdggaRta7UhUGYZc')
      .doc('garage_list');
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
