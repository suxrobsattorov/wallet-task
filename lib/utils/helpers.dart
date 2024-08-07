import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../ui/widgets/text_16_white.dart';

class Helpers {
  static TextEditingController myShowModalBottomSheet(BuildContext context,
      TextInputType type, String title, Function function) {
    TextEditingController controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: title,
                ),
                controller: controller,
                keyboardType: type,
              ),
              ElevatedButton(
                onPressed: () {
                  function;
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor2,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                child: Text16White(text: 'SAQLASH'),
              ),
            ],
          ),
        );
      },
    );
    return controller;
  }
}
