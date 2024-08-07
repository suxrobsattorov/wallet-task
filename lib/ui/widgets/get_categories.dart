import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/ui/widgets/category_item.dart';

import '../../providers/category_provider.dart';
import 'categor_list_view.dart';

class GetCategories extends StatefulWidget {
  const GetCategories({super.key});

  @override
  State<GetCategories> createState() => _GetCategoriesState();
}

class _GetCategoriesState extends State<GetCategories> {
  // late Future _categories;

  Future<void> _refreshCategories(BuildContext context) async {
    await Provider.of<CategoryProvider>(context, listen: false).get();
  }

  @override
  void didChangeDependencies() {
    // _categories = _refreshCategories(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // _categories = _refreshCategories(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
