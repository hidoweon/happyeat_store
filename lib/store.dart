import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}
class _StoreState extends State<Store> {
  CollectionReference restaurants =
  FirebaseFirestore.instance.collection('restaurant');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: restaurants.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  return Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          child: Container(
                              child: Image.network(
                                documentSnapshot['ImageUrl'].toString(), fit: BoxFit.cover, height:100, width: 100,)

                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(documentSnapshot['name']),
                              Text(documentSnapshot['kind']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}