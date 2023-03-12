// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_tut/cloud_fireStore/parts_screen/parts_model.dart';
import 'package:flutter/material.dart';

class PartsScreen extends StatefulWidget {
  const PartsScreen({required this.fireStoreInstance});
  final FirebaseFirestore fireStoreInstance;

  @override
  State<PartsScreen> createState() => _PartsScreenState();
}

class _PartsScreenState extends State<PartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parts List Data'),
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
                              padding: const EdgeInsets.only(bottom: 28.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'uid   :   ${users[index].partsDetails.uid}'),
                                  Text(
                                      'lat   :   ${users[index].partsDetails.partsList}'),
                                  Text(
                                      'firstName   :  ${users[index].partsDetails.firstName}'),
                                  Text(
                                      'garageAddress  :   ${users[index].partsDetails.garageAddress}'),
                                  Text(
                                      'garageName  :   ${users[index].partsDetails.garageName}'),
                                  Text(
                                      'garageSubtitle   :  ${users[index].partsDetails.garageSubtitle}'),
                                  Text(
                                      'lastName   :  ${users[index].partsDetails.lastName}'),
                                  Text(
                                      'phoenNumber  :   ${users[index].partsDetails.phoenNumber}'),
                                  Text(
                                      'rating   :  ${users[index].partsDetails.rating}'),
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
                                    child: const Text('Update Data')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade600),
                                    onPressed: () async {
                                      await deleteData(data: users[index]);
                                    },
                                    child: const Text('Delete Data')),
                              ],
                            )
                          ],
                        );
                      }));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600),
                  onPressed: () async {
                    await createParts();
                  },
                  child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createParts() async {
    // if you remove id from [doc] then firebase will generate id automatically
    // insted of json you can make model class with to json method
    final user = PartsDetailsData(
        uid: '4',
        partsList: [],
        firstName: 'John',
        garageAddress: 'address 1',
        garageName: 'abcd',
        garageSubtitle: 'subtitle 222222',
        lastName: 'Doe',
        phoenNumber: '21581384',
        rating: 4);
    final userData = PartsDetails(partsDetails: user);
    final json2 = userData.toJson();
    await widget.fireStoreInstance.collection('partsList').doc('4').set(json2);
  }

  updateData({required PartsDetails data}) async {
    data.partsDetails.firstName = 'asdfghjkl;';
    data.partsDetails.partsList.add('part 1');
    await widget.fireStoreInstance
        .collection('partsList')
        .doc(data.partsDetails.uid)
        .update(data.toJson());
  }

  Stream<List<PartsDetails>> readData() => FirebaseFirestore.instance
      .collection('partsList')
      .snapshots()
      .map((snapShoot) => snapShoot.docs
          .map((doc) => PartsDetails.fromJson(doc.data()))
          .toList());

  deleteData({required PartsDetails data}) {
    widget.fireStoreInstance
        .collection('partsList')
        .doc(data.partsDetails.uid)
        .delete();
  }
}
