import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/components/Gtext.dart';
import 'package:flutter/material.dart';

class UpdateInquiry extends StatefulWidget {
  const UpdateInquiry({super.key});

  @override
  State<UpdateInquiry> createState() => _farmereInquiryState();
}

class _farmereInquiryState extends State<UpdateInquiry> {
  // Define variables to hold form field values
  String _textField1Value = '';
  String _textField2Value = '';

  // Dropdown values
  String dropdownValue1 = 'Carrot';
  String dropdownValue2 = 'Dry soil';
  String dropdownValue3 = 'Sunny';
  String dropdownValue4 = '1';

  // List of dropdown items
  List<String> _dropdownItems1 = ['Carrot', 'Carbage', 'Capsicum'];
  List<String> _dropdownItems2 = [
    'Dry soil',
    'Clay soil',
    'Sandy soil',
    'Loamy soil'
  ];
  List<String> _dropdownItems3 = ['Sunny', 'Rainy', 'Windy', 'Cloudy'];
  List<String> _dropdownItems4 = ['1', '2', '3', '4', '5', '6'];

  Future<void> _submitData() async {
    try {
      await FirebaseFirestore.instance.collection('inquiry').add({
        'expected_month': _textField2Value,
        'expected_vegetable': dropdownValue1,
        'growing_area': _textField1Value, // Use expected growing area input
        'soil_type': dropdownValue2,
        'weather': dropdownValue3,
        'time_period': dropdownValue4,
        'fertilizer': _textField1Value,
      });
      
      // Show success dialog
      _showDialog('Success', 'Data submitted successfully!');

      // Clear all fields
      _clearFields();
    } catch (e) {
      print('Error submitting data: $e');
      _showDialog('Error', 'Could not submit data. Please try again.');
    }
  }

  // Function to show alert dialog
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to clear all fields
  void _clearFields() {
    setState(() {
      _textField1Value = '';
      _textField2Value = '';
      dropdownValue1 = 'Carrot';
      dropdownValue2 = 'Dry soil';
      dropdownValue3 = 'Sunny';
      dropdownValue4 = '1';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Inquiry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Gtext(
                text: 'Vegetables expected to be grown in the next season',
                tsize: 18,
                tcolor: Colors.black,
                fweight: FontWeight.w700,
              ),
              SizedBox(height: 20.0),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Expected month'),
                      onChanged: (value) {
                        setState(() {
                          _textField2Value = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      value: dropdownValue1,
                      items: _dropdownItems1.map((item1) {
                        return DropdownMenuItem<String>(
                          value: item1,
                          child: Text(item1),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue1 = value ?? dropdownValue1; // Keep current if null
                        });
                      },
                      decoration: InputDecoration(labelText: 'Expected Vegetable'),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Expected growing area'),
                      onChanged: (value) {
                        setState(() {
                          _textField1Value = value; // Changed to hold area input
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      value: dropdownValue2,
                      items: _dropdownItems2.map((item1) {
                        return DropdownMenuItem<String>(
                          value: item1,
                          child: Text(item1),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue2 = value ?? dropdownValue2; // Keep current if null
                        });
                      },
                      decoration: InputDecoration(labelText: 'Soil type'),
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      value: dropdownValue3,
                      items: _dropdownItems3.map((item1) {
                        return DropdownMenuItem<String>(
                          value: item1,
                          child: Text(item1),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue3 = value ?? dropdownValue3; // Keep current if null
                        });
                      },
                      decoration: InputDecoration(labelText: 'Weather'),
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      value: dropdownValue4,
                      items: _dropdownItems4.map((item1) {
                        return DropdownMenuItem<String>(
                          value: item1,
                          child: Text(item1),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue4 = value ?? dropdownValue4; // Keep current if null
                        });
                      },
                      decoration: InputDecoration(labelText: 'Time period'),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Fertilizer'),
                      onChanged: (value) {
                        setState(() {
                          _textField1Value = value; // Storing fertilizer input
                        });
                      },
                    ),
                    SizedBox(height: 40.0),
                    // Submit Button
                    ElevatedButton(
                      onPressed: () {
                        _submitData(); // Call submit data function
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
