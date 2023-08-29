import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vines/constant/bddconstant.dart';
import 'package:vines/login_screen/home.dart';
import 'package:vines/movie/videoread.dart/watchVideo.dart';

class Appcontroller extends GetxController {
  // variable de firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var userid = FirebaseAuth.instance.currentUser!.uid.obs;
  var instance = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance.obs;

  // variable de globale
  var isLoading = false.obs;
  var loadingGoogle = false.obs;
  var idshop = "".obs;
  var serieList = [].obs;
  var videonomw = [].obs;
  var searchResults = [].obs;
  var myserie = [].obs;
  var mysearch = [].obs;
  var textsearch = "".obs;
  var serierecommande = [].obs;
  // variable information utilisateur
  var nomUser = "".obs;
  var avatarUser = "".obs;
  var typecompteUser = 0.obs;
  var expirationUser = "".obs;
  var readi = true.obs;
  var email = "".obs;
  var nbrescreen = 0.obs;
  // initialisation
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getallserie();
    getmyserie();
    getmysearch();
    getrecommandeserie();
    getuserinfo();
  }

  messagesuccess(message) {
    Get.snackbar("Success", message,
        colorText: Colors.white,
        shouldIconPulse: true,
        backgroundColor: Colors.greenAccent,
        icon: const Icon(
          IconsaxBold.check,
          color: Colors.white,
        ));
  }

  messageerror(message) {
    Get.snackbar("Echec", message,
        colorText: Colors.white,
        shouldIconPulse: true,
        backgroundColor: Colors.red,
        icon: const Icon(
          IconsaxBold.close_square,
          color: Colors.white,
        ));
  }

  getuserinfo() {
    instance
        .collection(Bddconstant.UserF)
        .where("uid", isEqualTo: userid.value)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        print(element);
        nomUser.value = element["mail"];
        avatarUser.value = (element["avatar"] == null) ? "" : element["avatar"];
        typecompteUser.value = element["typecompte"];
        expirationUser.value = element["expiration"];
        readi.value = element["readi"];
        email.value = element["mail"];
        nbrescreen.value = element["nbrescreen"];
      }
    });
  }

  deconnexion() {
    _auth.signOut();
    Get.to(() => LoginPage());
  }

  getallserie() {
    instance
        .collection(Bddconstant.seriF)
        .where("nbrevideo", isNotEqualTo: 0)
        .snapshots()
        .listen((event) {
      serieList.value = event.docs;
    });
  }

  getrecommandeserie() {
    instance
        .collection(Bddconstant.seriF)
        .where("nbrevideo", isNotEqualTo: 0)
        .where("recommande", isEqualTo: false)
        .snapshots()
        .listen((event) {
      serierecommande.value = event.docs;
    });
  }

  getmyserie() {
    instance
        .collection(Bddconstant.UserF)
        .doc(userid.value)
        .collection(Bddconstant.dataUserMovie)
        .where("read", isEqualTo: true)
        .snapshots()
        .listen((event) {
      myserie.value = event.docs;
    });
  }

  getmysearch() {
    instance
        .collection(Bddconstant.UserF)
        .doc(userid.value)
        .collection(Bddconstant.seachUserofMovie)
        .snapshots()
        .listen((event) {
      mysearch.value = event.docs;
    });
  }

  getserirNow(idcompte) {
    instance
        .collection(Bddconstant.seriF)
        .doc(idcompte)
        .collection(Bddconstant.videoF)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        // ignore: invalid_use_of_protected_member
        videonomw.value.add(element["videourl"]);
      }
    });
  }

  searchSeriesByName(String searchTerm) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Bddconstant.seriF)
        .where('nomserie', isGreaterThanOrEqualTo: searchTerm)
        .where('nomserie', isLessThan: searchTerm + 'z')
        .get();
    searchResults.value = snapshot.docs;
  }

  adddlike(idvideo) {
    var datamovie = {
      "iduser": userid.value,
      "date": DateTime.now(),
      "read": false,
      "like": true,
      "allread": false
    };
    var datauser = {
      "idserie": idvideo,
      "date": DateTime.now(),
      "read": false,
      "like": true,
      "allread": false
    };
    instance
        .collection(Bddconstant.UserF)
        .doc(userid.value)
        .collection(Bddconstant.dataUserMovie)
        .doc(idvideo)
        .set(datauser, SetOptions(merge: true));

    instance
        .collection(Bddconstant.seriF)
        .doc(idvideo)
        .collection(Bddconstant.dataUserMovie)
        .doc(userid.value)
        .set(datamovie, SetOptions(merge: true));
  }

  removelike(idlike, idvideo) {
    instance
        .collection(Bddconstant.UserF)
        .doc(userid.value)
        .collection(Bddconstant.dataUserMovie)
        .doc(idlike)
        .update({"like": false});
    instance
        .collection(Bddconstant.seriF)
        .doc(idvideo)
        .collection(Bddconstant.dataUserMovie)
        .doc(userid.value)
        .update({"like": false});
  }

  watchmovieNow(idvideo) {
    var datamovie = {
      "iduser": userid.value,
      "date": DateTime.now(),
      "read": true,
      "allread": false
    };
    var datauser = {
      "idserie": idvideo,
      "date": DateTime.now(),
      "read": true,
      "allread": false
    };
    instance
        .collection(Bddconstant.UserF)
        .doc(userid.value)
        .collection(Bddconstant.dataUserMovie)
        .doc(idvideo)
        .set(datauser, SetOptions(merge: true));

    instance
        .collection(Bddconstant.seriF)
        .doc(idvideo)
        .collection(Bddconstant.dataUserMovie)
        .doc(userid.value)
        .set(datamovie, SetOptions(merge: true));
  }

  continueMovie(String idvideo, String idcompte) {
    // ignore: invalid_use_of_protected_member
    if (videonomw.value.isEmpty) {
      instance
          .collection(Bddconstant.seriF)
          .doc(idvideo)
          .collection(Bddconstant.videoF)
          .snapshots()
          .listen((event) {
        for (var element in event.docs) {
          // ignore: invalid_use_of_protected_member
          videonomw.value.add(element["videourl"]);
          print(element["videourl"]);
        }
      });
      messageerror(
          "Nous avons rencontrer un probleme ressayez dans un instant");
    } else {
      var datamovie = {
        "iduser": userid.value,
        "date": DateTime.now(),
        "read": true,
        "allread": false
      };
      var datauser = {
        "idserie": idvideo,
        "date": DateTime.now(),
        "read": true,
        "allread": false
      };
      instance
          .collection(Bddconstant.UserF)
          .doc(userid.value)
          .collection(Bddconstant.dataUserMovie)
          .doc(idvideo)
          .set(datauser, SetOptions(merge: true));

      instance
          .collection(Bddconstant.seriF)
          .doc(idvideo)
          .collection(Bddconstant.dataUserMovie)
          .doc(userid.value)
          .set(datamovie, SetOptions(merge: true));
      Get.to(() => WatchVideo(
            idcompte: idcompte,
            idserie: idvideo,
          ));
    }
  }

  searchMovie(String datasearch) async {
    QuerySnapshot<Map<String, dynamic>> documentList = await instance
        .collection(Bddconstant.seriF)
        .where("seach", arrayContains: datasearch)
        .get();
    searchResults.value = documentList.docs;
  }

  setSearchParam() {
    String caseNumber = "Dexter la fin du monde".lowerCamelCase;
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    print(caseSearchList);
    instance
        .collection(Bddconstant.seriF)
        .doc("pOMFJZuB1GFnODAdBZT9")
        .update({"seach": caseSearchList});
  }

  addsearch(idserie, nomserie) {
    var data = {
      "idserie": idserie,
      "nomserie": nomserie,
      "date": DateTime.now()
    };
    instance
        .collection(Bddconstant.UserF)
        .doc(userid.value)
        .collection(Bddconstant.seachUserofMovie)
        .doc(idserie)
        .set(data);
  }
}
