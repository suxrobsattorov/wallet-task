import 'package:flutter/material.dart';

import '../../data/model/category_list.dart';
import '../../utils/helpers.dart';
import 'text_16_black.dart';

// ignore: must_be_immutable
class CategoryListView extends StatelessWidget {
  List<Categories> categories;

  CategoryListView({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Helpers.myShowModalBottomSheet(
            context,
            TextInputType.number,
            'Miqdor',(){},
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.category),
                  ),
                  title: Text16Black(
                    text: categories[index].name ?? '',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 0.7,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
