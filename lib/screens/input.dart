import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:projek_pemob/models/controller.dart';
import 'package:get/get.dart';

final Controller myController = Get.find();

class Input extends StatefulWidget {
  Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

enum Category { panas, dingin, keduanya }

class _InputState extends State<Input> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController bahanController = TextEditingController();
  final TextEditingController langkahController = TextEditingController();
  Category category = Category.panas;
  String imageName = "";
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  // final tulisan = ;
  final colors2 = <Color>[Colors.indigo, Colors.deepPurpleAccent];

  @override
  void dispose() {
    namaController.dispose();
    bahanController.dispose();
    langkahController.dispose();
    super.dispose();
  }

  String getCategory(Category value) {
    if (value == Category.panas) {
      return "panas";
    } else if (value == Category.dingin) {
      return "dingin";
    }
    return "keduanya";
  }

  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "minuman";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              // color: Colors.purple[100],
              color: myController.switchValue.value
                  ? Color.fromARGB(230, 0, 0, 0)
                  : Colors.white,
              child: ListView(
                padding: EdgeInsets.all(15),
                children: [
                  SizedBox(height: 40),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: myController.switchValue.value
                              ? Colors.white
                              : Colors.black,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Tambahkan Resep Baru",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: myController.switchValue.value
                              ? Colors.white
                              : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_drink),
                      hintText: "Masukkan Nama Minuman",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          controller: bahanController,
                          maxLines: 10,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: "Masukkan Bahan-Bahan",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          controller: langkahController,
                          maxLines: 10,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: "Masukkan Langkah-Langkah",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          height: 250,
                          width: 500,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Kategori Minuman: ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListTile(
                                title: Text("Panas"),
                                leading: Radio(
                                  groupValue: category,
                                  value: Category.panas,
                                  onChanged: (Category? value) {
                                    setState(() {
                                      category = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text("Dingin"),
                                leading: Radio(
                                  groupValue: category,
                                  value: Category.dingin,
                                  onChanged: (Category? value) {
                                    setState(() {
                                      category = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text("Keduanya"),
                                leading: Radio(
                                  groupValue: category,
                                  value: Category.keduanya,
                                  onChanged: (Category? value) {
                                    setState(() {
                                      category = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                      child:
                          imageName == "" ? Container() : Text("${imageName}")),
                  SizedBox(height: 10),
                  Container(
                    height: 80,
                    width: 100,
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(100, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Pilih Gambar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          imagePicker();
                        }),
                  ),
                  Container(
                    height: 80,
                    width: 100,
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(100, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Tambah Resep',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          //// ADD DATA HERE
                          _uploadImage();
                        }),
                  ),
                ],
              ),
            ),
    );
  }

  _uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    var uniqueKey = firestoreRef.collection(collectionName).doc();
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference reference =
        storageRef.ref().child(collectionName).child(uploadFileName);

    if (imagePath != null) {
      UploadTask uploadTask = reference.putFile(File(imagePath!.path));
      await uploadTask.whenComplete(() async {
        // Download URL gambar untuk disimpan ke firestore
        var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
        if (uploadPath.isNotEmpty) {
          if (namaController.text == '' ||
              bahanController.text == '' ||
              langkahController.text == '') {
            _showMessage("Data Masih Kosong");
          } else if (imageName == '') {
            _showMessage("Belum Memilih File");
          } else {
            firestoreRef.collection(collectionName).doc(uniqueKey.id).set({
              'namaMinuman': namaController.text,
              'bahan': bahanController.text,
              'langkah': langkahController.text,
              'favorite': false,
              'image': uploadPath,
              'kategori': '${getCategory(category)}'
            }).then((value) => _showMessage("Upload Berhasil"));
          }
        } else {
          _showMessage("Belum Memilih File");
        }
        setState(() {
          _isLoading = false;
          namaController.text = "";
          bahanController.text = "";
          langkahController.text = "";
          imageName = "";
        });
      });
    } else {
      _showMessage("File Kosong");
      _isLoading = false;
    }
  }

  _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }

  imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
      });
    }
  }
}
