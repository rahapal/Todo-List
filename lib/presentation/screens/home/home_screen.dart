import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/presentation/constants/constants.dart';
import 'package:todo_list/presentation/presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "/HomeScreen";
  static GoRoute route() {
    return GoRoute(
      path: routeName,
      builder: (_, state) => const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.containerBgcolor,
          title: const Text("Home"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      context.go(LoginScreen.routeName);
                    });
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 35,
                  )),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 38,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.textFieldBorderColor,
                ),
                child: const TabBar(
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.green),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.green,
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  tabs: [
                    Tab(
                      text: 'AVAILABLE',
                    ),
                    Tab(
                      text: 'MY PICKUPS',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [],
        ),
      ),
    );
  }
}
