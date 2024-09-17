import 'package:app/screens/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/cubit/product_cubit.dart';
import 'package:app/widgets/items_container.dart';
import 'package:app/widgets/clothes_category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/widgets/bottom_navbar.dart';
import 'package:app/models/product.dart';
import 'package:app/screens/search.dart';

TextStyle discountTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: 16,
  height: 18.75 / 16,
  letterSpacing: 0.05,
  color: Color(0xFFFFF5BE),
);

TextStyle searchPlaceholderStyle = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 12.0,
  height: 14.06 / 12.0,
  letterSpacing: 0.05,
  color: Colors.white70,
);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.error != null) {
          return Center(child: Text(state.error!));
        } else if (state.products != null) {
          final newArrivals =
              state.products!.where((product) => product.isNewArrival).toList();
          final bestSellers =
              state.products!.where((product) => product.isBestSeller).toList();

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF2C2C2C),
                title: Row(
                  children: [
                    Image.asset(
                      'assets/MOOL_home.png',
                      width: 94,
                      height: 28,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.white, size: 28.0),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              insetPadding: EdgeInsets.zero,
                              child: SearchScreen(),
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications_outlined,
                          color: Colors.white, size: 24.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()),
                        );
                      },
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(48.0),
                  child: TabBar(
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: "WOMEN"),
                      Tab(text: "MEN"),
                    ],
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicatorWeight: 3.0,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildTabContent(
                        [
                          'SALE ',
                          'View All',
                          'Dresses',
                          'Tops',
                          'Bottoms',
                          'T-Shirts',
                        ],
                        newArrivals,
                        bestSellers,
                      ),
                      _buildTabContent(
                        ['User A', 'User B', 'User C'],
                        newArrivals,
                        bestSellers,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CustomBottomNavBar(
                      icons: [
                        'assets/home_navbar1.png',
                        'assets/home_navbar2.png',
                        'assets/home_navbar3.png',
                        'assets/home_navbar4.png',
                        'assets/home_navbar5.png',
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _buildTabContent(List<String> categories, List<Product> newArrivals,
      List<Product> bestSellers) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 230, 230, 230),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                child: Row(
                  children: categories
                      .map((category) => Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: ClothesCategory(
                              imageUrl: 'assets/home2.png',
                              text: category,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 32),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/truck.png',
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '48 HOURS DELIVERY',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 16.41 / 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 240,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 300),
                autoPlayCurve: Curves.easeIn,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      'assets/home_feed.png',
                      height: 240,
                      width: 312,
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3, 4, 5].map((i) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == i - 1
                        ? Color(0xFF38BCDD)
                        : Colors.grey,
                    border: Border.all(
                      color: Color(0xFF38BCDD),
                      width: 1,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 156,
                  height: 184,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage('assets/home_static.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 156,
                  height: 184,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage('assets/home_static.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 224,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage('assets/brands.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ItemsSection(sectionHeader: 'New Arrival', products: newArrivals),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Color(0xFF292D32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get up to 15% off with code :',
                    style: discountTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFFFF5BE),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '45689',
                      style: discountTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ItemsSection(sectionHeader: 'Best Sellers', products: bestSellers),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
