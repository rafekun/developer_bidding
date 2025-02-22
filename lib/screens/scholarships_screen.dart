import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/components/scholarship_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_fund/components/colors.dart';
import 'package:easy_fund/data/user_info_data.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;


class ScholarshipsScreen extends StatefulWidget {
  @override
  _ScholarshipsScreenState createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends State<ScholarshipsScreen> {

  final _auth = FirebaseAuth.instance;
  UserInfoData userInfo;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
        await for (var snapshot in _fireStore.collection('userInfo').where('userEmail', isEqualTo: loggedInUser.email).snapshots()){
          for (var Info in snapshot.documents) {
            print(Info.data);
            setState(() {
              userInfo = UserInfoData(gpa: Info.data['GPA'], major: Info.data['major'], grade: Info.data['grade'], graduationYear: Info.data['icdId']);
              print(userInfo.gpa);
            });
          }
        }
      }
    } catch(e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    try{
    if (loggedInUser.email == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
      );
    }
    } catch (e){
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(loggedInUser.email),
          backgroundColor: easyFundMainColor,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  //Implement logout functionality
                  _auth.signOut();
                  Navigator.pop(context);
                }),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text('応募可能な奨学金が件見つかりました。',
                  style: kBoldTextStyle,
                  textAlign: TextAlign.center,)),


            StreamBuilder<QuerySnapshot>(
              stream: userInfo == null ? _fireStore.collection('Scholarships').snapshots() :_fireStore.collection('Scholarships').where('gpa', isLessThanOrEqualTo: userInfo.gpa).snapshots(),


              builder: (context, snapshot) {
                if (!snapshot.hasData || loggedInUser == null) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        Text(" ")
                      ],
                    ),);
                }
                final scholarships = snapshot.data.documents;
                List<ScholarshipCard> scholarshipsCards = [];
                for (var scholarship in scholarships ) {
                  final scholarshipName = scholarship.data['name'];
                  final scholarshipDeadline = scholarship.data['deadline'];
                  final scholarshipBudged = scholarship.data['budged'];
                  final scholarshipCard = ScholarshipCard(
                    scholarshipName: scholarshipName,
                    budged: scholarshipBudged,
                  );

                  scholarshipsCards.add(scholarshipCard);
//                  setState(() {
//                    scholarshipsCount = scholarshipsCards.length;
//                  });
                }
                return Expanded(
                  child: ListView(
                    reverse: false,
                    children: scholarshipsCards,
                  ),
                );
              },
            ),
          ],
        )
    );
  }
}

