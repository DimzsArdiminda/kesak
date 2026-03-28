import 'package:flutter/material.dart';
import 'package:kesak_fe/components/Colors.dart';
import 'package:kesak_fe/data/main_menu.dart';

class scrollableMenu extends StatelessWidget {
  const scrollableMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: menuShortCut.asMap().entries.map((entry) {
          int index = entry.key;
          Map item = entry.value;
          return Padding(
            padding: EdgeInsets.only(
                right: index == menuShortCut.length - 1 ? 0 : 15),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    item['iconType'] == 'image'
                        ? Image.asset(
                            item['icon'] as String,
                            width: 28,
                            height: 28,
                          )
                        : Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                            size: 28,
                          ),
                    const SizedBox(width: 8),
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
