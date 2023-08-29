import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';
import 'package:vines/constant/bddconstant.dart';
import 'package:vines/controller/appcontroller.dart';
import 'package:vines/movie/videoread.dart/likebuton.dart';
import 'package:vines/movie/videoread.dart/lookbutton.dart';
import 'package:vines/movie/videoread.dart/watchVideo.dart';

class MovieDetailPage extends StatefulWidget {
  MovieDetailPage(
      {Key? key,
      required this.posterurl,
      required this.idvideo,
      required this.nomserie,
      required this.idcompte,
      required this.description})
      : super(key: key);
  String posterurl;
  String idvideo;
  String nomserie;
  String idcompte;
  String description;
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  VideoPlayerController? _controller;
  Duration? _videoDuration;
  String dure = "";
  late Stream<QuerySnapshot> streamteam = FirebaseFirestore.instance
      .collection(Bddconstant.ConstantFirestorebdbusiness)
      .doc(widget.idcompte)
      .collection(Bddconstant.teamF)
      .snapshots();
  final appcontroller = Get.put(Appcontroller());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      body: getBody(size),
    );
  }

  Widget getBody(size) {
    return Column(
      children: [
        Container(
          height: size.height * 0.42,
          width: size.width,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.4,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.posterurl),
                        fit: BoxFit.cover)),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white),
                          onPressed: () {
                            appcontroller.videonomw.value = [];
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.shade100),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            child: Likebuton(
                              idserie: widget.idvideo,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 105,
                            child: Lookbutton(
                                idserie: widget.idvideo,
                                idcompte: widget.idcompte),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.download,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.nomserie,
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        widget.description,
                        maxLines: 9,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Equipe",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: StreamBuilder(
                    stream: streamteam,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var length = snapshot.data!.docs.length;

                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: length,
                          itemBuilder: (context, index) {
                            var equipe = snapshot.data!.docs[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 20,
                                  left: index == 0 ? 15 : 10,
                                  right: index == (3 - 1) ? 15 : 0,
                                  bottom: 20),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color(0xffFAFAFA)
                                                  .withOpacity(0.2),
                                              blurRadius: 7,
                                              offset: const Offset(0, 3))
                                        ],
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(equipe['avatar']),
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 2,
                                    child: Center(
                                      child: Text(
                                        equipe['nom'],
                                        style: const TextStyle(
                                            color: Color(0xffFAFAFA)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
                // const Padding(
                //   padding: EdgeInsets.all(10),
                //   child: Text("Suggestion",
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 20,
                //           fontWeight: FontWeight.w500)),
                // ),
                const HeightBox(10),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: List.generate(3, (index) {
                //       return Padding(
                //         padding: EdgeInsets.only(
                //             left: index == 0 ? 15 : 10,
                //             right: index == (3 - 1) ? 15 : 0),
                //         child: Container(
                //           height: 180,
                //           width: 140,
                //           decoration: BoxDecoration(
                //             color: Colors.red,
                //             borderRadius: BorderRadius.circular(7),
                //             // image: DecorationImage(
                //             //   image: NetworkImage(netflixOriginals[index]),
                //             //   fit: BoxFit.cover,
                //             // )
                //           ),
                //         ),
                //       );
                //     }),
                //   ),
                // ),
                // const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
