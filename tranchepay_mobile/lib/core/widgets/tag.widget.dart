import 'package:flutter/material.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

// ignore: must_be_immutable
class TagWiget extends StatelessWidget {
  TagType type = TagType.primary;
  String text = "Tag";
  Color _textColor = Colors.white;
  TagWiget({super.key, this.type = TagType.primary, this.text = "Tag"});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorByType(type),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(" $text ",
          style: TextStyle(
            color: _textColor,
            fontSize: 12,
          )),
    );
  }

  Color colorByType(TagType type) {
    switch (type) {
      case TagType.primary:
        _textColor = Colors.white;
        return Color(primaryColor);
      case TagType.success:
        _textColor = Color(successColor);
        return Color(successBackgroundColor);
      case TagType.danger:
        _textColor = Color(dangerColor);
        return Color(dangerBackgroundColor);
      case TagType.warning:
        _textColor = Color(warnColor);
        return Color(warnBackgroundColor);
      case TagType.info:
        _textColor = Color(accentColor);
        return Color(accentBackgroundColor);
      case TagType.dark:
        _textColor = Colors.white;
        return Colors.black;
      default:
        return Color(primaryColor);
    }
  }
}

enum TagType { primary, success, danger, warning, info, dark }
