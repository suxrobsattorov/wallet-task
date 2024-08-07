import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../widgets/text_16_black.dart';
import '../widgets/text_16_white.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text(
          'Ro\'yhat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 82,
            padding: const EdgeInsets.all(16),
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text16White(text: 'Kirim'),
                    Text16White(text: '50000'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text16White(text: 'Chiqim'),
                    Text16White(text: '80000'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text16White(text: 'Natija'),
                    Text16White(text: '-30000'),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text16Black(text: 'Kirim'),
                  leading: const CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                  trailing: Text16Black(
                    text: '50000',
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: Text16Black(text: 'Ovqatlanish'),
                  leading: const CircleAvatar(
                    child: Icon(Icons.remove),
                  ),
                  trailing: Text16Black(
                    text: '-80000',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
