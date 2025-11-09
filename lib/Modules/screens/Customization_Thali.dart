import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/common/common_widgets.dart';
import 'package:yamzi/main.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../controllers/customizationController.dart';

class CustomizationScreen extends ParentWidget {
  final controller = Get.put(CustomizationController());

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: commonAppBar(appStrings.customizeThali),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appStrings.selectThaliType,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Obx(
                        () => Row(
                      children: [
                        Expanded(
                          child: thaliTypeButton(
                            appStrings.vegetarian,
                            controller.selectedThaliType.value == 'Vegetarian',
                                () {
                              controller.selectedThaliType.value = 'Vegetarian';
                              controller.selectedItems.clear();
                              controller.calculateTotal();
                            },
                          ),
                        ),
                        10.kW,
                        Expanded(
                          child: thaliTypeButton(
                            appStrings.nonVegetarian,
                            controller.selectedThaliType.value == 'Non-Vegetarian',
                                () {
                              controller.selectedThaliType.value = 'Non-Vegetarian';
                              controller.selectedItems.clear();
                              controller.calculateTotal();
                            },
                          ),
                        ),
                        10.kW,
                        Expanded(
                          child: thaliTypeButton(
                            appStrings.mix,
                            controller.selectedThaliType.value == 'Mix',
                                () {
                              controller.selectedThaliType.value = 'Mix';
                              controller.selectedItems.clear();
                              controller.calculateTotal();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appStrings.selectItems,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  12.kH,
                  Obx(() {
                    final items = controller.getAvailableItems();
                    final groupedItems = groupItemsByType(items);
                    return Column(
                      children: groupedItems.entries.map((entry) {
                        final type = entry.key;
                        final typeItems = entry.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              type.toUpperCase(),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 2,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: typeItems.length,
                              itemBuilder: (context, index) {
                                final item = typeItems[index];
                                return menuItemCard(item, context, w, h);
                              },
                            ),
                            10.kH
                          ],
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appStrings.selectedItems,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  12.kH,
                  Obx(() =>
                     (controller.selectedItems.isEmpty) ?Center(
                        child: Text(
                          appStrings.noItemsSelected,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ): Column(
                      children:
                      controller.getSelectedItemsDetails().map((detail) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail['name'],
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '₹${detail['price']} x ${detail['quantity']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '₹${detail['total']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appStrings.totalPrice,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() => Text(
                        '₹${controller.totalPrice.value.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      )),
                    ],
                  ),
                  16.kH,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => (controller.selectedItems.isEmpty) ?{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(appStrings.pleaseSelectAtLeastOneItem)),
                          )
                          } : {
                          controller.orderController.addCustomizedOrder(
                            thaliType: controller.selectedThaliType.value,
                            items: controller.getSelectedItemsDetails(),
                            totalPrice: controller.totalPrice.value,
                          ),

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(appStrings.thaliAddedToYourOrders)),
                          ),

                          controller.resetCustomization()
                        }
                      ,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        appStrings.addToCart,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  70.kH
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget thaliTypeButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget menuItemCard(dynamic item, BuildContext context, double w, double h) {
    return Obx(() {
      final quantity = controller.selectedItems[item['id']] ?? 0;

      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: quantity > 0 ? Colors.orange : Colors.grey.shade300,
            width: quantity > 0 ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: quantity > 0 ? Colors.orange.withOpacity(0.05) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: w,
                    color: Colors.grey[200],
                    child: Image.asset(
                      item['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Text(
                    '₹${item['price']}',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  ),
                  6.kH,
                  (quantity == 0)?
                    GestureDetector(
                      onTap: () => controller.addItem(item['id']),
                      child: Container(
                        width: w,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Add',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ):
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => controller.removeItem(item['id']),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () => controller.addItem(item['id']),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Map<String, List<dynamic>> groupItemsByType(List<dynamic> items) {
    final grouped = <String, List<dynamic>>{};

    for (var item in items) {
      final type = item['type']?.toString() ?? 'Unknown';
      var list = grouped[type] ?? <dynamic>[];
      list.add(item);
      grouped[type] = list;
    }

    return grouped;
  }


}
