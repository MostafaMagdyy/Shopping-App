import 'package:flutter/material.dart';
import 'package:app/data/categories/categories.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:app/widgets/Category/category.dart';
import 'package:app/widgets/bottom_navbar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C2C2C),
              Color(0xFF292D32),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                child: CustomHeader(
                  headerText: 'Categories',
                  rightWidget: IconButton(
                    icon: Icon(Icons.search, color: Colors.white, size: 28.0),
                    onPressed: () {},
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 230, 230, 230),
                  ),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (ctx, index) {
                      final category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          print('Tapped on ${category.title}');
                        },
                        child: CategoryCard(
                          imageUrl: category.image,
                          categoryType: category.title,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        initialIndex: 1,
        icons: [
          'assets/home_navbar1.png',
          'assets/home_navbar2.png',
          'assets/home_navbar3.png',
          'assets/home_navbar4.png',
          'assets/home_navbar5.png',
        ],
      ),
    );
  }
}
