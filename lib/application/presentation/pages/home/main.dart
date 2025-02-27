import 'package:abbon_mobile_test/application/presentation/widget/layouts/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menu = [
      {"name": "Location", "icon": CupertinoIcons.location},
      {"name": "Call", "icon": CupertinoIcons.phone},
      {"name": "Mail", "icon": CupertinoIcons.mail},
      {"name": "Line", "icon": CupertinoIcons.chat_bubble},
    ];

    return ScaffoldApp(
      title: "",
      body: Column(
        children: [
          Column(
            children: [
              CircleAvatar(radius: 50),
              SizedBox(height: 10),
              Text(
                'Khwan Nonta',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          SizedBox(height: 40),
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: menu.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 90,
                          width: 90,
                          color: Colors.white,
                          child: Icon(
                            menu[index]["icon"] as IconData,
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        menu[index]["name"].toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.apply(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
