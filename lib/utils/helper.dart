// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Helper {
  static const TAG_FORMAT = r"@.\w+";
  static const ITALIC_FORMAT = r'_(.*?)\_';
  static const STRIKE_THROUGH_FORMAT = '~(.*?)~';
  static const BOLD_FORMAT = r'\*(.*?)\*';
  static const CODE_FORMAT = r'```(.*?)```';
  static const LINK_FORMAT =
      r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)';

  static Map<String, TextStyle> formatRegexIdentifiers = {
    TAG_FORMAT: const TextStyle(
      color: Colors.blue,
    ),
    ITALIC_FORMAT: const TextStyle(
      fontStyle: FontStyle.italic,
    ),
    STRIKE_THROUGH_FORMAT: const TextStyle(
      decoration: TextDecoration.lineThrough,
    ),
    BOLD_FORMAT: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    CODE_FORMAT: const TextStyle(
      color: Colors.black,
      fontFeatures: [FontFeature.tabularFigures()],
    ),
    LINK_FORMAT: TextStyle(
      decoration: TextDecoration.underline,
      letterSpacing: 1.4,
      fontSize: 15.sp,
    ),
  };

  static set setRegexIdentifiers(Map<String, TextStyle> styles) {
    formatRegexIdentifiers = styles;
  }

  static TextSpan buildTextSpan({
    required String text,
    required TextStyle style,
    Color linkHighlightColor = Colors.blue,
    bool isLinkClickable = true,
  }) {
    final List<InlineSpan> children = [];
    late String patternMatched;
    String formatText;
    TextStyle? myStyle;
    Pattern pattern = RegExp(
        formatRegexIdentifiers.keys.map((key) {
          return key;
        }).join('|'),
        multiLine: true);
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        myStyle = formatRegexIdentifiers[match[0]] ??
            formatRegexIdentifiers[formatRegexIdentifiers.keys.firstWhere(
              (e) {
                bool ret = false;
                RegExp(e).allMatches(text).forEach((element) {
                  if (element.group(0) == match[0]) {
                    patternMatched = e;
                    ret = true;
                  }
                });
                return ret;
              },
            )];
        bool isLink = false;
        switch (patternMatched) {
          case (ITALIC_FORMAT):
            formatText = match[0]!.replaceAll("_", " ");
            break;
          case (BOLD_FORMAT):
            formatText = match[0]!.replaceAll("*", " ");
            break;
          case (STRIKE_THROUGH_FORMAT):
            formatText = match[0]!.replaceAll("~", " ");
            break;
          case (CODE_FORMAT):
            formatText = match[0]!.replaceAll("```", "   ");
            break;
          case (LINK_FORMAT):
            isLink = true;
            formatText = match[0]!;
            break;
          default:
            if (patternMatched.contains("(.*?)")) {
              String startIdentifier =
                  patternMatched.substring(0, patternMatched.indexOf("("));
              String replaceIdentifier = "";
              for (var _ in patternMatched.characters) {
                replaceIdentifier += " ";
              }
              formatText =
                  match[0]!.replaceAll(startIdentifier, replaceIdentifier);
            } else {
              formatText = match[0]!;
            }
        }
        GestureRecognizer? recognizer;
        if (isLink && isLinkClickable) {
          recognizer = TapGestureRecognizer()
            ..onTap = () {
              launchUrlString(formatText);
            };
          myStyle = myStyle!.copyWith(
            color: linkHighlightColor,
          );
        }
        children.add(
          TextSpan(
            text: formatText,
            style: style.merge(myStyle),
            recognizer: recognizer,
          ),
        );
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );

    return TextSpan(style: style, children: children);
  }
}
