import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ri.dart';
import 'package:todo_list/presentation/presentation.dart';
import 'package:todo_list/presentation/screens/home/todo_widget.dart';

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
                  icon: const Iconify(
                    Ri.logout_circle_r_line,
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
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: AppColors.textFieldBorderColor.withOpacity(0.5),
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
                      text: 'TO DO',
                    ),
                    Tab(
                      text: 'COMPLETED',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [TodoWidget(), TodoWidget()],
        ),
      ),
    );
  }
}
