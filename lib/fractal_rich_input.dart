library fractal_rich_input;

export 'fractal_rich_input_controller.dart';

import 'package:flutter/material.dart';
import 'package:fractal_rich_input/utils/helper.dart';

class FractalRichInput {
  static get formatRegexIdentifiers => Helper.formatRegexIdentifiers;

  static set overrideFormatRegexIdentifiers(Map<String, TextStyle> styles) =>
      Helper.setRegexIdentifiers = styles;

  static addFormatRegexIdentifierStyle({
    required String key,
    required TextStyle style,
  }) {
    Helper.formatRegexIdentifiers[key] = style;
  }

  static removeRegexIdentifierStyle({required String key}) {
    Helper.formatRegexIdentifiers.remove(key);
  }

  static TextSpan buildTextSpan({
    required String text,
    required TextStyle style,
    Color linkHighlightColor = Colors.blue,
    bool isLinkClickable = true,
  }) {
    return Helper.buildTextSpan(
      text: text,
      style: style,
      linkHighlightColor: linkHighlightColor,
      isLinkClickable: isLinkClickable,
    );
  }
}
