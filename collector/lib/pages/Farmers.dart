import 'package:collector/components/Gtext.dart';
import 'package:collector/service/collection_Service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Farmers extends StatefulWidget {
  final String farmerId;
  final String farmerName;

  const Farmers({Key? key, required this.farmerId, required this.farmerName})
      : super(key: key);

  @override
  State<Farmers> createState() => _CollectionState();
}

class _CollectionState extends State<Farmers> {
  late final TextEditingController _amountController;
  late final TextEditingController _dateController;
  late final TextEditingController _expectedPriceController;

  String? dropdownVegetable;
  final FirebaseService _firebaseService = FirebaseService();
  List<Map<String, dynamic>> savedCollections = []; // List to hold added items

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: _getCurrentDate());
    _amountController = TextEditingController();
    _expectedPriceController = TextEditingController();
    _fetchSavedCollections(); // Fetch existing collections when initializing
  }

  String _getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _fetchSavedCollections() async {
    try {
      final collections =
          await _firebaseService.getDailyCollections(widget.farmerId);
      setState(() {
        savedCollections = collections;
      });
    } catch (e) {
      print("Error fetching collections: $e");
    }
  }

  void _showFormDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Add Daily Collection'),
          content: Container(
            width: double.maxFinite, // Make width as large as needed
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Date'),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                    hint: Text('Select Vegetable'),
                    value: dropdownVegetable,
                    isExpanded: true,
                    items: ['Carrot', 'Potato', 'Cabbage', 'Capsicum', 'Beans']
                        .map((vegetable) => DropdownMenuItem<String>(
                              value: vegetable,
                              child: Text(vegetable),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownVegetable = value;
                      });
                    },
                  ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: InputDecoration(
                            labelText: 'Amount (kg)',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _expectedPriceController,
                    decoration: InputDecoration(labelText: 'Today\'s Price:'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss dialog
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () async {
                try {
                  if (dropdownVegetable == null || dropdownVegetable!.isEmpty) {
                    _showAlertDialog("Please select a vegetable.", false);
                    return;
                  }
                  // Call the backend function with your form data
                  await _firebaseService.addDailyCollection(
                    widget.farmerId,
                    _dateController.text,
                    _amountController.text,
                    _expectedPriceController.text,
                    dropdownVegetable!, // Only give dropdownVegetable directly now
                  );

                  // Show Snackbar on successful submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully updated!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Clear input fields after successful submission
                  _clear();

                  // Fetch the updated list of saved collections
                  _fetchSavedCollections();

                  // Dismiss the dialog
                  Navigator.of(dialogContext).pop();
                } catch (e) {
                  // Show error message if something goes wrong
                  _showAlertDialog("Failed to update: $e", false);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _clear() {
    _dateController.clear();
    _amountController.clear();
    _expectedPriceController.clear();
    dropdownVegetable = null;
  }

  void _showAlertDialog(String message, bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Success' : 'Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.farmerName), // Display the farmer's name
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Collection',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showFormDialog,
                  label: Icon(Icons.add),
                  style: ButtonStyle(),
                )
              ],
            ),

            SizedBox(height: 16.0),
            // Display the relevant added items
            Expanded(
              child: ListView.builder(
                itemCount: savedCollections.length,
                itemBuilder: (context, index) {
                  var collection = savedCollections[index];
                  String docId = collection['id'] ??
                      ''; // Assuming you are storing the document ID in the collection

                  return Dismissible(
                    key: Key(docId),
                    direction: DismissDirection
                        .endToStart, // Only swipe from right to left
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      _firebaseService.deleteDailyCollectionData(
                          widget.farmerId, docId);
                      setState(() {
                        savedCollections
                            .removeAt(index); // Remove from list as well
                      });
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Gtext(
                                text: '${collection['CollectedDate']}',
                                tsize: 16,
                                tcolor: Colors.black,
                                fweight: FontWeight.bold),
                            Gtext(
                                text:
                                    '${collection['vege']} - ${collection['amount']} kg',
                                tsize: 16,
                                tcolor: Colors.black,
                                fweight: FontWeight.w500),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Gtext(
                                text: 'Price: ${collection['expectedPrice']}',
                                tsize: 16,
                                tcolor: Colors.black,
                                fweight: FontWeight.w500),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
