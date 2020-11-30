import 'package:emergencyfeedback/providers/MainPageViewModel.dart';
import 'package:emergencyfeedback/services/firebase-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<String>> _showMyDialog() async {
      String _passcode = "";
      String _name = "";
      String _contact = "";
      return showDialog<List<String>>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Emergency Contact!!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  // Text('Do you want to add a Family member?'),
                  Text(
                      'Enter your 4 digit passcode then their name and contact'),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Passcode',
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.lock),
                        )),
                    validator: (val) =>
                        val.length < 6 ? 'Password too short.' : null,
                    onSaved: (val) => _passcode = val,
                    obscureText: true,
                    onChanged: (val) => _passcode = val,
                  ),
                  TextFormField(
                    // keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Name To add',
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.person),
                        )),
                    validator: (val) =>
                        val.length < 6 ? 'Password too short.' : null,
                    onChanged: (val) => _name = val,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Contact No. to add',
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.call),
                        )),
                    validator: (val) =>
                        val.length < 6 ? 'Password too short.' : null,
                    onChanged: (val) => _contact = val,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  // context.read<MainPageProvider>();
                  // print(_password);
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Add Person'),
                onPressed: () {
                  // context.read<MainPageProvider>();
                  // print(_password);
                  Navigator.pop(context, [_passcode, _name, _contact]);
                },
              ),
            ],
          );
        },
      );
    }

    Future<List<String>> _showMyDialog1() async {
      String _password1 = "";
      String _password2 = "";

      return showDialog<List<String>>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Changing pin'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Do you want to chnange passcode?'),
                  Text('Enter your 4 digit old passcode then enter new one'),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Old Passcode',
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.lock),
                        )),
                    validator: (val) =>
                        val.length < 6 ? 'Password too short.' : null,
                    onSaved: (val) => _password1 = val,
                    obscureText: true,
                    onChanged: (val) => _password1 = val,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'New Passcode',
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.lock),
                        )),
                    validator: (val) =>
                        val.length < 6 ? 'Password too short.' : null,
                    onSaved: (val) => _password2 = val,
                    obscureText: true,
                    onChanged: (val) => _password2 = val,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Replace old pin!'),
                onPressed: () {
                  // context.read<MainPageProvider>();
                  // print(_password);
                  Navigator.pop(context, [_password1, _password2]);
                },
              ),
            ],
          );
        },
      );
    }

    MainPageProvider model = context.watch<MainPageProvider>();
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("Settings"),
      // ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    height: 200,
                    // color: Colors.red,
                    child: Center(
                      child: Icon(
                        Icons.supervised_user_circle_rounded,
                        size: 200,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Center(
                      child: Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Name : " + model.user['name'],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Contact : " + model.user['contact'],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Family-Contacts: ",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    child: StreamBuilder(
                                      stream: userRef
                                          .doc(model.user['userID'])
                                          .snapshots(),
                                      // initialData: initialData ,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        return Container(
                                          child: ListView.separated(
                                            separatorBuilder:
                                                (context, index) => Divider(),
                                            itemCount: snapshot
                                                .data['emergency-contacts']
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              List data = snapshot
                                                  .data['emergency-contacts'];
                                              return Text(
                                                data[index]['name'].toString() +
                                                    " : " +
                                                    data[index]['contact']
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  FlatButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () async {
                                      List<String> p = await _showMyDialog();
                                      print(p);
                                      context
                                          .read<MainPageProvider>()
                                          .showInSnackBar1(
                                              p[0],
                                              "Family member added as emergency contact",
                                              "Passcode is wrong! Try Again",
                                              p,
                                              context);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Add Person",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        List p = await _showMyDialog1();
                        context.read<MainPageProvider>().showInSnackBar2(
                            p[0],
                            "New PassCode is added",
                            "Passcode is wrong! Try Again",
                            p,
                            context);
                      },
                      child: Text(
                        "Change Pin",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
