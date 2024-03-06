import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChipApp extends StatelessWidget {
  const ChipApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue, // Setting app bar background color to blue
          foregroundColor: Colors.white, // Setting app bar text color to white
        ),
      ),
      home: const ActionChoiceExample(),
    );
  }
}

class ActionChoiceExample extends StatefulWidget {
  const ActionChoiceExample({Key? key});

  @override
  State<ActionChoiceExample> createState() => _ActionChoiceExampleState();
}

class _ActionChoiceExampleState extends State<ActionChoiceExample> {
  int? _value = 1;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ACCOMMODATION TYPE'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose a type', style: textTheme.headline6),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                4,
                (int index) {
                  String chipLabel = '';
                  switch (index) {
                    case 0:
                      chipLabel = 'Hotel';
                      break;
                    case 1:
                      chipLabel = 'Apartment';
                      break;
                    case 2:
                      chipLabel = 'Guest house';
                      break;
                    case 3:
                      chipLabel = 'Villa';
                      break;
                  }
                  return ChoiceChip(
                    label: Text(chipLabel),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                      });
                    },
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_value != null) {
                  _submitToFirebase();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a type')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitToFirebase() async {
    String selectedType = '';
    switch (_value) {
      case 0:
        selectedType = 'Hotel';
        break;
      case 1:
        selectedType = 'Apartment';
        break;
      case 2:
        selectedType = 'Guest house';
        break;
      case 3:
        selectedType = 'Villa';
        break;
    }

    try {
      await _firestore.collection('Accommodation Type').add({
        'type': selectedType,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Type submitted')),
      );
    } catch (e) {
      print('Error submitting type: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit type')),
      );
    }
  }
}
