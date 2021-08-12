import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';

class SectionsScreen extends StatelessWidget {
  const SectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: searchBar(context: context),
          ),
          body: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    FormBuilderDropdown(
                      name: '',
                      items: [],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
