import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/model/RestockModel.dart';
import 'package:collector/service/Restock_db_services.dart';
import 'package:flutter/material.dart';

class Restockdata extends StatefulWidget {
  const Restockdata({Key? key}) : super(key: key);

  @override
  State<Restockdata> createState() => _RestockdataState();
}

class _RestockdataState extends State<Restockdata> {
  late TextEditingController _carrotController;
  late TextEditingController _potatoController;
  late TextEditingController _cabbageController;
  late TextEditingController _capsicumController;
  late TextEditingController _beansController;

  String _selectedDistrict = 'Kalutara'; // Default selected district

  @override
  void initState() {
    super.initState();
    _carrotController = TextEditingController();
    _potatoController = TextEditingController();
    _cabbageController = TextEditingController();
    _capsicumController = TextEditingController();
    _beansController = TextEditingController();
  }

  @override
  void dispose() {
    _carrotController.dispose();
    _potatoController.dispose();
    _cabbageController.dispose();
    _capsicumController.dispose();
    _beansController.dispose();
    super.dispose();
  }

  final RestockDatabaseServices _databaseServices = RestockDatabaseServices();

  void _submitForm() {
    String carrotAmount = _carrotController.text;
    String potatoAmount = _potatoController.text;
    String cabbageAmount = _cabbageController.text;
    String capsicumAmount = _capsicumController.text;
    String beansAmount = _beansController.text;

    Restock restock = Restock(
        carrotAmount: int.tryParse(carrotAmount) ?? 0,
        potatoAmount: int.tryParse(potatoAmount) ?? 0,
        cabbageAmount: int.tryParse(cabbageAmount) ?? 0,
        capsicumAmount: int.tryParse(capsicumAmount) ?? 0,
        beansAmount: int.tryParse(beansAmount) ?? 0,
        requestDate: Timestamp.now(),
        district: _selectedDistrict);
    _databaseServices.addRestock(restock);
    // Handle form submission here (e.g., save data to Firestore)
    // Clear text field values after submission
    _carrotController.clear();
    _potatoController.clear();
    _cabbageController.clear();
    _capsicumController.clear();
    _beansController.clear();
    setState(() {
      _selectedDistrict = 'Kalutara'; // Reset district dropdown to default
    });
    // Show a dialog or perform further actions after submission
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Form Submitted'),
        content: Text('Restockdata request submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restockdata Request Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedDistrict,
              items: ['Kalutara', 'Colombo', 'Matara']
                  .map((district) => DropdownMenuItem<String>(
                        value: district,
                        child: Text(district),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDistrict =
                      value ?? 'Kalutara'; // Default to Kalutara if null
                });
              },
              decoration: InputDecoration(
                labelText: 'Select District',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _carrotController,
              decoration: InputDecoration(labelText: 'Carrot Amount (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _potatoController,
              decoration: InputDecoration(labelText: 'Potato Amount (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _cabbageController,
              decoration: InputDecoration(labelText: 'Cabbage Amount (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _capsicumController,
              decoration: InputDecoration(labelText: 'Capsicum Amount (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _beansController,
              decoration: InputDecoration(labelText: 'Beans Amount (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
