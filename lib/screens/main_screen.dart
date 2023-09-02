import 'package:flutter/material.dart';
import 'package:plant_app/components/bottom_nav_bar.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/cart_screen.dart';
import 'package:plant_app/screens/favourites_screen.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/screens/profile_screen.dart';
import 'package:plant_app/screens/signup_screen.dart';

import 'admindash.dart';
import 'favourite_screen.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({
    required this.uid,
    Key? key}) : super(key: key);

  static const String id = 'MainScreen';


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int selectedIndex = 0;

  List<Widget> buildScreens(String uid) {
    return [
      HomeScreen(uid: uid),
      FavScreen(uid: uid),
      adminScreen(),
      ProfileScreen(uid: uid),
    ];
  }

  @override
  Widget build(BuildContext context, ) {
    List<Widget> screens = buildScreens(widget.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: kDarkGreenColor,
                radius: 22.0,
                backgroundImage: const AssetImage('images/IMG-20230814-WA0040.jpg'),
              ),
              onTap: () {},
            ),
            CircleAvatar(
              backgroundColor: kDarkGreenColor,
              radius: 22.0,
              child: IconButton(
                color: Colors.white,
                splashRadius: 28.0,
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        selectedColor: kDarkGreenColor,
        unselectedColor: kSpiritedGreen,
        onTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          Icon(Icons.shopping_cart_outlined),
          Icon(Icons.person),
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
