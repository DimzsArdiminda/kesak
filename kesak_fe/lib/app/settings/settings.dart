import 'package:flutter/material.dart';
import 'package:kesak_fe/app/profile/profile.dart';
import 'package:kesak_fe/components/Colors.dart';
import 'package:kesak_fe/data/settings_menu.dart';
import 'package:kesak_fe/helper/router.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Container _bannerProfile() {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [secondaryColor, secondaryColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -30,
                  top: -30,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  left: -50,
                  bottom: -50,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: textColorW.withOpacity(0.08),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/150?img=3'),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: textColorW,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'dimasardiminda@gmail.com',
                          style: TextStyle(
                            color: textColorW,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '+62 812-3456-7890',
                          style: TextStyle(
                            color: textColorW,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettingsMenuItem(Map item, int index) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: index == menu_settings.length - 1 ? 0 : 15,
      ),
      child: GestureDetector(
        onTap: item['onTap'],
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            // color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: item['color'].withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item['icon'],
                  color: item['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  item['title'],
                  style: TextStyle(
                    color: textColorB,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: textColorB.withOpacity(0.5),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text("Settings"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: primaryColor,
        child: ListView(
          children: [
            TextButton(
                onPressed: () => navigateTo(context, Profile()),
                child: _bannerProfile()),
            const SizedBox(height: 20),
            Column(
              children: menu_settings.asMap().entries.map((entry) {
                int index = entry.key;
                Map item = entry.value;
                return _buildSettingsMenuItem(item, index);
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
