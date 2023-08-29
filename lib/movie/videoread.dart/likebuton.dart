import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vines/constant/bddconstant.dart';
import 'package:vines/controller/appcontroller.dart';

class Likebuton extends StatefulWidget {
  Likebuton({Key? key, required this.idserie}) : super(key: key);
  String idserie;
  @override
  _LikebutonState createState() => _LikebutonState();
}

class _LikebutonState extends State<Likebuton> {
  late Stream<QuerySnapshot> streamlike = FirebaseFirestore.instance
      .collection(Bddconstant.UserF)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(Bddconstant.dataUserMovie)
      .where("idserie", isEqualTo: widget.idserie)
      .where("like", isEqualTo: true)
      .snapshots();
  final appcontroller = Get.put(Appcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: streamlike,
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
          return (snapshot.data!.docs.isEmpty)
              ? GestureDetector(
                  onTap: () {
                    appcontroller.adddlike(widget.idserie);
                  },
                  child: const Icon(
                    IconsaxOutline.heart,
                    size: 30,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    appcontroller.removelike(
                        snapshot.data!.docs.first.id, widget.idserie);
                  },
                  child: const Icon(
                    IconsaxBold.heart,
                    size: 30,
                    color: Colors.red,
                  ),
                );
        },
      ),
    );
  }
}
