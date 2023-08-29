import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vines/constant/bddconstant.dart';
import 'package:vines/controller/appcontroller.dart';

class Lookbutton extends StatefulWidget {
  Lookbutton({Key? key, required this.idserie, required this.idcompte})
      : super(key: key);
  String idserie;
  String idcompte;
  @override
  _LookbuttonState createState() => _LookbuttonState();
}

class _LookbuttonState extends State<Lookbutton> {
  late Stream<QuerySnapshot> streamlook = FirebaseFirestore.instance
      .collection(Bddconstant.UserF)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(Bddconstant.dataUserMovie)
      .where("idserie", isEqualTo: widget.idserie)
      .where("read", isEqualTo: true)
      .snapshots();
  final appcontroller = Get.put(Appcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: streamlook,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ActionChip(
              onPressed: () {
                appcontroller.continueMovie(widget.idserie, widget.idcompte);
              },
              elevation: 0,
              backgroundColor: (snapshot.data!.docs.isEmpty)
                  ? Colors.black.withBlue(30)
                  : Colors.orange,
              side: BorderSide(
                color: (snapshot.data!.docs.isEmpty)
                    ? Colors.black.withBlue(30)
                    : Colors.orange,
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(100)),
              label: Text(
                (snapshot.data!.docs.isEmpty) ? 'Regader' : "Continuer",
                style: const TextStyle(color: Colors.white),
              ));
        },
      ),
    );
  }
}
