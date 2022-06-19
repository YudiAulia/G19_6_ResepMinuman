import 'package:flutter/material.dart';
import 'package:projek_pemob/screens/LandingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projek_pemob/models/controller.dart';
import 'package:get/get.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final String hintText;

  SearchWidget({
    Key? key,
    required this.text,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Controller myController = Get.find();
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Stack(
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.fromLTRB(16, 16, 65, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(color: Colors.black26),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              icon: Icon(Icons.search, color: style.color),
              suffixIcon: widget.text.isNotEmpty
                  ? GestureDetector(
                      child: Icon(Icons.close, color: style.color),
                      onTap: () {
                        controller.clear();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    )
                  : null,
              hintText: widget.hintText,
              hintStyle: style,
              border: InputBorder.none,
            ),
            style: style,
          ),
        ),
        Positioned(
          top: 23,
          left: MediaQuery.of(context).size.width - 45,
          child: InkWell(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool("showHome", false);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => landingPage()));
            },
            child: Icon(
              Icons.logout_outlined,
              color:
                  myController.switchValue.value ? Colors.white : Colors.black,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }
}
