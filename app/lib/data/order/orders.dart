import 'package:app/models/order.dart';

List<Order> sampleOrders = [
  Order(
    orderNumber: 'A255DSD5FG',
    price: 25000,
    orderDate: 'Aug 23, 2022',
    itemName: 'Elegant Blazer',
    isDelivered: true,
    paymentcardnumber: '1234567645',
    shippinglocation: '55 street name , Ryadah , KSA',
    orderedItems: [
      OrderedItem(
        name: 'Elegant Blazer',
        price: 20000,
        imageUrl: 'assets/order_details1.png',
        brand: 'Defacto',
        quantity: 1,
      ),
      OrderedItem(
        name: 'Dress Shirt',
        price: 3000,
        imageUrl: 'assets/order_details1.png',
        brand: 'LC',
        quantity: 2,
      ),
      OrderedItem(
        name: 'Silk Tie',
        price: 2000,
        imageUrl: 'assets/order_details2.png',
        brand: 'Zara',
        quantity: 1,
      ),
    ],
  ),
  Order(
    orderNumber: 'B789GHJ3KL',
    price: 15000,
    shippinglocation: '55 street name , Cairo , Egypt',
    orderDate: 'Sep 5, 2022',
    itemName: 'Designer Watch',
    isDelivered: false,
    paymentcardnumber: '12348567645',
    orderedItems: [
      OrderedItem(
        name: 'Designer Watch',
        price: 12000,
        imageUrl: 'assets/order_details2.png',
        brand: 'Defacto',
        quantity: 1,
      ),
      OrderedItem(
        name: 'Leather Strap',
        price: 3000,
        imageUrl: 'assets/order_details1.png',
        brand: 'LC',
        quantity: 1,
      ),
    ],
  ),
  Order(
    orderNumber: 'C321QWE9OP',
    price: 8000,
    paymentcardnumber: '1234958445',
    orderDate: 'Oct 10, 2022',
    shippinglocation: '55 street name , Cairo , Egypt',
    itemName: 'Smartphone',
    isDelivered: true,
    orderedItems: [
      OrderedItem(
        name: 'Smartphone',
        price: 6000,
        imageUrl: 'assets/order_details1.png',
        brand: 'Defacto',
        quantity: 1,
      ),
      OrderedItem(
        name: 'Phone Case',
        price: 1000,
        imageUrl: 'assets/order_details2.png',
        brand: 'Defacto',
        quantity: 2,
      ),
      OrderedItem(
        name: 'Screen Protector',
        price: 1000,
        imageUrl: 'assets/order_details1.png',
        brand: 'MAX',
        quantity: 3,
      ),
    ],
  ),
];
