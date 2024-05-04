import 'package:collector/components/Gtext.dart';
import 'package:flutter/material.dart';

class farmers extends StatefulWidget {
  const farmers({super.key});

  @override
  State<farmers> createState() => _CollectionState();
}

class _CollectionState extends State<farmers> {
  // Define variables to hold form field values
  String _textField1Value = '';
  String _textField2Value = '';

  // List of dropdown items
  List<String> _dropdownItems1 = ['Carrot', 'Carbadge', 'Capcicum'];
  List<String> _dropdownItems2 = ['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    String dropdownValue1 = _dropdownItems1.first;
    String dropdownValue2 = _dropdownItems2.first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Collector'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gtext(
              text: 'Farmer name',
              tsize: 16,
              tcolor: Colors.black,
              fweight: FontWeight.w500,
            ),
            SizedBox(height: 16.0),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Text Field 1
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) {
                      setState(() {
                        _textField1Value = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),

                  // Text Field 2
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Date'),
                    onChanged: (value) {
                      setState(() {
                        _textField2Value = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),

                  // Dropdown 1
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
                        dropdownValue1 = value ?? '';
                      });
                    },
                    decoration: InputDecoration(labelText: 'Vegetable'),
                  ),

                  // Dropdown 2
                  DropdownButtonFormField(
                    value: dropdownValue2,
                    items: _dropdownItems2.map((item2) {
                      return DropdownMenuItem(
                        value: item2,
                        child: Text(item2),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue2 = value.toString();
                      });
                    },
                    decoration: InputDecoration(labelText: 'Grade'),
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

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission here
                      print('Form submitted');
                      print('Text Field 1: $_textField1Value');
                      print('Text Field 2: $_textField2Value');
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
