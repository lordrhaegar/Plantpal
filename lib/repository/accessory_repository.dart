import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/accessory.dart';
import '../models/plant.dart';
class AccessoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Accessory>> fetchAllAccessory() async {
    List<Accessory> accessory = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('accessories').get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? productData = documentSnapshot.data() as Map<String, dynamic>?;
        print("productData: $productData");
        if (productData != null) {
          String documentUid = documentSnapshot.id;
          print(documentUid);
          Accessory accessoryy = Accessory(
            uid: documentUid,
            accDetails: productData['about'] ?? '',
            accName: productData['name'] ?? '',
            accPrice: (productData['price'] ?? 0).toDouble(),
            image: productData['image_url'] ?? '',
          );

          accessory.add(accessoryy);
        }
      }
    } catch (e) {
      print('Error fetching accessory: $e');
    }
    return accessory;
  }

  Future<List<Accessory>> fetchAccessoryByName(String accessoryName) async {
    List<Accessory> accessory = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('accessories')
          .where('name', isEqualTo: accessoryName)
          .get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? productData =
        documentSnapshot.data() as Map<String, dynamic>?;

        if (productData != null) {
          String documentUid = documentSnapshot.id;
          print(documentUid);
          Accessory accessoryy = Accessory(
            uid: documentUid,
            accDetails: productData['about'] ?? '',
            accName: productData['name'] ?? '',
            accPrice: (productData['price'] ?? 0).toDouble(),
            image: productData['image_url'] ?? '',
            );
          accessory.add(accessoryy);
        }
      }

    } catch (e) {
      print('Error fetching accessor by name: $e');
    }
    print(accessory);
    return accessory;
  }

  Future<List<Accessory>> fetchUserFavoriteAccessory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userFavoritesDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

      final docSnapshot = await userFavoritesDoc.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final favorites = data['favorite_plants'] as List<dynamic>;

        final List<String> favoriteUIDs = favorites.cast<String>();
        final List<Accessory> favoriteAccessories = [];

        for (String uid in favoriteUIDs) {
          final plantSnapshot = await FirebaseFirestore.instance.collection('accessories').doc(uid).get();
          if (plantSnapshot.exists) {
            final plantData = plantSnapshot.data() as Map<String, dynamic>;
            Accessory accessory = Accessory(
              uid: uid,
              accDetails: plantData['About'] ?? '',
              accName: plantData['Name'] ?? '',
              accPrice: (plantData['Price'] ?? 0).toDouble(),
              image: plantData['image_url'] ?? '',
              );
         favoriteAccessories.add(accessory);
          }
        }
        print("favoritePlants: $favoriteAccessories");
        return favoriteAccessories;
      }
    }

    return []; // Return an empty list if user is not logged in or has no favorites
  }

}

