import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/plant.dart';

class PlantRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Plant>> fetchAllPlants() async {
    List<Plant> plants = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('plants').get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? productData = documentSnapshot.data() as Map<String, dynamic>?;
        print("productData: $productData");
        if (productData != null) {
          String documentUid = documentSnapshot.id;
          print(documentUid);
          Plant plant = Plant(
            uid: documentUid,
            plantDetails: productData['About'] ?? '',
            plantType: productData['category'] ?? '',
            plantName: productData['Name'] ?? '',
            plantPrice: (productData['Price'] ?? 0).toDouble(),
            stars: (productData['stars'] ?? 0).toDouble(),
            image: productData['image_url'] ?? '',
            metrics: PlantMetrics(
              productData['Height'] ?? '',
              productData['Humidity'] ?? '',
              productData['Width'] ?? '',
            ),
          );

          plants.add(plant);
        }
      }
    } catch (e) {
      print('Error fetching plants: $e');
    }
    return plants;
  }

  Future<List<Plant>> fetchPlantsByName(String plantName) async {
    List<Plant> plants = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('plants')
          .where('Name', isEqualTo: plantName)
          .get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? productData =
        documentSnapshot.data() as Map<String, dynamic>?;

        if (productData != null) {
          String documentUid = documentSnapshot.id;
          print(documentUid);
          Plant plant = Plant(
            uid: documentUid,
            plantDetails: productData['About'] ?? '',
            plantType: productData['category'] ?? '',
            plantName: productData['Name'] ?? '',
            plantPrice: (productData['Price'] ?? 0).toDouble(),
            stars: (productData['stars'] ?? 0).toDouble(),
            image: productData['image_url'] ?? '',
            metrics: PlantMetrics(
              productData['Height'] ?? '',
              productData['Humidity'] ?? '',
              productData['Width'] ?? '',
            ),
          );

          plants.add(plant);
        }
      }
    } catch (e) {
      print('Error fetching plants by name: $e');
    }
    print(plants);
    return plants;
  }

  Future<List<Plant>> fetchUserFavoritePlants() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userFavoritesDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

      final docSnapshot = await userFavoritesDoc.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final favorites = data['favorites'] as List<dynamic>;

        final List<String> favoriteUIDs = favorites.cast<String>();
        final List<Plant> favoritePlants = [];

        for (String uid in favoriteUIDs) {
          final plantSnapshot = await FirebaseFirestore.instance.collection('plants').doc(uid).get();
          if (plantSnapshot.exists) {
            final plantData = plantSnapshot.data() as Map<String, dynamic>;
            Plant plant = Plant(
              uid: uid,
              plantDetails: plantData['About'] ?? '',
              plantType: plantData['category'] ?? '',
              plantName: plantData['Name'] ?? '',
              plantPrice: (plantData['Price'] ?? 0).toDouble(),
              stars: (plantData['stars'] ?? 0).toDouble(),
              image: plantData['image_url'] ?? '',
              metrics: PlantMetrics(
                plantData['Height'] ?? '',
                plantData['Humidity'] ?? '',
                plantData['Width'] ?? '',
              ),
            );
            favoritePlants.add(plant);
          }
        }
        print("favoritePlants: $favoritePlants");
        return favoritePlants;
      }
    }

    return []; // Return an empty list if user is not logged in or has no favorites
  }

}

