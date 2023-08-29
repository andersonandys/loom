import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vines/home_page/menu.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class Startuser extends StatefulWidget {
  const Startuser({Key? key}) : super(key: key);

  @override
  _StartuserState createState() => _StartuserState();
}

class _StartuserState extends State<Startuser> {
  File? selectedImage;
  bool loadavatar = false;
  String urlavatar = "";
  TextEditingController nomuser = TextEditingController();
  String userid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information du profil'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const Text(
              'Renseigner votre photo de profil et votre nom utilisateur pour finaliser la creation de votre compte',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const HeightBox(50),
            Expanded(
                child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    onImageSelect();
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent),
                    child: Stack(
                      children: [
                        (urlavatar == "")
                            ? Image.asset(
                                "assets/noavatar.png",
                                fit: BoxFit.cover,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  urlavatar,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        if (loadavatar)
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: CircularProgressIndicator(),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                const Text(
                  'Photo de profil',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const HeightBox(50),
                TextField(
                  controller: nomuser,
                  decoration: InputDecoration(
                    label: const Text('Nom utilisateur'),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                )
              ],
            )),
            TextButton(
              onPressed: () {
                // Action to perform when the button is pressed
                saveuser();
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(
                      double.infinity, 60), // Adjust the height as needed
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Valider',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  saveuser() async {
    if (nomuser.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Nous vous prions de saisir un nom utilisateur',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (urlavatar.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Le code saisi est incorrect.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // Enregistrer si l'utilisateur a terminer la creation de son compte
      preferences.setBool('ready', true);
      FirebaseFirestore.instance
          .collection("users")
          .doc(userid)
          .update({"nom": nomuser.text, "avatar": urlavatar, "ready": true});
      Get.offAll(() => const MenuApp());
    }
  }

  pickImage() async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        loadavatar = true;
      });
      final AssetEntity assetEntity = result.first;
      final File? file = await assetEntity.file;
      return file!.path;
    }
    return null;
  }

  void onImageSelect() async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        loadavatar = true;
      });

      final AssetEntity assetEntity = result.first;
      final File? file = await assetEntity.file;

      if (file != null) {
        final bytes = await file.readAsBytes();

        // Définir la référence de l'image dans Firebase Storage
        final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
        final reference =
            FirebaseStorage.instance.ref().child('images').child(imageName);

        // Envoyer les données de l'image dans Firebase Storage
        await reference.putData(bytes);

        // Récupérer le lien de téléchargement de l'image
        final downloadUrl = await reference.getDownloadURL();

        setState(() {
          urlavatar = downloadUrl;
          loadavatar = false;
        });

        // Utiliser le lien de téléchargement comme souhaité
      }
    }
  }
}
