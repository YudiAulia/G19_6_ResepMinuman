import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projek_pemob/Screens/RecipeDetails.dart';
import 'package:projek_pemob/models/RecipeModel.dart';
import 'package:projek_pemob/widgets/favorite_card.dart';
import 'package:projek_pemob/models/controller.dart';
import 'package:get/get.dart';

final Controller myController = Get.find();

class favoritePage extends StatefulWidget {
  @override
  State<favoritePage> createState() => _favoritePageState();
}

class _favoritePageState extends State<favoritePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("minuman");
    return Scaffold(
      backgroundColor: myController.switchValue.value
              ? Color.fromARGB(230, 0, 0, 0)
              : Colors.white,
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('minuman')
                .where('favorite', isEqualTo: true)
                .snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasData && snapshot.data?.size == 0) {
                return noDataWidget(
                  text: "favorite",
                );
              } else {
                // got data and it is not empty
                return Column(
                  children: snapshot.data!.docs
                      .map(
                        (e) => CardFavorite(
                          e.get('namaMinuman'),
                          e.get('bahan'),
                          e.get('langkah'),
                          e.get('image'),
                          e.get('favorite'),
                          e.get('kategori'),
                          onUpdate: () {
                            if (e.get('favorite') == false) {
                              users.doc(e.id).update({'favorite': true});
                            } else {
                              users.doc(e.id).update({'favorite': false});
                            }
                          },
                        ),
                      )
                      .toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class noDataWidget extends StatelessWidget {
  final String text;
  const noDataWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      alignment: Alignment.center,
      child: Text(
        "belum ada $text".toUpperCase(),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                myController.switchValue.value ? Colors.white : Colors.black),
      ),
    );
  }
}
