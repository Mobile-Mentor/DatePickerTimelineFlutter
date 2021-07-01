import 'package:flutter/material.dart';

class OlderDateWidget extends StatelessWidget {
  final double? width;
  final TextStyle textStyle;
  final Color selectionColor;
  final Function(DateTime) onSelected;
  final String title;
  final DateTime datePickerInitialDate;
  final DateTime datePickerFirstDate;
  final DateTime datePickerLastDate;
  final Color? datePickerAccent;

  OlderDateWidget({
    required this.textStyle,
    required this.selectionColor,
    required this.onSelected,
    required this.title,
    required this.datePickerInitialDate,
    required this.datePickerFirstDate,
    required this.datePickerLastDate,
    this.width,
    this.datePickerAccent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: Colors.white),
          color: selectionColor,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(title, style: textStyle, textAlign: TextAlign.center),
          ),
        ),
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: datePickerAccent ?? Theme.of(context).primaryColor,
                  accentColor: datePickerAccent ?? Theme.of(context).accentColor,
                  colorScheme: ColorScheme.light(primary: datePickerAccent ?? Theme.of(context).accentColor),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: datePickerInitialDate,
            firstDate: datePickerFirstDate,
            lastDate: datePickerLastDate);

        if (selectedDate != null) {
          onSelected(selectedDate);
        }
      },
    );
  }
}
