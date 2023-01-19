import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fractal_rich_input/utils/helper.dart';

class FractalRichInputController extends TextEditingController {
  final Map<String, TextStyle> map = Helper.formatRegexIdentifiers;
  late Pattern pattern;
  final Color linkHighlightColor;

  FractalRichInputController({
    this.linkHighlightColor = Colors.blue,
    Map<String, TextStyle>? regexIdentifiers,
  }) {
    if (regexIdentifiers != null) {
      Helper.setRegexIdentifiers = regexIdentifiers;
    }
    pattern = RegExp(
        map.keys.map((key) {
          return key;
        }).join('|'),
        multiLine: true);
  }

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    required bool withComposing,
    TextStyle? style,
  }) {
    return Helper.buildTextSpan(
      text: text,
      style: style ??
          TextStyle(
            fontSize: 16.sp,
          ),
      isLinkClickable: false,
    );
  }
}
