import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/components/Colorpallet.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.search),
          )
        ],
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

                return GestureDetector(
                  onTap: () {
                    context.goNamed(
                      'farmer', // Assuming your route name is 'farmer'
                      pathParameters: {
                        'id': farmerId,
                        'name': farmer.firstname + ' ' + farmer.lastname,
                      },
                    );
                  },
                  child: Card(
                    child: ListTile(
                      tileColor: ColorPalette.forest_Green.withOpacity(0.2),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(farmer.firstname + " " + farmer.lastname),
                          Text(farmer.phonenum.toString())
                        ],
                      ),
                      subtitle: Text(farmer.nic),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
