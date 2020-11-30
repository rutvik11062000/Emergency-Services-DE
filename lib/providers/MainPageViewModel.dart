import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:emergencyfeedback/services/firebase-service.dart';
import 'package:flutter/material.dart';

class MainPageProvider extends ChangeNotifier {
  Map<String, dynamic> _user = {};
  Map<String, dynamic> get user => _user;
  Map<String, dynamic> _services = {};
  Map<String, dynamic> get services => _services;
  List<Color> _colors = [
    Colors.cyan[100],
    Colors.green[100],
    Colors.indigo[100],
    Colors.teal[100],
    Colors.lightGreen[100],
    Colors.lightBlue[100],
  ];

  List<Color> get colors => _colors;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid;
    _user = await userRef.doc(uid).get().then((value) => value.data());
    print(_user);
    notifyListeners();
  }

  void getServices() async {
    _services = await db
        .collection('services')
        .doc('emergency-services')
        .get()
        .then((value) => value.data());
    notifyListeners();
  }

  void showInSnackBar(
      String value, String sucess, String failure, BuildContext context) {
    // print(user);
    bool b = false;
    if (value == _user['passcode']) {
      value = sucess;
      b = true;
    } else {
      value = failure;
    }

    Scaffold.of(context).showSnackBar(
      new SnackBar(
          content: new Text(value),
          backgroundColor: b ? Colors.green : Colors.redAccent),
    );
  }

  void showInSnackBar1(String value, String sucess, String failure,
      List<String> p, BuildContext context) {
    // print(user);
    bool b = false;
    if (value == _user['passcode']) {
      value = sucess;
      addFamilyMember(p[1], p[2], _user['userID'], _user['emergency-contacts']);
      b = true;
    } else {
      value = failure;
    }

    Scaffold.of(context).showSnackBar(
      new SnackBar(
          content: new Text(value),
          backgroundColor: b ? Colors.green : Colors.redAccent),
    );
  }

  void showInSnackBar2(String value, String sucess, String failure,
      List<String> p, BuildContext context) async {
    // print(user);
    bool b = false;
    if (value == _user['passcode']) {
      value = sucess;
      addNewPasscode(_user['passcode'], p[1], _user['userID']);
      await getCurrentUser();
      b = true;
    } else {
      value = failure;
    }

    Scaffold.of(context).showSnackBar(
      new SnackBar(
          content: new Text(value),
          backgroundColor: b ? Colors.green : Colors.redAccent),
    );
  }
}
