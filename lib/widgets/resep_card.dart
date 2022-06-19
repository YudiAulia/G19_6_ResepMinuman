import 'package:flutter/material.dart';
import 'package:projek_pemob/Screens/RecipeDetails.dart';
import 'package:projek_pemob/models/controller.dart';
import 'package:get/get.dart';
import '../models/RecipeModel.dart';

class CardResep extends StatelessWidget {
  final RecipeModel _recipeModel;
  final Function? onFavorite;
  final Function? onEdit;
  final Function? onDelete;
  final Controller myController = Get.find();

  CardResep(this._recipeModel,
      {Key? key, this.onFavorite, this.onEdit, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetails(
                  _recipeModel.namaMinuman,
                  _recipeModel.bahan,
                  _recipeModel.langkah,
                  _recipeModel.image,
                  _recipeModel.favorite,
                  _recipeModel.kategori),
            ),
          );
        },
        child: Container(
          color: myController.switchValue.value
              ? Color.fromARGB(230, 0, 0, 0)
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
                          tag: _recipeModel.image,
                          child: Image(
                            image: NetworkImage(_recipeModel.image),
                            height: 270,
                            width: 270,
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _recipeModel.namaMinuman.toUpperCase(),
                            style: TextStyle(
                                color: myController.switchValue.value
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          _recipeModel.kategori == "keduanya" ?
                          Text(
                            "Panas & Dingin".toUpperCase(),
                            style: TextStyle(color: Colors.grey),
                          ) : Text(
                            _recipeModel.kategori.toUpperCase(),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 66),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              if (onFavorite != null) onFavorite!();
                            },
                            child: Icon(
                              _recipeModel.favorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          InkWell(
                            onTap: () {
                              if (onEdit != null) onEdit!();
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          InkWell(
                            onTap: () {
                              if (onDelete != null) onDelete!();
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 25,
                            ),
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
