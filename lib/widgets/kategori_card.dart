import 'package:flutter/material.dart';
import 'package:projek_pemob/screens/RecipeDetails.dart';
import 'package:projek_pemob/models/controller.dart';
import 'package:get/get.dart';

class CardKategori extends StatelessWidget {
  final String heading;
  final String namaMinuman;
  final String bahan;
  final String langkah;
  final String image;
  final String kategori;
  final bool favorite;
  final Controller myController = Get.find();

  CardKategori(this.namaMinuman, this.bahan, this.langkah, this.image,
      this.favorite, this.kategori,
      {required this.heading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetails(
                namaMinuman, bahan, langkah, image, favorite, kategori),
          ),
        );
      },
      child: Obx(
        () => Container(
          color: myController.switchValue.value
              ? Color.fromARGB(200, 0, 0, 0)
              : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Hero(
                          tag: image,
                          child: Image(
                            image: NetworkImage(image),
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namaMinuman.toUpperCase(),
                            style: TextStyle(
                              color: myController.switchValue.value
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            namaMinuman,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 1,
                          ),
                          Icon(
                            Icons.timer_outlined,
                            color: myController.switchValue.value
                                ? Colors.white
                                : Colors.black,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "30'",
                            style: TextStyle(
                                color: myController.switchValue.value
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
