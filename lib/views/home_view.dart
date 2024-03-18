import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas1_chapter5/controllers/home_controller.dart';
import 'package:tugas1_chapter5/models/restaurant_model.dart';
import 'package:tugas1_chapter5/views/meal_view.dart';

class HomeView extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  HomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppBar(),
            Expanded(
              child: Body(controller: _controller),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatefulWidget {
  const AppBar({Key? key});

  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 100.h,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.w),
                ),
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 10.h),
            Text(
              "List Meal From API",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final HomeController controller;

  const Body({Key? key, required this.controller});

  void _navigateToMealsByCategory(BuildContext context, String category) {
    Get.to(() => MealsCategoryView(category: category));
  }

  String _truncateString(String text) {
    const maxLength = 60;
    return text.length <= maxLength
        ? text
        : '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantModel>(
      future: controller.getRestaurants(),
      builder: (context, snapshot) {
        return Container(
          color: Colors.white,
          child: GridView.builder(
            padding: EdgeInsets.all(10.w),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: snapshot.data!.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _navigateToMealsByCategory(
                    context,
                    snapshot.data!.categories[index].strCategory,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: Colors.grey.shade200,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.w,
                        blurRadius: 3.w,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          width: 150.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            image: DecorationImage(
                              image: NetworkImage(
                                snapshot
                                    .data!.categories[index].strCategoryThumb,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        snapshot.data!.categories[index].strCategory,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10.w,
                          left: 10.w,
                          bottom: 10.h,
                        ),
                        child: Text(
                          _truncateString(snapshot
                              .data!.categories[index].strCategoryDescription),
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
