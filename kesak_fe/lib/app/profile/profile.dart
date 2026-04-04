import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'), 
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blueGrey,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'dimasardiminda@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '+62 812-3456-7890',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),  
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel sapien eget nunc efficitur varius. Sed at felis ac nisl efficitur tincidunt.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
              ),
          ),
        ],
      ),
    );
  }
}