import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  CollectionReference userInfo = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Information'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: userInfo.snapshots(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            documentSnapshot['name'].toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            documentSnapshot['type'].toString(),
                            style: TextStyle(fontSize: 30, color: Colors.red),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            documentSnapshot['email'].toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    );
                  }));
            }
            return Container();
          }),
        ));
  }
}
