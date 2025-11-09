import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../../../common/common_back.dart';
import '../controllers/commondashcontroller.dart';
import '../../main.dart';
import '../../resources/font.dart';

class CommonScreen extends ParentWidget {
  const CommonScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    CommonDashController controller = Get.put(CommonDashController());
    return onBack(
      controller.pages[controller.selectedIndex.value],
      canPop: controller.selectedIndex.value == 0,
          (didPop, result) async {
        if (didPop == false) {
          controller.selectedIndex.value = 0;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CommonDashController controller = Get.put(CommonDashController());

    return Obx(
          () => Scaffold(
        extendBody: true,
        body: super.build(context),
        bottomNavigationBar:ClipRRect(
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomAppBar(

          color: Colors.white,
          elevation: 8,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                navIcon(Icons.home, 'Home', 0, controller),
                Container(decoration: BoxDecoration(color: Colors.grey.shade50,borderRadius: BorderRadius.circular(50)),
                  child: GestureDetector( onTap: () {
                    controller.selectedIndex.value = 1;
                  },child: Image.asset("assets/images/dish.png")),
                ),
                navIcon(Icons.local_grocery_store_outlined, 'Cart', 2, controller),
                navIcon(Icons.feed_outlined, 'Transaction', 3, controller),
                navIcon(Icons.person_outline, 'Profile', 4, controller),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget navIcon(IconData icon, String label, int index, CommonDashController controller) {
    bool isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.selectedIndex.value = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: isSelected ? 30 : 26, color: isSelected ? Color(
              0xFF60F437) : Colors.grey),
          4.kH,
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: isSelected ? appFonts.NunitoBold : appFonts.NunitoRegular,
              color: isSelected ? appColors.greenPrimaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
