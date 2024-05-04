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

  // List of dropdown items
  List<String> _dropdownItems1 = ['Carrot', 'Carbadge', 'Capcicum'];
  List<String> _dropdownItems2 = [
    'Dry soil ',
    'Clay soil',
    'Sandy soil',
    'loang soil'
  ];
  List<String> _dropdownItems3 = ['Sunny', 'Rainy', 'Windy', 'Cloudy'];
  List<String> _dropdownItems4 = ['1', '2', '3', '4', '5', '6'];

  @override
  Widget build(BuildContext context) {
    String dropdownValue1 = _dropdownItems1.first;
    String dropdownValue2 = _dropdownItems2.first;
    String dropdownValue3 = _dropdownItems3.first;
    String dropdownValue4 = _dropdownItems4.first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Inquiry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gtext(
                text: 'Vegetables expected to be grown in the next season',
                tsize: 18,
                tcolor: Colors.black,
                fweight: FontWeight.w700,
              ),
              SizedBox(height: 16.0),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Farmer UID'),
                      onChanged: (value) {
                        setState(() {
                          _textField2Value = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Date'),
                      onChanged: (value) {
                        setState(() {
                          _textField2Value = value;
                        });
                      },
                    ),

                    SizedBox(height: 16.0),

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
                      decoration:
                          InputDecoration(labelText: 'Expected Vegetable'),
                    ),
                    SizedBox(height: 16.0),
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
                          dropdownValue1 = value ?? '';
                        });
                      },
                      decoration: InputDecoration(labelText: 'Soil type'),
                    ),
                    SizedBox(height: 16.0),
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
                          dropdownValue1 = value ?? '';
                        });
                      },
                      decoration: InputDecoration(labelText: 'Whether'),
                    ),
                    SizedBox(height: 16.0),
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
                          dropdownValue1 = value ?? '';
                        });
                      },
                      decoration: InputDecoration(labelText: 'Time period'),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Fertilizer'),
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
      ),
    );
  }
}
