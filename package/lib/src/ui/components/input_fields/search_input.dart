import 'package:dhis2_flutter_ui/src/ui/core/app_contants.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    Key? key,
    this.onSearch,
    this.placeHolder = 'Search',
  }) : super(key: key);

  final Function? onSearch;
  final String? placeHolder;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _searchController = TextEditingController();
  bool canClear = false;

  final InputField inputField = InputField(
    id: 'search',
    name: '',
    valueType: 'TEXT',
  );

  void updateClearState(status) {
    setState(() {
      canClear = status;
    });
  }

  void onSearchInputValueChange(String searchedValue) {
    if (searchedValue.isNotEmpty) {
      updateClearState(true);
    } else {
      updateClearState(false);
    }
    widget.onSearch!(searchedValue);
  }

  void onClearSearchInput() {
    _searchController.clear();
    widget.onSearch!('');
    updateClearState(false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        child: TextField(
          autofocus: false,
          controller: _searchController,
          onChanged: onSearchInputValueChange,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppConstants.defaultBorderColor, width: 1.0)),
            hintText: widget.placeHolder,
            prefixIcon: const Icon(
              Icons.search,
              color: AppConstants.defaultColor,
            ),
            suffixIcon: Visibility(
              visible: canClear,
              child: IconButton(
                onPressed: onClearSearchInput,
                icon: const Icon(
                  Icons.clear,
                  color: AppConstants.defaultColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
