import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vines/controller/appcontroller.dart';
import 'package:vines/movie/videoread.dart/readvideo.dart';

class HomeScreenmovie extends StatefulWidget {
  const HomeScreenmovie({Key? key}) : super(key: key);

  @override
  _HomeScreenmovieState createState() => _HomeScreenmovieState();
}

class _HomeScreenmovieState extends State<HomeScreenmovie> {
  late int selectedPage;
  late final PageController _pageController;
  final appcontroller = Get.put(Appcontroller());
  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const pageCount = 5;
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      appBar: AppBar(
        backgroundColor: const Color(0xff181818),
        title: const Text(
          'Nian',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(children: [
                    Container(
                      width: size.width,
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)),
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            selectedPage = page;
                          });
                        },
                        children: List.generate(pageCount, (index) {
                          return Center(
                            child: Text('Page $index'),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        child: PageViewDotIndicator(
                          borderRadius: BorderRadius.circular(100),
                          currentItem: selectedPage,
                          count: pageCount,
                          unselectedColor: Colors.black26,
                          selectedColor: Colors.blue,
                          duration: const Duration(milliseconds: 200),
                          boxShape: BoxShape.rectangle,
                          onItemClicked: (index) {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                            );
                          },
                        ))
                  ]),
                  const HeightBox(20),
                  const Text(
                    'Serie recommandee',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const HeightBox(10),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: appcontroller.serierecommande.length,
                        itemBuilder: (context, index) {
                          var serierecommande = appcontroller.serieList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      MovieDetailPage(
                                    posterurl: serierecommande["posterurl"],
                                    idvideo: serierecommande["idserie"],
                                    nomserie: serierecommande["nomserie"],
                                    description: serierecommande["description"],
                                    idcompte: serierecommande["idcompte"],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              width: 160,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(7)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CachedNetworkImage(
                                  imageUrl: serierecommande["posterurl"],
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
                        }),
                  ),
                  const HeightBox(20),
                  const Text(
                    'Serie populaire',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const HeightBox(10),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: appcontroller.serieList.length,
                        itemBuilder: (context, index) {
                          var seriepopulaire = appcontroller.serieList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      MovieDetailPage(
                                    posterurl: seriepopulaire["posterurl"],
                                    idvideo: seriepopulaire["idserie"],
                                    nomserie: seriepopulaire["nomserie"],
                                    description: seriepopulaire["description"],
                                    idcompte: seriepopulaire["idcompte"],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              height: 180,
                              width: 150,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(7)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CachedNetworkImage(
                                  imageUrl: seriepopulaire["posterurl"],
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
                        }),
                  ),
                  if (appcontroller.myserie.isNotEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const HeightBox(20),
                        const Text(
                          'Ce que vous regardez',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const HeightBox(10),
                        SizedBox(
                          height: 130,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: appcontroller.myserie.length,
                              itemBuilder: (context, index) {
                                var serievregarde =
                                    appcontroller.serieList[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            MovieDetailPage(
                                          posterurl: serievregarde["posterurl"],
                                          idvideo: serievregarde["idserie"],
                                          nomserie: serievregarde["nomserie"],
                                          description:
                                              serievregarde["description"],
                                          idcompte: serievregarde["idcompte"],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        height: 130,
                                        width: 190,
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                serievregarde["posterurl"],
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: SizedBox(
                                                height: 30,
                                                width: 30,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 10,
                                          left: 15,
                                          child: SizedBox(
                                            width: 170,
                                            child: Center(
                                              child: LinearProgressIndicator(
                                                color: Colors.red,
                                                value: 0.6,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  const HeightBox(20),
                  const Text(
                    'Toute les series',
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                  const HeightBox(10),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: appcontroller.serieList.value.length,
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
                      var serie = appcontroller.serieList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  MovieDetailPage(
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
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
