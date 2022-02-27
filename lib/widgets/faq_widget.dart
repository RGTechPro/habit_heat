import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:habit_heat/model/FAQ.dart';

class FAQWidget extends StatelessWidget {
  final FAQ faq;

  FAQWidget({required this.faq});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ExpandablePanel(
        header: Text(
          faq.question,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        collapsed: SizedBox(
          height: 0,
        ),
        expanded: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            faq.answer,
            softWrap: true,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
