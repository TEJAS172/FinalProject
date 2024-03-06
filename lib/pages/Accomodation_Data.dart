import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccommodationType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accommodation Types'),
      ),
      body: Center(
        child: FetchAccommodationTypes(),
      ),
    );
  }
}

class FetchAccommodationTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Accommodation Type').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Text('No data available');
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

            if (data == null || data.isEmpty) {
              return SizedBox(); // Return an empty container if data is null or empty
            }

            // Check if 'remarks' key exists and has a valid value
            if (data.containsKey('remarks') && data['remarks'] is List<dynamic>) {
              List<dynamic> remarks = data['remarks'] ?? []; // Handling null for remarks

              return ListTile(         
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: remarks.map((remark) => Text(remark.toString())).toList(),
                ),
                // title: Text('Timestamp: ${data['timestamp'].toString()}'),
              );
            } else {
              return SizedBox(); // Return an empty container if 'remarks' is missing or not a List<dynamic>
            }
          }).toList(),
        );
      },
    );
  }
}
