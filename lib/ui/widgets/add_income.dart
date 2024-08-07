import 'package:flutter/material.dart';
import 'package:wallet/ui/widgets/text_16_black.dart';

import '../../utils/helpers.dart';

class AddIncome extends StatelessWidget {
  const AddIncome({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Helpers.myShowModalBottomSheet(
        context,
        TextInputType.number,
        'Miqdor',(){},
      ),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.payment_outlined),
        ),
        title: Text16Black(text: 'Kirim'),
      ),
    );
  }
}
