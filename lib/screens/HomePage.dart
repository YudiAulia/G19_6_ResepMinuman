import 'package:flutter/material.dart';
import 'package:projek_pemob/Screens/FavoritPage.dart';
import 'package:projek_pemob/screens/input.dart';
import 'package:projek_pemob/models/controller.dart';
import 'package:projek_pemob/screens/kategori.dart';
import 'package:projek_pemob/widgets/NewRecipe.dart';
import 'package:projek_pemob/widgets/search_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Controller myController = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => Container(
              color:
                  myController.switchValue.value ? Colors.black : Colors.white,
              child: SafeArea(
                bottom: false,
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SearchWidget(text: '', hintText: 'Cari resep'),
                      TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.red,
                        tabs: [
                          Tab(
                            text: "resep baru".toUpperCase(),
                          ),
                          Tab(
                            text: "favorite".toUpperCase(),
                          ),
                          Tab(
                            text: "kategori".toUpperCase(),
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
                          horizontal: 24,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            NewRecipe(),
                            favoritePage(),
                            PageKategori()
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 50),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return Input();
                                  }));
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: myController.switchValue.value
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: myController.switchValue.value
                                        ? Colors.black
                                        : Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Text(
                                "Tambah Resep",
                                style: TextStyle(
                                  color: myController.switchValue.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Obx(
                                () => Padding(
                                  padding: EdgeInsets.only(left: 100),
                                  child: Transform.scale(
                                    scale: 1.5,
                                    child: Switch.adaptive(
                                      activeColor: Colors.white,
                                      inactiveTrackColor: Colors.black,
                                      activeTrackColor: Colors.grey[125],
                                      value: myController.switchValue.value,
                                      onChanged: (newValue) {
                                        myController.switchValue.value =
                                            newValue;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => Padding(
                                  padding: EdgeInsets.only(left: 100),
                                  child: Text(
                                    (myController.switchValue.value)
                                        ? "Dark"
                                        : "Light",
                                    style: TextStyle(
                                      color: myController.switchValue.value
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
