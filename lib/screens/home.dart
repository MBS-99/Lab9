import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ourlab/screens/logIn.dart';
import 'package:ourlab/screens/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'information.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color myColor = Colors.red;
  String myVal = 'a';
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  var authObject2 = FirebaseAuth.instance;
  final CollectionReference my_users =
      FirebaseFirestore.instance.collection('users');

  Future<void> Update(my_type) async {
    await my_users.doc(authObject2.currentUser!.uid).update({'type': my_type});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userEmail == 'red@red.com') {
      myColor = Colors.red;
    }
    if (userEmail == 'green@green.com') {
      myColor = Colors.green;
    }
    if (userEmail == 'blue@blue.com') {
      myColor = Colors.blue;
    }
    if (userEmail == 'mix@mix.com') {
      myColor = Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: myColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RadioListTile(
                  title: Text("Admin"),
                  value: 'Admin',
                  groupValue: myVal,
                  onChanged: ((value) {
                    setState(() {
                      myVal = value.toString();
                      Update('Admin');
                    });
                  })),
              SizedBox(
                height: 30,
              ),
              RadioListTile(
                  title: Text("User"),
                  value: 'User',
                  groupValue: myVal,
                  onChanged: ((value) {
                    setState(() {
                      myVal = value.toString();
                      Update('User');
                    });
                  })),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Information();
                        },
                      ),
                    );
                  }),
                  child: Text("Information"))
            ],
          ),
        ),
      ),
    );
  }
}
