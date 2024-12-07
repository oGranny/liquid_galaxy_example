import 'package:flutter/material.dart';
import 'package:liquid_galaxy_task/Widgets/connect_tab.dart';
import 'package:liquid_galaxy_task/Widgets/control_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(child: Text("Control", style: TextStyle(fontSize: 18))),
              Tab(child: Text("Connect", style: TextStyle(fontSize: 18)))
            ],
          ),
          title: const Text('Liquid Galaxy'),
          // backgroundColor: Colors.orange,
        ),
        body: const TabBarView(
          children: [
            // Text("Control"),
            // Text("Connect"),
            ControlTab(),
            ConnectTab(),
          ],
        ),
      ),
    );
  }
}
