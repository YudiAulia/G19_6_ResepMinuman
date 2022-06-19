import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projek_pemob/screens/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class landingPage extends StatefulWidget {
  const landingPage({super.key});

  @override
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            Column(
              children: [
                SizedBox(height: 70),
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 6,
                        offset: Offset(8, 8),
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage("assets/landing/page1.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Selamat Datang di Aplikasi Resep Minuman",
                  style: _textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Aplikasi ini menyediakan berbagai macam resep dari minuman",
                  style: _textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Tambah Resep Mu",
                  style: _textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Text(
                    "Anda dapat menambahkan sebuah resep baru pada form input",
                    style: _textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 90),
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 6,
                        offset: Offset(8, 8),
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage("assets/landing/page2.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 80),
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 6,
                        offset: Offset(8, 8),
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage("assets/landing/page3.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Lets Started",
                  style: _textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Klik tanda panah untuk memulai aplikasi",
                  style: _textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width/2.4,
              bottom: 50
            ),
            child: GestureDetector(
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Icon(
                      CupertinoIcons.forward,
                      color: Colors.white,
                      size: 40,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade700,
                        borderRadius: BorderRadius.circular(99)),
                  ),
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("showHome", true);

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
          )
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: const Text(
                        "SKIP",
                        style: TextStyle(color: Colors.black54),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                      child: const Text("NEXT",
                          style: TextStyle(color: Colors.black54))),
                ],
              ),
            ),
    );
  }
}
