import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/model/FarmerDetailmodel.dart';
import 'package:collector/service/farmer_db_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Collection extends StatefulWidget {
  const Collection({super.key});

  @override
  State<Collection> createState() => _farmersState();
}

final _farmerdb = FarmerDatabaseServices();

class _farmersState extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collector'),
      ),
      body: StreamBuilder(
        stream: _farmerdb.getfarmers(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List farmers = snapshot.data?.docs ?? [];

          if (farmers.isEmpty) {
            return const Center(child: Text('Add Farmers'));
          }
          return ListView.builder(
              itemCount: farmers.length,
              itemBuilder: (context, index) {
                Farmer farmer = farmers[index].data();
                String farmerId = farmers[index].id;
                // print(farmerId);

                return Expanded(
                    child: GestureDetector(
                  onTap: () {
                    context.goNamed('farmer');
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(farmer.firstname),
                    ),
                  ),
                ));
              });
        },
      ),
    );
  }
}
