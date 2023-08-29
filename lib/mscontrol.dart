import 'dart:io';

import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mscontrol extends GetxController {
  var loadimage = false.obs;
  var abonnebusiness = [].obs;
  var alluser = [].obs;
  var verifMembrebranche = [].obs;
  var urlimage = "".obs;
  messagesuccess(message) {
    Get.snackbar("Success", message,
        colorText: Colors.white,
        shouldIconPulse: true,
        backgroundColor: Colors.greenAccent,
        icon: Icon(
          IconsaxBold.check,
          color: Colors.white,
        ));
  }

  messageerror(message) {
    Get.snackbar("Echec", message,
        colorText: Colors.white,
        shouldIconPulse: true,
        backgroundColor: Colors.red,
        icon: Icon(
          IconsaxBold.close_square,
          color: Colors.white,
        ));
  }

  void onImageSelect(context) async {
    loadimage.value = false;
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
      ),
    );

    if (result != null && result.isNotEmpty) {
      loadimage.value = true;

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

        urlimage.value = downloadUrl;
        loadimage.value = false;
        // Utiliser le lien de téléchargement comme souhaité
      }
    }
  }

  // recuperation des abonnements
  reqabonne() {
    FirebaseFirestore.instance
        .collection("business")
        .get()
        .then((QuerySnapshot value) {
      abonnebusiness.value = value.docs;
    });
  }

  // verifier si l utilisateur est admin dans la branche
  verifadminbranche(idbranche) {
    FirebaseFirestore.instance
        .collection("branche")
        .doc(idbranche)
        .collection("users")
        .where("iduser", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot value) {
      verifMembrebranche.value = value.docs;
    });
    return verifMembrebranche.value;
  }

  adduserbranche(idbranche, nature, userid, idcommunaute) {
    FirebaseFirestore.instance
        .collection("branche")
        .doc(idbranche)
        .update({"nbreuser": FieldValue.increment(1)});
    FirebaseFirestore.instance
        .collection("branche")
        .doc(idbranche)
        .collection("users")
        .add({
      "iduser": userid,
      "range": DateTime.now().millisecondsSinceEpoch,
      "expiration": "",
      "admin": false
    });
    FirebaseFirestore.instance.collection("abonnebranche").add({
      "iduser": userid,
      "idbranche": idbranche,
      "typecompte": "branche",
      "idcommunaute": idcommunaute,
      "range": DateTime.now().millisecondsSinceEpoch,
      "nature": nature,
      "expiration": (nature == "Abonnement") ? "26 / 6" : "",
      "idcreat": userid,
      "message": "Aucun message",
      "notification": 0
    });
  }

  reqalluser() {
    FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot value) {
      alluser.value = value.docs;
    });
    print(alluser.value);
  }
}
