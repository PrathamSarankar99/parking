import 'package:flutter/material.dart';
import 'package:parking/screens/homescreens/hometabs/about_us_tab.dart';
import 'package:parking/screens/homescreens/hometabs/my_vehicles_tab.dart';
import 'package:parking/screens/profilescreens/edit_profile.dart';
import 'package:parking/screens/homescreens/hometabs/find_parking_tab.dart';
import 'package:parking/screens/homescreens/hometabs/my_wallet.dart';
import 'package:parking/screens/homescreens/hometabs/notification_tab.dart';
import 'package:parking/screens/homescreens/hometabs/parking_history_tab.dart';
import 'package:parking/screens/homescreens/hometabs/home_tab.dart';
import 'package:parking/screens/homescreens/hometabs/offer_tab.dart';
import 'package:parking/screens/homescreens/hometabs/profile_tab.dart';
import 'package:parking/screens/homescreens/hometabs/settings_tab.dart';
import 'package:parking/screens/homescreens/hometabs/support_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs;
  int currentIndex;
  @override
  void initState() {
    currentIndex = 0;
    tabs = [
      HomeTab(
        changeTab: changeTab,
      ),
      ProfileTab(
        changeTab: changeTab,
      ),
      FindParkingTab(
        changeTab: changeTab,
      ),
      ParkingHistoryTab(
        changeTab: changeTab,
      ),
      MyWallet(
        changeTab: changeTab,
      ),
      OfferTab(
        changeTab: changeTab,
      ),
      NotificationTab(
        changeTab: changeTab,
      ),
      SettingsTab(
        changeTab: changeTab,
      ),
      AboutUsTab(
        changeTab: changeTab,
      ),
      SupportTab(
        changeTab: changeTab,
      ),
      MyVehiclesTab(
        changeTab: changeTab,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      children: tabs,
      index: currentIndex,
    );
  }

  changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
