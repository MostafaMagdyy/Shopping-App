class OrderedItem {
  final String name;
  final double price;
  final String imageUrl;
  final String brand;
  final int quantity;

  OrderedItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.brand,
    required this.quantity,
  });
}

class Order {
  final String orderNumber;
  final double price;
  final String orderDate;
  final String itemName;
  final bool isDelivered;
  final List<OrderedItem> orderedItems;
  final String paymentcardnumber;
  final String shippinglocation;
  Order(
      {required this.orderNumber,
      required this.price,
      required this.orderDate,
      required this.itemName,
      required this.isDelivered,
      required this.orderedItems,
      required this.paymentcardnumber,
      required this.shippinglocation});
}
