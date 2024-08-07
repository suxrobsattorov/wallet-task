import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/ui/widgets/add_income.dart';
import 'package:wallet/ui/widgets/get_categories.dart';

import '../../constants/app_colors.dart';
import '../../providers/category_provider.dart';
import '../widgets/category_item.dart';

class AddIncomeAndExpensesScreen extends StatefulWidget {
  const AddIncomeAndExpensesScreen({super.key});

  @override
  State<AddIncomeAndExpensesScreen> createState() =>
      _AddIncomeAndExpensesScreenState();
}

class _AddIncomeAndExpensesScreenState
    extends State<AddIncomeAndExpensesScreen> {

  Future<void> _refreshCategories(BuildContext context) async {
    await Provider.of<CategoryProvider>(context, listen: false).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text(
          'Qo\'shish',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _refreshCategories(context),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (dataSnapshot.connectionState == ConnectionState.done) {
                  return RefreshIndicator(
                    onRefresh: () => _refreshCategories(context),
                    child: Consumer<CategoryProvider>(
                      builder: (c, categoryProvider, _) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          itemCount: categoryProvider.list.length,
                          itemBuilder: (ctx, i) {
                            final category = categoryProvider.list[i];
                            return CategoryItem(categories: category);
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Xatolik sodir bo\'ldi.'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
