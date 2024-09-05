import 'package:app/screens/filter.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/constants.dart';
import 'package:app/data/Search/search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2C2C),
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 40.0,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
                decoration: BoxDecoration(
                  color: Color(0xFF616161),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Colors.white),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'What are you looking for?',
                          hintStyle: AppConstants.searchPlaceholderStyle,
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 16.0, bottom: 10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 230, 230, 230),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSearches(),
            SizedBox(height: 16),
            _buildRecentSearches(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 12, left: 12),
              child: CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterScreen()),
                  );
                },
                text: 'Search',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopSearches() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Searches', style: AppConstants.headerStyle),
          SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: topSearches.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _buildCategoryButton(category),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String title) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Text(
        title,
        style: AppConstants.normalTextStyle.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Recent Searches', style: AppConstants.headerStyle),
        ),
        SizedBox(height: 8),
        ...recentSearches.map((item) => _buildRecentSearchItem(item)).toList(),
      ],
    );
  }

  Widget _buildRecentSearchItem(String title) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppConstants.normalTextStyle.copyWith(
              color: Color(0xFF636363),
            ),
          ),
          Transform.rotate(
            angle: -45 * (3.141592653589793238 / 180),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
