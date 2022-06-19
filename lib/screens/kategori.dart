import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projek_pemob/Screens/FavoritPage.dart';
import 'package:projek_pemob/widgets/kategori_card.dart';
import 'package:projek_pemob/models/controller.dart';
import 'package:get/get.dart';

final Controller myController = Get.find();

class PageKategori extends StatelessWidget {
  const PageKategori({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myController.switchValue.value
          ? Color.fromARGB(230, 0, 0, 0)
          : Colors.white,
      child: ListView(
        children: [
          kategoriSection(heading: "Panas".toLowerCase()),
          SizedBox(
            height: 10,
          ),
          kategoriSection(heading: "Dingin".toLowerCase()),
          SizedBox(
            height: 10,
          ),
          kategoriSection(heading: "keduanya".toLowerCase()),
        ],
      ),
    );
  }
}

class kategoriSection extends StatefulWidget {
  final String heading;

  kategoriSection({required this.heading});

  @override
  State<kategoriSection> createState() => _kategoriSectionState();
}

class _kategoriSectionState extends State<kategoriSection> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("minuman");
    return Column(
      children: [
        Container(
          color: myController.switchValue.value
              ? Color.fromARGB(230, 0, 0, 0)
              : Colors.white,
          margin: EdgeInsets.only(top: 20, left: 20),
          child: Text(
            "${widget.heading}".toUpperCase(),
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color:
                  myController.switchValue.value ? Colors.white : Colors.black,
            ),
          ),
        ),
        Container(
            color: myController.switchValue.value
                ? Color.fromARGB(230, 0, 0, 0)
                : Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection('minuman')
                      .where('kategori', isEqualTo: '${widget.heading}')
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          height: MediaQuery.of(context).size.height / 1.3,
                          child: Center(child: CircularProgressIndicator()));
                    } else if (snapshot.hasData && snapshot.data?.size == 0) {
                      return noDataWidget(
                        text: "Kategori",
                      );
                    } else {
                      return Column(
                        children: snapshot.data!.docs
                            .map(
                              (e) => CardKategori(
                                e.get('namaMinuman'),
                                e.get('bahan'),
                                e.get('langkah'),
                                e.get('image'),
                                e.get('favorite'),
                                e.get('kategori'),
                                heading: "${widget.heading}",
                              ),
                            )
                            .toList(),
                      );
                    }
                  },
                ),
              ],
            )),
        SizedBox(width: 25)
      ],
    );
  }
}
