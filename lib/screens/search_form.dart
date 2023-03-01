import 'package:flutter/material.dart';
import 'package:weather_test_app/helpers/colors.dart';

class SearchForm extends StatefulWidget {
  final Function(String) onSearch;

  const SearchForm({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 50),
      padding: const EdgeInsets.only(left: 20, top: 5, right: 5, bottom: 00),
      height: 50,
      width: 400,
      decoration: BoxDecoration(
        color: CustomColors.formColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _cityController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Weather search', 
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter', 
                  fontWeight: FontWeight.w600, 
                  fontStyle: FontStyle.normal, 
                  fontSize: 16,
                  ),
                  ),
              onSubmitted: (String city) => widget.onSearch(city),
            ),
          ),
        ],
      ),
    );
  }
}
