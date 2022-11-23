import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

Future confirm(
  BuildContext context, {
  String? title,
  required dynamic body,
  required Function() onConfirm,
  String? confirmText,
  String? cancelText,
  List<Widget>? moreActions,
}) {
  return showDialog(
    useSafeArea: true,
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: title != null ? Text(title) : null,
      content: body != null
          ? body is Widget
              ? Card(
                  elevation: 0.0,
                  child: body,
                )
              : Text(body)
          : null,
      actions: [
        ...(moreActions ?? []),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            confirmText ?? 'Confirm',
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            cancelText ?? 'Cancel',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}

String date(DateTime date, {String? format}) =>
    DateFormat(format ?? 'dd MMM yyyy').format(date);

Size deviceSize(BuildContext context) => MediaQuery.of(context).size;

pop(BuildContext context, {dynamic result}) =>
    Navigator.of(context).pop(result);

toast(String msg, {TS toastState = TS.regular}) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastState == TS.error
          ? Colors.red
          : toastState == TS.success
              ? Colors.green
              : Colors.black,
      textColor: Colors.white,
    );

waiting(
  BuildContext context, {
  String? body,
}) =>
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: CircularProgressIndicator()),
        content: Text(
          body ?? 'Please wait...',
          textAlign: TextAlign.center,
        ),
      ),
    );

enum TS { error, success, regular }