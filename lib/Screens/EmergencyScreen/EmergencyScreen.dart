import 'package:flutter/material.dart';

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
    // ..addListener(() {
    //   context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
    // });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List services = [
      {"name": "Police Service", "code": 112, "Color": Colors.cyan[100]},
      {"name": "Police Service", "code": 112, "Color": Colors.green[100]},
      {"name": "Police Service", "code": 112, "Color": Colors.indigo[100]},
      {"name": "Police Service", "code": 112, "Color": Colors.teal[100]},
      {"name": "Police Service", "code": 112, "Color": Colors.lightGreen[100]},
      {"name": "Police Service", "code": 112, "Color": Colors.lightBlue[100]},
    ];
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            List.generate(
                services.length,
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
      color: services[index]['Color'],
      child: Stack(
        children: [
          cardHeader(services, index),
          funtionButton(),
        ],
      ),
    );
  }

  Positioned funtionButton() {
    return Positioned(
      bottom: 10.0,
      right: 10.0,
      child: FlatButton(
        // color: Colors.blueGrey,
        onPressed: () {},
        child: Text(
          "Help!!",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
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
