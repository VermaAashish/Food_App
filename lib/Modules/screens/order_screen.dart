import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/common/common_widgets.dart';
import 'package:yamzi/main.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../controllers/orderController.dart';

class OrderScreen extends ParentWidget {
  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: commonAppBar( appStrings.myOrders ),
      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return  Center(
            child: Text(
              appStrings.noOrdersYet,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        orderController.calculateTotal();

        return Padding(
          padding: const EdgeInsets.only(bottom: 90, top: 10,left: 12,right: 12),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(padding: EdgeInsets.only(bottom: 40),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderController.orders.length,
                  itemBuilder: (context, index) {
                    final order = orderController.orders[index];
                    final isCustomized = order['source'] == 'CustomizationScreen';
                    final quantity = order['quantity'] ?? 1;

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset:  Offset(0, 2),
                          ),
                        ],
                      ),
                      margin:
                       EdgeInsets.symmetric( vertical: 8),
                      padding:  EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  isCustomized
                                      ? '${appStrings.customizedThali} (${order['thaliType']})'
                                      : order['name'],
                                  style:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  qtyButton(
                                     Icons.remove,
                                     () => orderController
                                        .decreaseQuantity(index),
                                  ),
                                  6.kW,
                                  Text(
                                    '$quantity',
                                    style:  TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  6.kW,
                                  qtyButton(
                                     Icons.add,
                                    () =>
                                        orderController.increaseQuantity(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          6.kH,

                      (isCustomized)?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: (order['items'] as List).length,
                                  itemBuilder: (context, i) {
                                    final item =
                                    (order['items'] as List)[i];
                                    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${item['name']} x ${item['quantity']} ',
                                          style: const TextStyle(fontSize: 13),
                                        ),Text(
                                          ' ₹${item['total']}',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                8.kH,
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${appStrings.totalRs}${(order['totalPrice'] * quantity).toStringAsFixed(2)}',
                                      style:  TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          orderController.removeItem(index),
                                      child: Text(
                                        appStrings.remove,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ):
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${appStrings.totalRs}${(order['price'] * quantity).toStringAsFixed(2)}',
                                  style:  TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      orderController.removeItem(index),
                                  child: Text(
                                    appStrings.remove,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
                8.kH,
                Text(
                  appStrings.youMayAlsoLike,
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                8.kH,

                SizedBox(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      suggestionCard("Wheat roti", "₹79", "assets/images/roti1.jpg"),
                      suggestionCard("Paneer Butter Masala", "₹199", "assets/images/sabji (2).jpg"),
                      suggestionCard("Yogurt", "₹99", "assets/images/yogurt.jpg"),
                      suggestionCard("Veg Biryani", "₹149", "assets/images/nonVeg (11).jpg"),
                    ],
                  ),
                ),
                20.kH,
                orderSummary(orderController)
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget qtyButton( IconData icon,  VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange.shade300, width: 1),
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding:  EdgeInsets.all(4),
        child: Icon(icon, color: Colors.orange, size: 14),
      ),
    );
  }
}

Widget suggestionCard(String name, String price, String imagePath) {
  return Container(padding: EdgeInsets.symmetric(vertical: 6),
    width: 120,
    margin:  EdgeInsets.only(right: 12,bottom: 2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 4,
          offset:  Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            height: 70,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
         6.kH,
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          price,
          style: const TextStyle(color: Colors.orange, fontSize: 13),
        ),
      ],
    ),
  );
}

Widget orderSummary(OrderController orderController){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        appStrings.orderSummary,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18),
      ),
      8.kH,
      ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orderController.orders.length,
        itemBuilder: (context, index) {
          final order = orderController.orders[index];
          final isCustomized =
              order['source'] == 'CustomizationScreen';
          final quantity = order['quantity'] ?? 1;
          final total = isCustomized
              ? order['totalPrice'] * quantity
              : order['price'] * quantity;

          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isCustomized
                        ? '${appStrings.customizedThali} (${order['thaliType']}) x$quantity'
                        : '${order['name']} x$quantity',
                    style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '₹${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      8.kH,

      Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appStrings.total,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "₹${orderController.totalPrice.value.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      10.kH,

      GestureDetector(
        onTap: () {

        },
        child: Container(
          padding:
          const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.4),
                blurRadius: 6,
                offset:  Offset(0, 3),
              ),
            ],
          ),
          child:  Center(
            child: Text(
              appStrings.continueToPayment,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}