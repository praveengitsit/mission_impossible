import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/name_list_bloc.dart';
import '../models/name_model.dart';

class NameListDropdown extends StatelessWidget {
  final String phase;
  final Function(NameModel) onChanged;
  final NameModel? initialValue;

  const NameListDropdown({
    Key? key,
    required this.phase,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NameListBloc, NameListState>(
      builder: (context, state) {
        if (state is NameListInitial) {
          return const CircularProgressIndicator();
        } else if (state is NameListLoading) {
          return const CircularProgressIndicator();
        } else if (state is NameListLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              items: _getDropdownItemsFromList(nameList: state.nameList),
              hint: Text('Select name for $phase *'),
              onChanged: (value) {
                onChanged(value!);
              },
              validator: (value) {
                if (value == null) {
                  return "Please select a name";
                } else {
                  return null;
                }
              },
              value: _getInitialValue(
                nameList: state.nameList,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  NameModel? _getInitialValue({
    required List<NameModel> nameList,
  }) {
    if (nameList.contains(initialValue)) {
      return initialValue;
    } else {
      return null;
    }
  }

  List<DropdownMenuItem<NameModel>> _getDropdownItemsFromList({
    required List<NameModel> nameList,
  }) {
    List<DropdownMenuItem<NameModel>> menuItems = [];
    for (NameModel nameModel in nameList) {
      var dropdownMenuItem = DropdownMenuItem(
        value: nameModel,
        child: Align(
          alignment: Alignment.centerRight,
          child: RichText(
            overflow: TextOverflow.visible,
            text: TextSpan(
              text: '${nameModel.firstName} ${nameModel.lastName}',
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
