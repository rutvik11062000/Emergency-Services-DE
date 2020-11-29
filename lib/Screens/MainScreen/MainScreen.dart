import 'package:emergencyfeedback/Screens/EmergencyScreen/EmergencyScreen.dart';
import 'package:emergencyfeedback/Screens/HistoryScreen/historyScreen.dart';
import 'package:emergencyfeedback/Screens/ServiceScreen/serviceScreen.dart';
import 'package:emergencyfeedback/Screens/Welcome/welcome_screen.dart';
import 'package:emergencyfeedback/Screens/settings/settings.dart';
import 'package:emergencyfeedback/providers/MainPageViewModel.dart';
import 'package:emergencyfeedback/services/firebase-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MainPageProvider currentIndex = context.watch<MainPageProvider>();
    return ChangeNotifierProvider(
      create: (_) => MainPageProvider(),
      child: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainPageProvider model = context.watch<MainPageProvider>();
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Main Page'),
        actions: [
          FlatButton(
            onPressed: () async {
              signOutUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => WelcomeScreen()),
                // ModalRoute.withName('/'),
              );
            },
            child: Text("Signout"),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Settings()),
              // ModalRoute.withName('/'),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_open_outlined),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.point_of_sale_rounded),
            label: 'history',
          ),
        ],
        currentIndex: model.currentIndex,
        selectedItemColor: Color(0xFF6F35A5),
        onTap: model.updateIndex,
      ),
      body: IndexedStack(
        children: [
          EmergencyScreen(),
          ServiceScreen(),
          HistoryScreen(),
        ],
        index: model.currentIndex,
      ),
    );
  }
}
