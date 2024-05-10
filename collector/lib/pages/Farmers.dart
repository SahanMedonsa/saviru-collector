import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class farmers extends StatefulWidget {
  const farmers({Key? key}) : super(key: key);

  @override
  State<farmers> createState() => _CollectionState();
}

class _CollectionState extends State<farmers> {
  late TextEditingController _carrotController;
  late TextEditingController _potatoController;
  late TextEditingController _cabbageController;
  late TextEditingController _capsicumController;
  late TextEditingController _beansController;
  late TextEditingController _dateController;

  String _textField2Value = '';

  String dropdownValue2 = 'A';

  @override
  void initState() {
    super.initState();
    // Initialize the date controller with the current date
    _dateController = TextEditingController(text: _getCurrentDate());
    _carrotController = TextEditingController();
    _potatoController = TextEditingController();
    _cabbageController = TextEditingController();
    _capsicumController = TextEditingController();
    _beansController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _dateController.dispose();
    super.dispose();
  }

  String _getCurrentDate() {
    // Get current date formatted as 'yyyy-MM-dd'
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Collector'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daily Collection',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.0),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Date'),
                    onChanged: (value) {
                      // Handle onChanged event if needed
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: TextField(
                          controller: _carrotController,
                          decoration:
                              InputDecoration(labelText: 'Carrot Amount (kg)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        items: ['A', 'B', 'C'].map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue2 = value ?? '';
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: TextField(
                          controller: _potatoController,
                          decoration:
                              InputDecoration(labelText: 'Potato Amount (kg)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        items: ['A', 'B', 'C'].map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue2 = value ?? '';
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: TextField(
                          controller: _cabbageController,
                          decoration:
                              InputDecoration(labelText: 'Cabbage Amount (kg)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        items: ['A', 'B', 'C'].map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue2 = value ?? '';
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: TextField(
                          controller: _capsicumController,
                          decoration: InputDecoration(
                              labelText: 'Capsicum Amount (kg)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        items: ['A', 'B', 'C'].map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue2 = value ?? '';
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: TextField(
                          controller: _beansController,
                          decoration:
                              InputDecoration(labelText: 'Beans Amount (kg)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        items: ['A', 'B', 'C'].map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue2 = value ?? '';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Expected price'),
                    onChanged: (value) {
                      setState(() {
                        _textField2Value = value;
                      });
                    },
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission here
                      print('Form submitted');
                      print('Name: $_textField2Value');
                      print('Date: ${_dateController.text}');

                      print('Grade: $dropdownValue2');
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
