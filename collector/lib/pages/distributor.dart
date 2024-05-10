import 'package:collector/Tab%20View/Restock.dart';
import 'package:collector/Tab%20View/RestockContainer.dart';
import 'package:collector/components/Colorpallet.dart';
import 'package:flutter/material.dart';

class distrubutor extends StatefulWidget {
  const distrubutor({Key? key}) : super(key: key);

  @override
  State<distrubutor> createState() => _distrubutorState();
}

class _distrubutorState extends State<distrubutor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branch Distributor'),
      ),
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Column(
          children: [
            TabBar(
              labelColor: ColorPalette.Jungle_Green,
              tabs: [
                Tab(text: 'Re-Stock'),
                Tab(text: 'Re-Stock view'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Content for Tab 1

                  Restockdata(),
                  // Content for Tab 2
                  RestockContainer()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
