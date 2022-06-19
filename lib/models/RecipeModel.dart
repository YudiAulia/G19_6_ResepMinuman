import 'package:flutter/material.dart';

class RecipeModel {
  String bahan;
  String namaMinuman;
  String langkah;
  String image;
  String kategori;
  bool favorite;

  RecipeModel({
    required this.bahan,
    required this.image,
    required this.namaMinuman,
    required this.langkah,
    required this.kategori,
    required this.favorite,
  });
}
