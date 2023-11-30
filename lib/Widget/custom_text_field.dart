import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripshiptask/Utils/hexcolor.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? error;
  final String? initialValue;
  final TextStyle? labelStyle;
  final bool? require;
  final Function onChange;

  final TextInputType? keyboardType;
  final int maxLines;
  final bool isPasswordField;
  final int? maxLength;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final int? minLength;
  final bool readOnly;
  final bool? isMail;
  final String? txt;
  final String? helperTxt;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {Key? key,
      this.label,
      this.isMail,
      this.helperTxt,
      this.labelStyle,
      this.require,
      this.hint,
      this.txt,
      this.error,
      required this.onChange,
      this.initialValue,
      this.keyboardType,
      this.maxLines = 1,
      this.isPasswordField = false,
      this.maxLength,
      this.textStyle,
      this.textInputAction,
      this.minLength,
      this.readOnly = false,
      this.inputFormatters})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordInVisible = true;
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    if (widget.initialValue != null) {
      widget.onChange(widget.initialValue!);
    }
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clr = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 48.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.label == ''
              ? Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: widget.label,
                        style: widget.labelStyle ??
                            DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          widget.require == null || widget.require == true
                              ? const TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red))
                              : const TextSpan(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                )
              : Container(),
          TextFormField(
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(myFocusNode);
              });
            },
            focusNode: myFocusNode,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            style: widget.textStyle,
            readOnly: widget.readOnly,
            initialValue: widget.initialValue,
            inputFormatters: widget.keyboardType == TextInputType.number
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ]
                : null,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            obscureText:
                widget.isPasswordField == true ? _passwordInVisible : false,
            decoration: InputDecoration(
                // labelText:widget.text,
                suffixIcon: widget.isPasswordField
                    ? IconButton(
                        icon: Icon(
                            _passwordInVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: HexColor("#C4C4C4")),
                        onPressed: () {
                          setState(() {
                            _passwordInVisible =
                                !_passwordInVisible; //change boolean value
                          });
                        },
                      )
                    : null,
                hintText: widget.hint,
                label: Text("${widget.txt}",
                    style: textTheme.titleMedium?.copyWith()),
                labelStyle: textTheme.caption?.copyWith(
                    fontSize: 16.sp,
                    color: myFocusNode.hasFocus
                        ? Theme.of(context).focusColor
                        : Colors.black54),
                helperText: widget.helperTxt,
                hintStyle: textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: clr.outline),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: clr.outline),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: clr.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w)),
            onChanged: (value) {
              widget.onChange(value);
            },
            validator: (value) {
              var validation = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (widget.require == false) {
                return null;
              }
              if (widget.isMail == true) {
                print("in0");

                if (validation) {
                  print("in");

                  return null;
                }
                return widget.error;
              }
              if (value == null || value.isEmpty) {
                if (widget.error == null) {
                  return widget.hint;
                }
                return widget.error;
              }
              if (widget.minLength != null) {
                if (value.length < widget.minLength!) {
                  if (widget.error == null) {
                    return widget.hint;
                  }
                  return widget.error;
                }
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}

class CustomTextField1 extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? error;
  final String? initialValue;
  final TextStyle? labelStyle;
  final bool? require;
  final Function onChange;
  final Function onTab;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool isPasswordField;
  final int? maxLength;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final int? minLength;
  final bool readOnly;
  final bool? isMail;
  final String? txt;
  final String? helperTxt;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField1(
      {Key? key,
      this.label,
      this.isMail,
      this.helperTxt,
      this.labelStyle,
      this.require,
      this.hint,
      this.txt,
      this.error,
      required this.onChange,
      required this.onTab,
      this.initialValue,
      this.keyboardType,
      this.maxLines = 1,
      this.isPasswordField = false,
      this.maxLength,
      this.textStyle,
      this.textInputAction,
      this.minLength,
      this.readOnly = false,
      this.inputFormatters})
      : super(key: key);

  @override
  State<CustomTextField1> createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  bool _passwordInVisible = true;
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    if (widget.initialValue != null) {
      widget.onChange(widget.initialValue!);
    }
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clr = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 48.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.label == ''
              ? Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: widget.label,
                        style: widget.labelStyle ??
                            DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          widget.require == null || widget.require == true
                              ? const TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red))
                              : const TextSpan(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                )
              : Container(),
          TextFormField(
            onTap: () {
              widget.onTab;
            },
            // onTap: () {
            //   // setState(() {
            //   //   FocusScope.of(context).requestFocus(myFocusNode);
            //   // });
            // },
            focusNode: myFocusNode,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            style: widget.textStyle,
            readOnly: widget.readOnly,
            initialValue: widget.initialValue,
            inputFormatters: widget.keyboardType == TextInputType.number
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ]
                : null,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            obscureText:
                widget.isPasswordField == true ? _passwordInVisible : false,
            decoration: InputDecoration(
                // labelText:widget.text,
                suffixIcon: widget.isPasswordField
                    ? IconButton(
                        icon: Icon(
                            _passwordInVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: HexColor("#C4C4C4")),
                        onPressed: () {
                          setState(() {
                            _passwordInVisible =
                                !_passwordInVisible; //change boolean value
                          });
                        },
                      )
                    : null,
                hintText: widget.hint,
                label: Text("${widget.txt}",
                    style: textTheme.titleMedium?.copyWith()),
                labelStyle: textTheme.caption?.copyWith(
                    fontSize: 16.sp,
                    color: myFocusNode.hasFocus
                        ? Theme.of(context).focusColor
                        : Colors.black54),
                helperText: widget.helperTxt,
                hintStyle: textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: clr.outline),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: clr.outline),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: clr.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w)),
            onChanged: (value) {
              widget.onChange(value);
            },
            validator: (value) {
              var validation = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (widget.require == false) {
                return null;
              }
              if (widget.isMail == true) {
                print("in0");

                if (validation) {
                  print("in");

                  return null;
                }
                return widget.error;
              }
              if (value == null || value.isEmpty) {
                if (widget.error == null) {
                  return widget.hint;
                }
                return widget.error;
              }
              if (widget.minLength != null) {
                if (value.length < widget.minLength!) {
                  if (widget.error == null) {
                    return widget.hint;
                  }
                  return widget.error;
                }
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
