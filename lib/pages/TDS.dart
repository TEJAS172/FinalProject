import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:final_project/service/database.dart';

class TDS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _titleControllers = [];
  List<TextEditingController> _chargesControllers = [];
  int _textFieldCount = 1;

  @override
  void initState() {
    super.initState();
    _titleControllers.add(TextEditingController());
    _chargesControllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TDS',
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                setState(() {
                  if (_textFieldCount > 1) {
                    _textFieldCount--;
                    _titleControllers.removeLast();
                    _chargesControllers.removeLast();
                  }
                });
              },
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          width: 600,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _textFieldCount,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _titleControllers[index],
                                decoration: InputDecoration(labelText: 'Title'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _chargesControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Charges',
                                  suffixText: '%',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              if (_titleControllers[index].text.isNotEmpty || _chargesControllers[index].text.isNotEmpty) {
                                setState(() {
                                  _titleControllers[index].text = '';
                                  _chargesControllers[index].text = '';
                                });
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
     ElevatedButton(
  onPressed: () async {
    // Create a list to store the service information of new text fields
    List<Map<String, dynamic>> newTdsInfoList = [];

    // Iterate over the text fields and add data of new text fields to the list
    for (int i = 0; i < _titleControllers.length; i++) {
      // Check if the text field is a new one by comparing with the initial count
      if (i >= _titleControllers.length - _textFieldCount) {
        Map<String, dynamic> tdsInfoMap = {
          "Title": _titleControllers[i].text,
          "Charges": _chargesControllers[i].text,
        };
       newTdsInfoList.add(tdsInfoMap);
      }
    }

    // Upload the data of new text fields to the Firestore database
    for (Map<String, dynamic> tdsInfoMap in newTdsInfoList) {
      String id = randomAlphaNumeric(10);
      await DatabaseMethods().addTDS(tdsInfoMap, id);
    }

    // Display a toast indicating that the service charges of new text fields have been added successfully
    Fluttertoast.showToast(
      msg: "TDS Added Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    );
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyForm()));
  },
  child: Text('Submit'),
),



              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _textFieldCount++;
            _titleControllers.add(TextEditingController());
            _chargesControllers.add(TextEditingController());
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
