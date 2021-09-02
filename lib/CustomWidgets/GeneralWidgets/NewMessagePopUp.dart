import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Logic/ApiRequests/MessagingRequests/SendMessage.dart';
import 'package:test_store/Variables/CustomColors.dart';

newMessagePopUp(BuildContext context, storeId) async {
  String message = "";
  Get.defaultDialog(
      title: "اكتب رسالتك",
      content: Column(
        children: [
          FormBuilderTextField(
            validator: FormBuilderValidators.required(context),
            cursorColor: violet,
            name: "nessage",
            maxLines: 4,
            onChanged: (value) {
              message = value!;
            },
            decoration: customformfielddecoration(
                context: context, color: Colors.grey.shade200),
          ),
          customGeneralButton(
              customOnPressed: () async {
                await requestNewMessage(context, storeId, message);
                Get.back();
                Get.defaultDialog(
                    title: "تم", middleText: "تم ارسال الرسالة للمتجر");
              },
              context: context,
              title: "ارسل",
              primarycolor: violet,
              titlecolor: Colors.white,
              newIcon: Icon(Icons.send),
              borderColor: Colors.transparent)
        ],
      ));
}
