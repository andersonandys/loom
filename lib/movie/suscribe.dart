import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SubscriptionPage extends StatelessWidget {
  String message =
      "En vous abonnant, vous soutenez les créateurs et encouragez la création de contenu.\n \nVotre abonnement permet aux artistes de s'investir davantage dans leur passion et d'améliorer leur travail.\n \n Optez pour l'une de nos offres \n \n - Basic, Premium ou Custom, et faites partie de cette aventure inspirante !";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withBlue(10),
      appBar: AppBar(
        backgroundColor: Colors.black.withBlue(10),
        title: const Text(
          'Abonnements',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20,
                ),
                SubscriptionCarousel(),
              ],
            )),
      ),
    );
  }
}

class SubscriptionCarousel extends StatefulWidget {
  @override
  _SubscriptionCarouselState createState() => _SubscriptionCarouselState();
}

class _SubscriptionCarouselState extends State<SubscriptionCarousel> {
  int _currentIndex = 0;

  final List<SubscriptionCard> _subscriptionCards = [
    SubscriptionCard(
      title: 'Basic',
      price: '\700 XOF/mois',
      benefits: [
        'Accès aux vidéos en qualité standard',
        'Contenu exclusif',
        '1 écran en streaming simultané',
      ],
    ),
    SubscriptionCard(
      title: 'Premium',
      price: '\$1400 XOF/mois',
      benefits: [
        'Accès aux vidéos en qualité HD et Ultra HD',
        'Contenu exclusif',
        '4 écrans en streaming simultanés',
        'Téléchargements pour une visualisation hors ligne',
      ],
    ),
    SubscriptionCard(
      title: 'Custom',
      price: '2000 xof/mois',
      benefits: [
        'Choisissez vos createur de contenu pour personnalise ce que vous regarde',
        'Contenu exclusif',
        'Nombre d\'écrans en streaming personnalisé',
        'Personnalisation totale de votre abonnement',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _subscriptionCards.map((card) {
            return Builder(
              builder: (BuildContext context) {
                return card;
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _subscriptionCards.map((card) {
            int index = _subscriptionCards.indexOf(card);
            return Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> benefits;

  SubscriptionCard(
      {required this.title, required this.price, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      benefits.map((benefit) => Text('• $benefit')).toList(),
                ),
              ],
            )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour choisir l'offre
                print(title);
              },
              child: const Text("S'abonner"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
