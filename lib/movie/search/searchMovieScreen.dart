import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vines/controller/appcontroller.dart';
import 'package:vines/movie/videoread.dart/readvideo.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({Key? key}) : super(key: key);

  @override
  _SearchMovieScreenState createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  final appcontroller = Get.put(Appcontroller());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Obx(() => Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xff181818),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: null,
                    onChanged: (value) {
                      appcontroller.textsearch.value = value.lowerCamelCase;
                      appcontroller.searchMovie(appcontroller.textsearch.value);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 20, right: 20),
                      hintText: 'Rechercher une serie',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  const HeightBox(20),
                  if (appcontroller.mysearch.value.isEmpty)
                    const Text(
                      'Effectuer votre premiere recherche',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  if (appcontroller.mysearch.value.isNotEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Vos recherches precedentes',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const HeightBox(20),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: appcontroller.mysearch.length,
                              itemBuilder: (context, index) {
                                var result = appcontroller.serieList[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            MovieDetailPage(
                                          posterurl: result["posterurl"],
                                          idvideo: result["idserie"],
                                          nomserie: result["nomserie"],
                                          description: result["description"],
                                          idcompte: result["idcompte"],
                                        ),
                                      ),
                                    );
                                  },
                                  child: ActionChip(
                                      onPressed: () {},
                                      avatar: const Icon(
                                        IconsaxBold.search_normal,
                                        size: 25,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      backgroundColor: Colors.grey.shade100,
                                      label: Text(result["nomserie"])),
                                );
                              }),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (appcontroller.searchResults.isNotEmpty &&
                      appcontroller.textsearch.value.isNotEmpty)
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appcontroller.searchResults.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            300, // Largeur maximale souhaitée pour chaque élément
                        mainAxisSpacing:
                            8, // Espacement vertical entre les éléments
                        crossAxisSpacing:
                            8, // Espacement horizontal entre les éléments
                        childAspectRatio:
                            0.8, // Ratio de largeur sur hauteur des éléments
                      ),
                      itemBuilder: (context, index) {
                        var result = appcontroller.searchResults[index];
                        return GestureDetector(
                          onTap: () {
                            appcontroller.addsearch(
                                result["idserie"], result["nomserie"]);
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    MovieDetailPage(
                                  posterurl: result["posterurl"],
                                  idvideo: result["idserie"],
                                  nomserie: result["nomserie"],
                                  description: result["description"],
                                  idcompte: result["idcompte"],
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
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: result["posterurl"],
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
                    ),
                  if (appcontroller.searchResults.isEmpty &&
                      appcontroller.textsearch.value.isNotEmpty)
                    Text(
                      'Aucune serie commence par : ' +
                          appcontroller.textsearch.value,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                ],
              ),
            )),
      )),
    );
  }
}
