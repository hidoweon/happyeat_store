import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyeat_store/controller/restaurant_controller.dart';
import 'package:happyeat_store/model/restaurant.dart';

class EditMenuDialog extends StatefulWidget {
  final MenuItem menuItem;
  final String restaurantName;

  EditMenuDialog({required this.menuItem, required this.restaurantName});

  @override
  _EditMenuDialogState createState() => _EditMenuDialogState();
}
class _EditMenuDialogState extends State<EditMenuDialog> {
  late String restaurantName;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _priceController;
  late bool _isMain;

  @override
  void initState() {
    super.initState();
    restaurantName = widget.restaurantName;
    _nameController = TextEditingController(text: widget.menuItem.name);
    _descriptionController =
        TextEditingController(text: widget.menuItem.menudes);
    _imageUrlController = TextEditingController(text: widget.menuItem.imageUrl);
    _priceController = TextEditingController(text: widget.menuItem.price.toString());
    _isMain=widget.menuItem.isMain;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit menu item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a price';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            SwitchListTile(
              title: Text('Main'),
              value: _isMain,
              onChanged: (value) {
                setState(() {
                  _isMain = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final updatedMenuItem = MenuItem(
                name: _nameController.text,
                menudes: _descriptionController.text,
                imageUrl: _imageUrlController.text,
                price: int.parse(_priceController.text),
                isMain: _isMain
              );
              await Get.find<RestaurantController>().updateMenu(
                 restaurantName , updatedMenuItem);

              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
