// ignore_for_file: prefer_const_constructors, must_be_immutable, file_names, prefer_is_empty
import 'package:flutter/material.dart';

class TextFieldValidated extends StatefulWidget {
  String type;
  TextEditingController?
      controller; //Cần truyền controller vào để lấy giá trị ra TextEditingController
  int? minLines = 1;
  int? maxLines = 1;
  int? flexLable;
  int? flexTextField;
  String? hint;
  bool? isPassword;
  String label;
  String? text;
  final double height;
  Function? enter;
  Widget? require;
  int? requiredValue;
  Function? onChanged;
  bool? enabled;
  TextFieldValidated(
      {Key? key,
      required this.type,
      this.controller,
      this.minLines,
      this.maxLines,
      this.hint,
      this.text,
      required this.label,
      this.flexLable,
      this.flexTextField,
      required this.height,
      this.require,
      this.requiredValue,
      this.onChanged,
      this.isPassword,
      this.enabled,
      this.enter})
      : super(key: key);

  @override
  State<TextFieldValidated> createState() => _TextFieldValidatedState();
}

class _TextFieldValidatedState extends State<TextFieldValidated> {
  String? er;

  late double height = widget.height;
  bool isEmail(String string) {
    // Null or empty string is invalid
    if (string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  bool isNumber(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{0,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool _isPhoneNumber(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp =  RegExp(pattern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: widget.flexLable ?? 2,
                child: Row(
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    (widget.requiredValue == 1)
                        ? Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text("*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                )),
                          )
                        : Text(""),
                  ],
                )),
            Expanded(
              flex: widget.flexTextField ?? 5,
              child: TextField(
                enabled: widget.enabled,
                obscureText: widget.isPassword == true ? true : false,
                // minLines: widget.minLines,
                // maxLines: widget.maxLines,
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  errorText: er,
                  contentPadding: const EdgeInsets.fromLTRB(10, 7, 5, 0),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onSubmitted: (value) {
                  widget.enter!();
                },
                onChanged: (value) {
                  widget.onChanged!(value);
                  if (widget.type == 'Text') {
                    if (value.isEmpty) {
                      setState(() {
                        er = "Trường này không được bỏ trống";
                        height = 63;
                      });
                    } else {
                      setState(() {
                        er = null;
                        height = 40;
                      });
                    }
                  } else if (widget.type == 'Email') {
                    if (isEmail(widget.controller!.text)) {
                      setState(() {
                        er = null;
                        height = 40;
                      });
                    } else {
                      setState(() {
                        er = "Đây phải là một Email";
                        height = 63;
                      });
                    }
                  } else if (widget.type == 'Phone') {
                    if (_isPhoneNumber(widget.controller!.text)) {
                      setState(() {
                        er = null;
                        height = 40;
                      });
                    } else {
                      setState(() {
                        er = "Đây phải là một số điện thoại";
                        height = 63;
                      });
                    }
                  } else if (widget.type == 'Number') {
                    if (isNumber(widget.controller!.text)) {
                      setState(() {
                        er = null;
                        height = 40;
                      });
                    } else {
                      setState(() {
                        er = "Đây phải là một số ";
                        height = 63;
                      });
                    }
                  } else if (widget.type == 'None') {}
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
