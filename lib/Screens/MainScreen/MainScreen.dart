import 'package:emergencyfeedback/Screens/EmergencyScreen/EmergencyScreen.dart';
import 'package:emergencyfeedback/Screens/HistoryScreen/historyScreen.dart';
import 'package:emergencyfeedback/Screens/ServiceScreen/serviceScreen.dart';
import 'package:emergencyfeedback/Screens/Welcome/welcome_screen.dart';
import 'package:emergencyfeedback/Screens/settings/settings.dart';
import 'package:emergencyfeedback/providers/MainPageViewModel.dart';
import 'package:emergencyfeedback/services/firebase-service.dart';
import 'package:flutter/material.dart';
import 'package:emergencyfeedback/providers/MainPageViewModel.dart';
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

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    context.read<MainPageProvider>().getCurrentUser();
    context.read<MainPageProvider>().getServices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainPageProvider model = context.watch<MainPageProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Emergency Services App',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          // IconButton(
          //   color: Theme.of(context).primaryColor,
          //   icon: Icon(Icons.account_circle),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (BuildContext context) => SettingsP()),
          //     // ModalRoute.withName('/'),
          //   ),
          // ),
          IconButton(
            color: Theme.of(context).primaryColor,

            icon: Icon(Icons.logout),
            onPressed: () async {
              signOutUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => WelcomeScreen()),
                // ModalRoute.withName('/'),
              );
            },
            // child: Text("Signout"),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
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
          Settings(),
        ],
        index: model.currentIndex,
      ),
    );
  }
}
