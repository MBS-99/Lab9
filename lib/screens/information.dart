import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  CollectionReference userInfo = FirebaseFirestore.instance.collection('users');
  var authObject1 = FirebaseAuth.instance;
  DocumentSnapshot? documentSnapshot;
  Future myFun() async {
    documentSnapshot = await userInfo.doc(authObject1.currentUser!.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: myFun(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  documentSnapshot!['name'].toString(),
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  documentSnapshot!['type'].toString(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  documentSnapshot!['email'].toString(),
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
