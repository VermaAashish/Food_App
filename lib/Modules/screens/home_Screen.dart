import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/common/common_widgets.dart';
import 'package:yamzi/main.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../controllers/home_controller.dart';


class HomeScreen extends ParentWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());


  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: commonAppBar(appStrings.yamzi),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonSearchBar(
                w,
                45,
                appStrings.searchYourFavoriteThali,
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                fillColor: Colors.grey.shade100,
                borderRadius: 10,
              ),

              20.kH,
              categoryTiles( homeController),

              20.kH,
              foodGrid( homeController, w),


            ],
          ),
        ),
      ),
    );
  }
}

Widget  categoryTiles(HomeController homeController){
  return  Obx(
          () {  final selectedIndex = homeController.selectedCategoryIndex.value;
      return SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeController.categories.length,
          itemBuilder: (context, index) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () => homeController.selectedCategoryIndex.value = index,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? appColors.greenPrimaryColor : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    homeController.categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey.shade700,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );}

  );
}

Widget foodGrid(HomeController homeController,double w){
  return  Obx(() {
    final selectedCategory = homeController
        .categories[homeController.selectedCategoryIndex.value];
    final items = homeController.thaliItems[selectedCategory] ?? [];

    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics:  NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset:  Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(width: w,
                    child: ClipRRect(borderRadius: BorderRadius.circular(20 ),
                        child: Image.asset(item['image'], fit: BoxFit.cover)),
                  ),
                ),
                8.kH,
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50,
                      child: Text(item['name'],maxLines: 2,
                          style:  TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14,)),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("₹${item['price']}",
                            style: TextStyle(
                                color: appColors.greenPrimaryColor,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [Icon(Icons.star,color: Colors.orangeAccent,size: 18,),
                            Text("${item['rating']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    10.kH,
                    foodButton(w, 'Order', () { homeController.orderController.addOrder(item);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${appStrings.addedToOrders} '
                          '${item['name']} ${appStrings.addedSuccessfully}')),
                    );}),

                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  });
}

Widget  foodButton  (
   double width,
   String title,
   VoidCallback onTap,) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: appColors.yelloPrimaryColor,
        ),
        child: Center(
          child: Text(
            title,
            style:  TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );

}