import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projek_pemob/models/controller.dart';
import 'package:get/get.dart';

final Controller myController = Get.find();

class reviewUi extends StatelessWidget {
  final String image, name, tanggal;
  final double rating;
  final VoidCallback onTap;
  final bool isLess;

  const reviewUi({
    Key? key,
    required this.image,
    required this.name,
    required this.tanggal,
    required this.rating,
    required this.onTap,
    required this.isLess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myController.switchValue.value
          ? Color.fromARGB(230, 0, 0, 0)
          : Colors.white,
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 16, right: 0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(45),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 14,
                      color: myController.switchValue.value
                          ? Colors.white
                          : Colors.black),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: myController.switchValue.value
                        ? Colors.white
                        : Colors.black,
                  ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                child: RatingBar.builder(
                  itemSize: 16,
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Text(
                  tanggal,
                  style: TextStyle(
                      fontSize: 13,
                      color: myController.switchValue.value
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
              child: isLess
                  ? Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      style: TextStyle(
                          fontSize: 14,
                          color: myController.switchValue.value
                              ? Colors.white
                              : Colors.black),
                      textAlign: TextAlign.justify,
                    )
                  : Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: myController.switchValue.value
                              ? Colors.white
                              : Colors.black),
                      textAlign: TextAlign.justify,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
