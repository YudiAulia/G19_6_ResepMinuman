import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projek_pemob/Screens/RecipeDetails.dart';
import 'package:projek_pemob/screens/input.dart';
import 'package:projek_pemob/models/RecipeModel.dart';
import 'package:projek_pemob/widgets/resep_card.dart';
import 'package:projek_pemob/widgets/search_widget.dart';

import '../Screens/FavoritPage.dart';

class NewRecipe extends StatefulWidget {
  @override
  State<NewRecipe> createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController bahanController = TextEditingController();
  final TextEditingController langkahController = TextEditingController();
  late List<RecipeModel> resepList;
  String query = '';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("minuman");
    return Scaffold(
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: users.orderBy('namaMinuman', descending: false).snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasData && snapshot.data?.size == 0) {
                return noDataWidget(
                  text: "Resep",
                );
              } else {
                return Column(
                  children: snapshot.data!.docs
                      .map(
                        (e) => CardResep(
                          RecipeModel(
                            namaMinuman: e['namaMinuman'],
                            bahan: e['bahan'],
                            langkah: e['langkah'],
                            image: e['image'],
                            kategori: e['kategori'],
                            favorite: e['favorite'],
                          ),
                          onFavorite: () {
                            if (e.get('favorite') == false) {
                              users.doc(e.id).update({'favorite': true});
                            } else {
                              users.doc(e.id).update({'favorite': false});
                            }
                          },
                          onEdit: () {
                            namaController.text = e['namaMinuman'];
                            bahanController.text = e['bahan'];
                            langkahController.text = e['langkah'];
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      child: ListView(
                                        padding: EdgeInsets.all(15),
                                        children: [
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Update Resep".toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          TextField(
                                            controller: namaController,
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.local_drink),
                                              hintText: "Masukkan Nama Minuman",
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    20,
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  controller: bahanController,
                                                  maxLines: 10,
                                                  decoration: InputDecoration(
                                                    alignLabelWithHint: true,
                                                    hintText:
                                                        "Masukkan Bahan-Bahan",
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    20,
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  controller: langkahController,
                                                  maxLines: 10,
                                                  decoration: InputDecoration(
                                                    alignLabelWithHint: true,
                                                    hintText:
                                                        "Masukkan Langkah-Langkah",
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            height: 80,
                                            width: 100,
                                            padding: const EdgeInsets.all(15),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      100, 0, 0, 0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                                child: Text(
                                                  'update Resep'.toUpperCase(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  users.doc(e.id).update({
                                                    'namaMinuman':
                                                        namaController.text,
                                                    'bahan':
                                                        bahanController.text,
                                                    'langkah':
                                                        langkahController.text,
                                                  }).whenComplete(() =>
                                                      Navigator.pop(context));
                                                }),
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                          onDelete: () {
                            Widget cancelButton = TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                            Widget continueButton = TextButton(
                              child: Text("Continue"),
                              onPressed: () {
                                users
                                    .doc(e.id)
                                    .delete()
                                    .whenComplete(() => Navigator.pop(context));
                              },
                            );

                            AlertDialog alert = AlertDialog(
                              content: Text("Anda yakin mau menghapus?"),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
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
