// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_tut/cloud_fireStore/garage_details.dart';
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: readData(),
                  builder: (context, snapshoot) {
                    if (snapshoot.hasData) {
                      final users = snapshoot.data!;
                      return Column(
                          children: List.generate(users.length, (index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 28.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'lat   :   ${users[index].garageDetails.coordinates.lat}'),
                                  Text(
                                      'long  :   ${users[index].garageDetails.coordinates.long}'),
                                  Text(
                                      'firstName   :  ${users[index].garageDetails.firstName}'),
                                  Text(
                                      'garageAddress  :   ${users[index].garageDetails.garageAddress}'),
                                  Text(
                                      'garageName  :   ${users[index].garageDetails.garageName}'),
                                  Text(
                                      'garageSubtitle   :  ${users[index].garageDetails.garageSubtitle}'),
                                  Text(
                                      'lastName   :  ${users[index].garageDetails.lastName}'),
                                  Text(
                                      'phoenNumber  :   ${users[index].garageDetails.phoenNumber}'),
                                  Text(
                                      'rating   :  ${users[index].garageDetails.rating}'),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade600),
                                    onPressed: () async {
                                      updateData(data: users[index]);
                                    },
                                    child: Text('Update Data')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade600),
                                    onPressed: () async {
                                      await deleteData(data: users[index]);
                                    },
                                    child: Text('Delete Data')),
                              ],
                            )
                          ],
                        );
                      }));
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600),
                  onPressed: () async {
                    await createUser();
                  },
                  child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createUser() async {
    // if you remove id from [doc] then firebase will generate id automatically
    // insted of json you can make model class with to json method
    final user = GarageDetailsData(
        uid: '5',
        coordinates: Coordinates(lat: 200.541534, long: 2515.0510),
        firstName: 'John',
        garageAddress: 'address 1',
        garageName: 'abcd',
        garageSubtitle: 'subtitle 222222',
        lastName: 'Doe',
        phoenNumber: '21581384',
        rating: 4);
    final userData = GarageDetails(garageDetails: user);
    final json2 = userData.toJson();
    await dbInstance.collection('garege').doc('5').set(json2);
  }

  updateData({required GarageDetails data}) async {
    data.garageDetails.firstName = 'asdfghjkl;';
    await dbInstance
        .collection('garege')
        .doc(data.garageDetails.uid)
        .update(data.toJson());
  }
}

Stream<List<GarageDetails>> readData() => FirebaseFirestore.instance
    .collection('garege')
    .snapshots()
    .map((snapShoot) => snapShoot.docs
        .map((doc) => GarageDetails.fromJson(doc.data()))
        .toList());

deleteData({required GarageDetails data}) {
  final updateData = FirebaseFirestore.instance
      .collection('garege')
      .doc(data.garageDetails.uid)
      .delete();
}
