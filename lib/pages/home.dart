import 'package:final_project/pages/Accomodation_Data.dart';
import 'package:final_project/pages/GST.dart';
import 'package:final_project/pages/MealPlanData.dart';
import 'package:final_project/pages/TDS.dart';
import 'package:final_project/pages/comission_charge.dart';
import 'package:final_project/pages/fetch.dart';
import 'package:final_project/pages/fetch1.dart';
import 'package:final_project/pages/lead_type.dart';
import 'package:final_project/pages/meal_plan.dart';
import 'package:final_project/pages/occupancy_type.dart';
import 'package:final_project/pages/sourceType.dart';
import 'package:final_project/pages/source_type.dart';
import 'package:final_project/pages/status.dart';
import 'package:flutter/material.dart';
import "package:final_project/pages/accomodation_type.dart";
import 'package:final_project/pages/cancellation_remark.dart';
import 'package:final_project/pages/service_charge.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MASTERS',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10.0,2,0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCompanyItem('ACCOMMODATION TYPE'),
                _buildCompanyItem('CANCELLATION REMARK'),
                _buildCompanyItem('COMMISSION CHARGE'),
                _buildCompanyItem('LEAD TYPE'),
                _buildCompanyItem('MEAL PLAN'),
                _buildCompanyItem('OCCUPANCY TYPE'),
                _buildCompanyItem('SERVICE CHARGE'),
                _buildCompanyItem('SOURCE TYPE'),
                _buildCompanyItem('STATUS'),
                _buildCompanyItem('TDS'),
                _buildCompanyItem('GST'),
                _buildCompanyItem('MASTERS DATA'),
                _buildCompanyItem('MASTERS DATA1'),
                _buildCompanyItem('MealPlan_Data'),
                _buildCompanyItem('Source_Type'), 
                 _buildCompanyItem('Accomodation_data'), 
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyItem(String companyName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
            _navigateToCompanyPage(companyName);
            },
          ),
          SizedBox(width: 8.0),
          Text(
            companyName,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  void _navigateToCompanyPage(String companyName){
    switch(companyName){
      case 'ACCOMMODATION TYPE':
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChipApp() ));
      break;

      case 'CANCELLATION REMARK':
      Navigator.push(context, MaterialPageRoute(builder: (context) => Cancellation() ));
      break;

      case 'COMMISSION CHARGE':
      Navigator.push(context, MaterialPageRoute(builder: (context) => Commission() ));
      break;

      case 'LEAD TYPE':
      Navigator.push(context, MaterialPageRoute(builder: (context) => Lead() ));
      break;

      case 'MEAL PLAN':
      Navigator.push(context, MaterialPageRoute(builder: (context) => MealPlan() ));
      break;

      case 'OCCUPANCY TYPE':
      Navigator.push(context, MaterialPageRoute(builder: (context) => Occupancy() ));
      break;

      case 'SERVICE CHARGE':
      Navigator.push(context, MaterialPageRoute(builder: (context) => Service() ));
      break;

      case 'SOURCE TYPE':
      Navigator.push(context, MaterialPageRoute(builder: (context) => Source() ));
      break;

      case 'STATUS':
      Navigator.push(context, MaterialPageRoute(builder: (context) => Status() ));
      break;

      case 'TDS':
      Navigator.push(context, MaterialPageRoute(builder: (context) => TDS() ));
      break;

      case 'GST':
      Navigator.push(context, MaterialPageRoute(builder: (context) => GST() ));
      break;

       case 'MASTERS DATA':
      Navigator.push(context, MaterialPageRoute(builder: (context) => Fetch() ));
      break;

       case 'MASTERS DATA1':
      Navigator.push(context, MaterialPageRoute(builder: (context) => CancellationRemarksViewer() ));
      break;

       case 'MealPlan_Data':
      Navigator.push(context, MaterialPageRoute(builder: (context) => MealPlanData() ));
      break;

       case 'Source_Type':
      Navigator.push(context, MaterialPageRoute(builder: (context) => SourceType() ));
      break;

        case 'Accomodation_data':
      Navigator.push(context, MaterialPageRoute(builder: (context) => AccommodationType() ));
      break;
    }
  }
}
