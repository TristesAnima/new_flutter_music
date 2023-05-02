import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../controllers/bottom_nav_controller.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: controller.pages[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (i) {
            controller.selectedIndex.value = i;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_music_outlined,
                ),
                label: 'Music'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.video_library_outlined,
                ),
                label: 'MV'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.mic_outlined,
                ),
                label: 'About'
            )
          ],
        ),
      );
    });
  }
}

// class BottomNavView extends GetView<BottomNavController> {
//   const BottomNavView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         body: controller.pages[controller.selectedIndex.value],
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 20,
//                 color: Colors.black.withOpacity(0.03),
//               )
//             ],
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//               child: GNav(
//                 rippleColor: Colors.grey[300]!,
//                 hoverColor: Colors.grey[100]!,
//                 gap: 8,
//                 activeColor: Colors.blueAccent,
//                 iconSize: 24,
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 duration: const Duration(milliseconds: 400),
//                 tabBackgroundColor: Colors.grey[100]!,
//                 color: Colors.black,
//                 selectedIndex: 0,
//                 onTabChange: (i) {
//                   controller.selectedIndex.value = i;
//                 },
//                 tabs: const [
//                   GButton(
//                     icon: Icons.library_music,
//                     text: 'Home',
//                   ),
//                   GButton(
//                     icon: Icons.menu,
//                     text: 'Likes',
//                   ),
//                   GButton(
//                     icon: Icons.search,
//                     text: 'Search',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
