import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SourceType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetched Source Types'),
      ),
      body: Center(
        child: FetchSourceTypes(),
      ),
    );
  }
}

class FetchSourceTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Source Type').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            List<dynamic> remarks = data['remarks'];

            return ListTile(         
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: remarks.map((remark) => Text(remark)).toList(),
              ),
              // title: Text('Timestamp: ${data['timestamp'].toString()}'),
            );
          }).toList(),
        );
      },
    );
  }
}
