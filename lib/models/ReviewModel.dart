import 'package:flutter/material.dart';

class ReviewModel {
  String image;
  String name;
  String tanggal;
  double rating;

  ReviewModel({required this.image, required this.name, required this.rating, required this.tanggal});
}

List<ReviewModel> reviewer = [
  ReviewModel(
    rating: 5,
    name: "Reviewer 1",
    image: "assets/review/foto1.jpg",
    tanggal: "11 Juni 2022",
  ),
  ReviewModel(
    rating: 4.5,
    name: "Reviewer 2",
    image: "assets/review/foto2.jpg",
    tanggal: "03 Juni 2022",
  ),
  ReviewModel(
    rating: 4,
    name: "Reviewer 3",
    image: "assets/review/foto3.jpg",
    tanggal: "22 Mei 2022",
  ),
  ReviewModel(
    rating: 2.5,
    name: "Reviewer 4",
    image: "assets/review/foto4.jpg",
    tanggal: "18 Mei 2022",
  ),
  ReviewModel(
    rating: 3,
    name: "Reviewer 5",
    image: "assets/review/foto5.jpg",
    tanggal: "27 April 2022",
  ),
];
