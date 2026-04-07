import 'package:binder_os_app/core/theme/app_theme.dart';
import 'package:binder_os_app/features/dashboard/home_screen.dart';
import 'package:flutter/material.dart';
import '../code/code_screen.dart';
import '../ipo/ipo_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String name;
  const DashboardScreen({super.key, required this.name});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      HomeScreen(name: widget.name),
      const Center(child: Text("Tasks")),
      const CodeScreen(),
      const IpoScreen(),
      const Center(child: Text("Purchase")),
      const Center(child: Text("IMS")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          onTap: (i) => setState(() => index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
            BottomNavigationBarItem(icon: Icon(Icons.code), label: "Code"),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up), label: "IPO"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Purchase"),
            BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "IMS"),
          ],
        ),
      ),
    );
  }
}
