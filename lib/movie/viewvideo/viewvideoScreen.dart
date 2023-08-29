import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vines/controller/appcontroller.dart';
import 'package:vines/movie/videoread.dart/readvideo.dart';

class ViewvideoScreen extends StatefulWidget {
  const ViewvideoScreen({Key? key}) : super(key: key);

  @override
  _ViewvideoScreenState createState() => _ViewvideoScreenState();
}

class _ViewvideoScreenState extends State<ViewvideoScreen> {
  final appcontroller = Get.put(Appcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const HeightBox(10),
              const Text(
                'Vos serie en cours de lecture',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              const HeightBox(20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: appcontroller.myserie.value.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                      300, // Largeur maximale souhaitée pour chaque élément
                  mainAxisSpacing: 8, // Espacement vertical entre les éléments
                  crossAxisSpacing:
                      8, // Espacement horizontal entre les éléments
                  childAspectRatio:
                      0.8, // Ratio de largeur sur hauteur des éléments
                ),
                itemBuilder: (context, index) {
                  var serie = appcontroller.serieList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => MovieDetailPage(
                            posterurl: serie["posterurl"],
                            idvideo: serie["idserie"],
                            nomserie: serie["nomserie"],
                            description: serie["description"],
                            idcompte: serie["idcompte"],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(7)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          imageUrl: serie["posterurl"],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
