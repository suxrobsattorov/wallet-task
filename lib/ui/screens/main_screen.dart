import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import 'add_income_and_expenses_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'statistic_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List _list = [
    const HomeScreen(),
    const AddIncomeAndExpensesScreen(),
    const StatisticScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _list[_currentIndex],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
              child: _currentIndex == 0
                  ? const Text(
                      'Ro\'yhat',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainColor,
                      ),
                    )
                  : const Icon(
                      Icons.menu,
                      size: 25,
                    ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              child: _currentIndex == 1
                  ? const Text(
                      'Qo\'shish',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainColor,
                      ),
                    )
                  : const Icon(
                      Icons.add_circle_outline_outlined,
                      size: 25,
                    ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              child: _currentIndex == 2
                  ? const Text(
                      'Statistika',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainColor,
                      ),
                    )
                  : const Icon(
                      Icons.format_list_bulleted_outlined,
                      size: 25,
                    ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
              child: _currentIndex == 3
                  ? const Text(
                      'Profil',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainColor,
                      ),
                    )
                  : const Icon(
                      Icons.account_circle_outlined,
                      size: 25,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
