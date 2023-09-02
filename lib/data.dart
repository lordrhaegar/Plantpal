import 'package:plant_app/models/cart_item.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/models/recently_viewed.dart';
Future<List<Plant>>? allPlants;
List<Plant> recommended = [
  Plant(
    uid: '',
    plantType: 'Indoor',
    plantName: 'Snake Plant',
    plantPrice: 80.0,
    stars: 4.0,
    plantDetails: "The snake plant, commonly referred to as mother-in-law\'s tongue, is a resilient succulent that can grow anywhere between 6 inches to several feet. In addition to providing a bit of ambiance, snake plants have a number of health benefits, including: filter indoor air. remove toxic pollutants.",
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/snake_plant.png',
  ),
  Plant(
    uid: '',
    plantType: 'Indoor',
    plantName: 'Palm',
    plantPrice: 480.0,
    stars: 3.5,
    plantDetails: "The snake plant, commonly referred to as mother-in-law\'s tongue, is a resilient succulent that can grow anywhere between 6 inches to several feet. In addition to providing a bit of ambiance, snake plants have a number of health benefits, including: filter indoor air. remove toxic pollutants.",
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/Palm.png',
  ),
  Plant(
    uid: '',
    plantType: 'Outdoor',
    plantName: 'Ficus Alli',
    plantPrice: 600.0,
    stars: 3.0,
    plantDetails: "The snake plant, commonly referred to as mother-in-law\'s tongue, is a resilient succulent that can grow anywhere between 6 inches to several feet. In addition to providing a bit of ambiance, snake plants have a number of health benefits, including: filter indoor air. remove toxic pollutants.",
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/ficuss_alii.png',
  ),
  Plant(
    uid: '',
    plantType: 'Outdoor',
    plantName: 'Money Bonsai',
    plantPrice: 4000.0,
    stars: 4.0,
    plantDetails: "The snake plant, commonly referred to as mother-in-law\'s tongue, is a resilient succulent that can grow anywhere between 6 inches to several feet. In addition to providing a bit of ambiance, snake plants have a number of health benefits, including: filter indoor air. remove toxic pollutants.",
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/money_bonsai.png',
  ),
  Plant(
    uid: '',
    plantType: 'Outdoor',
    plantName: 'Juniper Bonsai',
    plantPrice: 2000.0,
    stars: 3.5,
    plantDetails: "The snake plant, commonly referred to as mother-in-law\'s tongue, is a resilient succulent that can grow anywhere between 6 inches to several feet. In addition to providing a bit of ambiance, snake plants have a number of health benefits, including: filter indoor air. remove toxic pollutants.",
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/Juniper_Bonsai.png',
  ),
];

List<ViewHistory> viewed = [
  ViewHistory('Calathea', 'It\'s spines don\'t grow.', 'images/calathea.jpg'),
  ViewHistory('Cactus', 'It has spines.', 'images/cactus.jpg'),
  ViewHistory('Stephine', 'It\'s spines do grow.', 'images/stephine_2.jpg'),
];

List<CartItem> cartItems = [
  CartItem(
    Plant(
      uid: '',
      plantType: 'Indoor',
      plantName: 'Calathea',
      plantPrice: 100,
      image: 'images/calathea.jpg',
      stars: 3.5,
      plantDetails: "The snake plant, commonly referred to as mother-in-law\'s tongue, is a resilient succulent that can grow anywhere between 6 inches to several feet. In addition to providing a bit of ambiance, snake plants have a number of health benefits, including: filter indoor air. remove toxic pollutants.",
      metrics: PlantMetrics('', '', ''),
    ),
    2,
  ),
  ];
