import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';

class CustomizedDropDownButton extends StatefulWidget {
  CustomizedDropDownButton(
      {Key? key, required this.dropdownvalue, required this.items})
      : super(key: key);

  String dropdownvalue;
  final List<String> items;

  @override
  State<CustomizedDropDownButton> createState() =>
      _CustomizedDropDownButtonState();
}

class _CustomizedDropDownButtonState extends State<CustomizedDropDownButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.only(left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.textFieldColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.greyColor)),
      child: DropdownButton(
          style: const TextStyle(
            fontFamily: 'Euclid',
            fontSize: 14,
            color: AppColors.blackColor
          ),
          value: widget.dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down,),
          items: widget.items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.dropdownvalue = newValue!;
            });
          }),
    );
  }
}
