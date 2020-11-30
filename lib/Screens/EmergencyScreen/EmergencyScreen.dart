import 'package:emergencyfeedback/providers/MainPageViewModel.dart';
import 'package:emergencyfeedback/services/firebase-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({Key key}) : super(key: key);

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
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
    List<dynamic> services =
        context.watch<MainPageProvider>().services['services'] ?? [];
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            List.generate(
                services.length == null ? 0 : services.length,
                (index) => Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        shadowColor: Colors.blueGrey,
                        child: buildContainer(services, index),
                      ),
                    )),
          ),
        ),
      ],
    );
  }

  Container buildContainer(List services, int index) {
    return Container(
      height: 150,
      width: 100,
      color: context.watch<MainPageProvider>().colors[index],
      child: Stack(
        children: [
          cardHeader(services, index),
          funtionButton(),
        ],
      ),
    );
  }

  Positioned funtionButton() {
    List<Map<String, dynamic>> services = [
      {
        "name": "National Emergency",
        "code": 112,
        "Color": Colors.cyan[100].toString()
      },
      {
        "name": "Police Service",
        "code": 100,
        "Color": Colors.green[100].toString()
      },
      {
        "name": "Fire Service",
        "code": 101,
        "Color": Colors.indigo[100].toString()
      },
      {
        "name": "Ambulance Service",
        "code": 102,
        "Color": Colors.teal[100].toString()
      },
      {
        "name": "Women-Help Service",
        "code": 1097,
        "Color": Colors.lightGreen[100].toString()
      },
      {
        "name": "Tourist-Help Service",
        "code": 1363,
        "Color": Colors.lightBlue[100].toString()
      },
    ];

    return Positioned(
      bottom: 10.0,
      right: 10.0,
      child: FlatButton(
        // color: Colors.blueGrey,
        onPressed: () async {
          String p = await _showMyDialog();
          // print(p);
          context.read<MainPageProvider>().showInSnackBar(
              p,
              "Key Matched! We're contacting emergency service",
              "Key doesnt match try again",
              context);
          // db
          //     .collection('services')
          //     .doc('emergency-services')
          //     .set({"services": services});
        },
        child: Text(
          "Help!!",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  Future<String> _showMyDialog() async {
    String _password = "";
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emergency!!?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Is there an emergency?'),
                Text('Enter your 4 digit passcode then!'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      icon: const Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.lock),
                      )),
                  validator: (val) =>
                      val.length < 6 ? 'Password too short.' : null,
                  onSaved: (val) => _password = val,
                  obscureText: true,
                  onChanged: (val) => _password = val,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Contact Now'),
              onPressed: () {
                // context.read<MainPageProvider>();
                // print(_password);
                Navigator.pop(context, _password);
              },
            ),
          ],
        );
      },
    );
  }

  Positioned cardHeader(List services, int index) {
    return Positioned(
      top: 10.0,
      left: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            services[index]['name'],
            style: TextStyle(
              fontSize: 36.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Code is :" + services[index]['code'].toString(),
            style:
                TextStyle(fontWeight: FontWeight.w800, color: Colors.blueGrey),
          )
        ],
      ),
    );
  }
}
