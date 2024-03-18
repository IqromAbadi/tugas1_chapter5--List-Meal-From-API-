import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas1_chapter5/controllers/home_controller.dart';
import 'package:tugas1_chapter5/models/meal_model.dart';

class MealsCategoryView extends StatelessWidget {
  final String category;
  final HomeController _controller = Get.find<HomeController>();

  MealsCategoryView({required this.category});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(category: category),
            Expanded(
              child: Body(category: category, controller: _controller),
            )
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatefulWidget {
  final String category;

  const AppBar({Key? key, required this.category});

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 60.h,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
          Text(
            "${widget.category} Recipe",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  final String category;
  final HomeController controller;

  const Body({Key? key, required this.category, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
      future: controller.getMealsByCategory(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          width: 1.sw,
                          height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            image: DecorationImage(
                              image: NetworkImage(
                                snapshot.data![index].strMealThumb,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 1.sw,
                          height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(1),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.h,
                          left: 16.w,
                          child: Text(
                            snapshot.data![index].strMeal,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text('Data Tidak Ada'),
          );
        }
      },
    );
  }
}
