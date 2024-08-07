import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/data/model/category_list.dart';
import 'package:wallet/providers/category_provider.dart';
import 'package:wallet/ui/screens/edit_category_screen.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  Categories categories;

  CategoryItem({required this.categories, super.key});

  void _notifyUserAboutDelete(BuildContext context, Function() removeItem) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Ishonchingiz komilmi?'),
          content: const Text('Bu categoriya o\'chmoqda!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'BEKOR QILISH',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                removeItem();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('O\'CHIRISH'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(
            Icons.category,
            size: 25,
          ),
        ),
        title: Text(categories.name!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.of(context).pushNamed(EditCategoryScreen.routeName,
                    arguments: categories.id!);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              splashRadius: 20,
              onPressed: () {
                _notifyUserAboutDelete(context, () async {
                  try {
                    await Provider.of<CategoryProvider>(context, listen: false)
                        .delete(categories.id!);
                  } catch (e) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  }
                });
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
