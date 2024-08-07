import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/data/model/category_list.dart';
import 'package:wallet/providers/category_provider.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({Key? key}) : super(key: key);

  static const routeName = '/edit_category';

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final _form = GlobalKey<FormState>();
  var _category = Categories(id: null, name: '');
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {
      final categoryId = ModalRoute.of(context)!.settings.arguments;
      if (categoryId != null) {
        final editingCategory =
            Provider.of<CategoryProvider>(context, listen: false).findById(categoryId as int);
        _category = editingCategory;
      }
    }
    _init = false;
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      if (_category.id == null) {
        try {
          await Provider.of<CategoryProvider>(context, listen: false)
              .create(_category.name!);
        } catch (error) {
          await showDialog<Null>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Xatolik!'),
                content:
                    const Text('Mahsulot qo\'shishda xatolik sodir bo\'ldi.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Okay'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        try {
          await Provider.of<CategoryProvider>(context, listen: false)
              .update(_category.id!, _category.name!);
        } catch (e) {
          await showDialog<Null>(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text('Xatolik!'),
                  content:
                      const Text('Mahsulot qo\'shishda xatolik sodir bo\'ldi.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Okay'),
                    ),
                  ],
                );
              });
        }
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categoriya Qo\'shish'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _category.name ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Nomi',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, categoriya nomini kiriting.';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _category = Categories(name: newValue!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
