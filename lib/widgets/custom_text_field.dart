import 'package:flutter/material.dart';

typedef void CustomTextFieldOnChangeCallBack(String text);

class CustomTextField extends StatelessWidget {
  final String fieldTitle;
  final String hint;
  final bool isSecure;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool isShowCursor;
  final bool isReadOnly;
  final int maxLength;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final CustomTextFieldOnChangeCallBack onChanged;

  CustomTextField({
    this.fieldTitle,
    this.textEditingController,
    this.maxLength = 500,
    this.hint = '',
    this.isSecure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isShowCursor = true,
    this.isReadOnly = false,
    this.onChanged,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var isMobileLayout = shortestSide < 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: height * 0.01,
          ),
          width: isMobileLayout ? width * 0.8 : width * 0.65,
          child: TextField(
            maxLength: maxLength,
            cursorColor: Theme.of(context).primaryColor,
            style: TextStyle(
              fontSize: isMobileLayout ? width * 0.045 : width * 0.03,
            ),
            showCursor: isShowCursor,
            autocorrect: false,
            controller: this.textEditingController,
            readOnly: this.isReadOnly,
            obscureText: this.isSecure,
            keyboardType: textInputType,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              labelText: this.hint,
              hintStyle: TextStyle(
                fontSize: isMobileLayout ? width * 0.04 : width * 0.025,
              ),
              prefixIcon: this.prefixIcon,
              suffixIcon: this.suffixIcon,
            ),
            onChanged: (text) => this.onChanged(text),
          ),
        ),
      ],
    );
  }
}
