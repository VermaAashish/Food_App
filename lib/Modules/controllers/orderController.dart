import 'package:get/get.dart';

class OrderController extends GetxController {
  var orders = <Map<String, dynamic>>[].obs;
  var totalPrice = 0.0.obs;




  void calculateTotal() {
    double total = 0.0;

    for (var order in orders) {
      final quantity = order['quantity'] ?? 1;

      if (order['source'] == 'CustomizationScreen') {
        total += (order['totalPrice'] ?? 0) * quantity;
      } else {
        total += (order['price'] ?? 0) * quantity;
      }
    }

    totalPrice.value = total;
  }


  void addOrder(Map<String, dynamic> item) {
    final newOrder = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'source': 'HomeScreen',
      'name': item['name'],
      'image': item['image'],
      'price': item['price'],
      'rating': item['rating'],
      'quantity': 1,
      'time': DateTime.now().toString(),
    };
    orders.add(newOrder);

  }

  void addCustomizedOrder({
    required String thaliType,
    required List<Map<String, dynamic>> items,
    required double totalPrice,
  }) {
    final newOrder = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'source': 'CustomizationScreen',
      'thaliType': thaliType,
      'items': items,
      'totalPrice': totalPrice,
      'quantity': 1,
      'time': DateTime.now().toString(),
    };
    orders.add(newOrder);
  }
  void removeItem(int index){
    orders.removeAt(index);
  }

  void increaseQuantity(int index) {
    orders[index]['quantity'] = (orders[index]['quantity'] ?? 1) + 1;
    orders.refresh();
    calculateTotal();

  }

  void decreaseQuantity(int index) {
    if (orders[index]['quantity'] > 1) {
      orders[index]['quantity'] = orders[index]['quantity'] - 1;
    } else {
      orders.removeAt(index); // remove if quantity is 0
    }
    orders.refresh();
    calculateTotal();
  }


  void clearOrders() {
    orders.clear();
  }
}
