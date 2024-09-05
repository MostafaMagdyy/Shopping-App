import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final String imagePath;
  final double price;
  final String text;
  final String discount;
  final bool bestSellers;
  final bool isFavorite;

  ItemCard({
    required this.imagePath,
    required this.price,
    required this.text,
    required this.discount,
    this.bestSellers = false,
    this.isFavorite = false,
  });

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late bool isFavorited;

  @override
  void initState() {
    super.initState();
    isFavorited = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 18.75 / 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${widget.price} SAR',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 18.75 / 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.bestSellers)
            Positioned(
              top: 17,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF42C2C),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  '${widget.discount}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Positioned(
            top: 12,
            left: 138,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorited ? Colors.black : Colors.grey,
                  size: 32,
                ),
                onPressed: () {
                  setState(() {
                    isFavorited = !isFavorited;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 150,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.black,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
