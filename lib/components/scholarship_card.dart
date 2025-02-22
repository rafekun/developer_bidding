import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:easy_fund/screens/scholarship_detail_screen.dart';

class ScholarshipCard extends StatelessWidget {
  ScholarshipCard({this.budged, this.deadline, this.scholarshipName});

  String scholarshipName;
  dynamic deadline;
  int budged;

  void CardTapped(context){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => ScholarshipDetail(scholarshipName:this.scholarshipName)),);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ScholarshipDetail(scholarshipName: scholarshipName,)));
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(27.0),
              child:
              Icon(Icons.check_circle, color: easyFundMainColor, size: 20.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.scholarshipName,
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                  Text(this.budged.toString()),
//                  Text(this.deadline,
//                    style: TextStyle(
//                        color: Colors.red,
//                        fontSize: 11.0,
//                        fontWeight: FontWeight.bold),
//                  ),
                ],
              ),
            ),
            SizedBox(width: 60.0),
            Icon(
              Icons.keyboard_arrow_right,
              color: easyFundMainColor,
              size: 30.0,
            ),
          ],
        ),
        elevation: 5.0,
        color: Colors.white,
      ),
    );
  }
}
