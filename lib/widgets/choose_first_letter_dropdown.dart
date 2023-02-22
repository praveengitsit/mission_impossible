import 'package:flutter/material.dart';

class FirstLetterDropdown extends StatelessWidget {
  final Function(String) onChanged;
  final String? initialValue;
  final List<String> someLetters = ['a', 'c', 'd', 'k', 'm'];

  FirstLetterDropdown({
    Key? key,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        items: _getDropdownItems(),
        hint: const Text('Pick the first letter for your names'),
        onChanged: (value) {
          onChanged(value!);
        },
        value: _getInitialValue(),
      ),
    );
  }

  String? _getInitialValue() {
    if (someLetters.contains(initialValue)) {
      return initialValue;
    } else {
      return null;
    }
  }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (final letter in someLetters) {
      var dropdownMenuItem = DropdownMenuItem(
        value: letter,
        child: Align(
          alignment: Alignment.centerRight,
          child: RichText(
            overflow: TextOverflow.visible,
            text: TextSpan(
              text: letter.toUpperCase(),
              style: const TextStyle(
                color: Colors.black45,
              ),
            ),
          ),
        ),
      );
      menuItems.add(dropdownMenuItem);
    }
    return menuItems;
  }
}
