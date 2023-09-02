import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/components/curve.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/data.dart';
import 'package:plant_app/screens/plant_details_screen.dart';
import '../components/notification/custom_snack_bar.dart';
import '../components/notification/top_snack_bar.dart';
import '../repository/fetch_user_details.dart';
import '../models/plant.dart';
import '../repository/plant_repository.dart';
class FavScreen extends StatefulWidget {
  final String uid;
  const FavScreen({
    required this.uid,
    Key? key}) : super(key: key);

  static const String id = 'HomeScreen';


  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  int selected = 0;
  Map<String,dynamic>? userData;
  String? userName;
  List<Plant>? plants;
  TextEditingController searchController = TextEditingController();
  List<Plant> searchResults = [];

  @override
  void initState() {
    super.initState();
  }
  void _runSearch() async {
    String searchText = searchController.text.trim();
    if (searchText.isEmpty) {
      setState(() {
        searchResults.clear();
      });
    } else {
      print(searchText);
      List<Plant> results = await PlantRepository().fetchPlantsByName(
          searchText);
      print(results);
      if (results.isEmpty) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message:
            "No Plants Match Your Search",
          ),
        );
      }
      setState(() {
        searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String,dynamic>>(
      future: fetchUserDetails(widget.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          userData = snapshot.data;
          userName = userData!['username'];
          print('User Details: $userData}');

          return SafeArea(
            child: Scaffold(
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                '$userName\'s Favorites Plants.',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  color: kDarkGreenColor,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          TextField(
                            textInputAction: TextInputAction.search,
                            onSubmitted: (String searchText){_runSearch();},
                            style: TextStyle(color: kDarkGreenColor),
                            cursorColor: kDarkGreenColor,
                            controller: searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: kGinColor,
                              hintText: 'Search Plant',
                              hintStyle: TextStyle(color: kGreyColor),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                color: kDarkGreenColor,
                                iconSize: 26.0,
                                splashRadius: 20.0,
                                onPressed: _runSearch,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: kGinColor),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kGinColor),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kGinColor),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          // CategorySelector(
                          //   selected: selected,
                          //   categories: const [
                          //     'Plant',
                          //     'Accessories'
                          //   ],
                          //   onTap: (index) {
                          //     setState(() {
                          //       selected = index;
                          //     });
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    FutureBuilder<List<Plant>>(
                      future: searchResults.isNotEmpty || searchResults == null? Future.value(searchResults) : PlantRepository().fetchUserFavoritePlants(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          plants = snapshot.data!;
                          return Expanded(
                            flex: 9,
                            child: DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  Material(
                                    child: Container(
                                      child: TabBar(
                                        padding: EdgeInsets.symmetric(vertical: 0),
                                        physics: const ClampingScrollPhysics(),
                                        unselectedLabelColor: kDarkGreenColor,
                                        indicatorSize: TabBarIndicatorSize.label,
                                        indicator: BoxDecoration(
                                            borderRadius: BorderRadius.circular(9),
                                            color: kDarkGreenColor
                                        ),
                                        tabs: [
                                          Tab(
                                            child: Container(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("Plant"),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Container(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("Accessories"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        Stack(
                                          children: [
                                            SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(15, 8.0, 8.0, 8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GridView.builder(
                                                      clipBehavior: Clip.none,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      itemCount: plants!.length,
                                                      itemBuilder: (context, index) {
                                                        return PlantCard(
                                                          plantType: plants?[index]
                                                              .plantType ?? '',
                                                          plantName: plants?[index]
                                                              .plantName ?? '',
                                                          plantPrice: plants?[index]
                                                              .plantPrice ?? 0,
                                                          image: Image.asset(
                                                            recommended[index].image,
                                                            alignment: Alignment.topLeft,
                                                          ),
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) {
                                                                  Plant? stalk;
                                                                  return PlantDetails(
                                                                    plant: plants?[index] ??
                                                                        stalk,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }, gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 200,
// childAspectRatio: 3 / 2,
                                                        crossAxisSpacing: 20,
                                                        mainAxisSpacing: 20
                                                    ),
                                                    ),                        ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GridView.builder(
                                                      clipBehavior: Clip.none,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      itemCount: plants!.length,
                                                      itemBuilder: (context, index) {
                                                        return PlantCard(
                                                          plantType: plants?[index]
                                                              .plantType ?? '',
                                                          plantName: plants?[index]
                                                              .plantName ?? '',
                                                          plantPrice: plants?[index]
                                                              .plantPrice ?? 0,
                                                          image: Image.asset(
                                                            recommended[index].image,
                                                            alignment: Alignment.topLeft,
                                                          ),
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) {
                                                                  Plant? stalk;
                                                                  return PlantDetails(
                                                                    plant: plants?[index] ??
                                                                        stalk,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }, gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 200,
// childAspectRatio: 3 / 2,
                                                        crossAxisSpacing: 20,
                                                        mainAxisSpacing: 20
                                                    ),
                                                    ),                        ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}



class RecentlyViewedCard extends StatelessWidget {
  const RecentlyViewedCard({
    required this.plantName,
    required this.plantInfo,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String plantName;
  final String plantInfo;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        const SizedBox(width: 24.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              plantName,
              style: GoogleFonts.poppins(
                color: kDarkGreenColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              plantInfo,
              style: GoogleFonts.poppins(
                color: kGreyColor,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class PlantCard extends StatelessWidget {
  const PlantCard({
    required this.plantType,
    required this.plantName,
    required this.plantPrice,
    required this.image,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String plantType;
  final String plantName;
  final double plantPrice;
  final Image image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 170.0,
            width: 170.0,
            decoration: BoxDecoration(
              color: kGinColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
          Positioned(
            left: 8.0,
            bottom: 50.0,
            child: Container(
              constraints:
              const BoxConstraints(maxWidth: 90.0, maxHeight: 90.0),
              child: Hero(tag: plantName, child: image),
            ),
          ),
          Positioned(
            left: 50.0,
            bottom: 40.0,
            child: Container(
              width: 90,
              height: 95.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plantType,
                            style: TextStyle(
                              color: kDarkGreenColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Expanded(
                            child: Text(
                              plantName,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                color: kDarkGreenColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: kFoamColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      constraints: const BoxConstraints(maxWidth: 90.0),
                      child: Text(
                        '₹${plantPrice}0',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          color: kDarkGreenColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    required this.selected,
    required this.categories,
    required this.onTap,
  }) : super(key: key);

  final int selected;
  final List<String> categories;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < categories.length; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              padding: EdgeInsets.symmetric(
                vertical: selected == i ? 8.0 : 0.0,
                horizontal: selected == i ? 12.0 : 0.0,
              ),
              decoration: BoxDecoration(
                color: selected == i ? kGinColor : Colors.transparent,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: GestureDetector(
                onTap: () {
                  onTap(i);
                },
                child: Align(
                  child: Text(
                    categories[i],
                    style: TextStyle(
                      color: selected == i ? kDarkGreenColor : kGreyColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
