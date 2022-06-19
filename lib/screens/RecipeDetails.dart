import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projek_pemob/models/RecipeModel.dart';
import 'package:projek_pemob/models/ReviewModel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../widgets/ReviewUi.dart';
import 'package:projek_pemob/models/controller.dart';
import 'package:get/get.dart';

final Controller myController = Get.find();

class RecipeDetails extends StatefulWidget {
  final String namaMinuman;
  final String bahan;
  final String langkah;
  final String image;
  final String kategori;
  final bool favorite;

  RecipeDetails(this.namaMinuman, this.bahan, this.langkah, this.image,
      this.favorite, this.kategori,
      {Key? key})
      : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState(
      namaMinuman, bahan, langkah, image, favorite, kategori);
}

class _RecipeDetailsState extends State<RecipeDetails> {
  String _namaMinuman;
  String _bahan;
  String _langkah;
  String _image;
  String _kategori;
  bool _favorite;

  _RecipeDetailsState(this._namaMinuman, this._bahan, this._langkah,
      this._image, this._favorite, this._kategori);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: myController.switchValue.value
          ? Color.fromARGB(230, 0, 0, 0)
          : Colors.white,
      body: SlidingUpPanel(
        parallaxEnabled: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        minHeight: (size.height / 2),
        maxHeight: size.height / 1.2,
        color: myController.switchValue.value
            ? Color.fromARGB(230, 0, 0, 0)
            : Colors.white,
        panel: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                _namaMinuman,
                style: TextStyle(
                    color: myController.switchValue.value
                        ? Colors.white
                        : Colors.black,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Writer",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "183",
                    style: TextStyle(
                      color: myController.switchValue.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.timer,
                    color: myController.switchValue.value
                        ? Colors.white
                        : Colors.black,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "30'",
                    style: TextStyle(
                      color: myController.switchValue.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: myController.switchValue.value
                        ? Colors.white
                        : Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Kategori : $_kategori",
                    style: TextStyle(
                      color: myController.switchValue.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: myController.switchValue.value
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.3),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.red,
                        tabs: [
                          Tab(
                            text: "Bahan-bahan".toUpperCase(),
                          ),
                          Tab(
                            text: "Langkah-langkah".toUpperCase(),
                          ),
                          Tab(
                            text: "Reviews".toUpperCase(),
                          ),
                        ],
                        labelColor: myController.switchValue.value
                            ? Colors.white
                            : Colors.black,
                        indicator: DotIndicator(
                          color: myController.switchValue.value
                              ? Colors.white
                              : Colors.black,
                          distanceFromCenter: 16,
                          radius: 3,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        unselectedLabelColor: myController.switchValue.value
                            ? Colors.white.withOpacity(0.3)
                            : Colors.black.withOpacity(0.3),
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                      ),
                      Divider(
                        color: myController.switchValue.value
                            ? Colors.white.withOpacity(0.3)
                            : Colors.black.withOpacity(0.3),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            isiTab(text: _bahan),
                            isiTab(text: _langkah),
                            Review()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: _image,
                    child: ClipRRect(
                      child: Image(
                        width: double.infinity,
                        height: (size.height / 2) + 50,
                        fit: BoxFit.cover,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class isiTab extends StatelessWidget {
  const isiTab({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            margin: EdgeInsets.only(top: 5, left: 10),
            child: Text(
              "${text}",
              style: TextStyle(
                color: myController.switchValue.value
                    ? Colors.white
                    : Colors.black,
              ),
              textAlign: TextAlign.justify,
            )),
      ],
    );
  }
}

class Review extends StatefulWidget {
  Review({
    super.key,
  });

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myController.switchValue.value
            ? Color.fromARGB(230, 0, 0, 0)
            : Colors.white,
        body: ListView.separated(
          itemCount: reviewer.length,
          itemBuilder: (context, index) {
            return reviewUi(
              image: reviewer[index].image,
              tanggal: reviewer[index].tanggal,
              name: reviewer[index].name,
              rating: reviewer[index].rating,
              onTap: () => setState(() {
                isMore = !isMore;
              }),
              isLess: isMore,
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ));
  }
}
