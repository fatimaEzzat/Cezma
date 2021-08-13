import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'dart:math' as math;

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

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
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenWidth(context) * 0.4,
                      // height: screenHeight(context) * 0.07,
                      child: FormBuilderDropdown(
                        hint: Text("الاقسام الرئيسية"),
                        icon: Transform.rotate(
                            angle: math.pi / 2,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.purple.shade700,
                            )),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: screenHeight(context) * 0.025,
                                right: screenWidth(context) * 0.03,
                                left: screenWidth(context) * 0.03),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                )),
                            // ////////
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                )),
                            // ////////
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ))),
                        name: '',
                        items: [
                          DropdownMenuItem(
                            child: Text("data"),
                            value: "id",
                          ),
                          DropdownMenuItem(
                            child: Text("ss"),
                            value: "sdsd",
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth(context) * 0.4,
                      child: FormBuilderDropdown(
                        hint: Text("الاقسام الفرعية"),
                        icon: Transform.rotate(
                          angle: math.pi / 2,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.purple.shade700,
                          ),
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: screenHeight(context) * 0.025,
                                right: screenWidth(context) * 0.03,
                                left: screenWidth(context) * 0.03),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                )),
                            // ////////
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                )),
                            // ////////
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ))),
                        name: '',
                        items: [],
                      ),
                    ),
                  ],
                ),
                searchBar(context: context)
              ],
            ),
          )),
    );
  }
}
