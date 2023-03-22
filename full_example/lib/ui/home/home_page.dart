import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_bg_location/simple_bg_location.dart';
import 'package:simple_bg_location_example/constants.dart';
import 'package:simple_bg_location_example/ui/other_apis/other_apis_page.dart';
import '../../cubit/settings/settings_cubit.dart';
import '../widgets/bottom_bar.dart';
import 'views/views.dart';

enum _Menu {
  best,
  good,
  balance,
  lowest,
  otherApi,
  forceLocationManager,
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key) {
    SimpleBgLocation.onNotificationAction(_onNotificationAction);
  }

  static String pageNme = "OtherApisPage";

  final List<Tab> tabs = const <Tab>[
    Tab(
      icon: Icon(Icons.map),
    ),
    Tab(
      icon: Icon(Icons.list_alt),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          actions: [
            IconButton(
                icon: const Icon(Icons.door_back_door), onPressed: () {}),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return PopupMenuButton<_Menu>(
                  onSelected: (value) {
                    switch (value) {
                      case _Menu.best:
                        BlocProvider.of<SettingsCubit>(context)
                            .setCustomerAccuracy(CustomAccuracy.best);
                        break;
                      case _Menu.good:
                        BlocProvider.of<SettingsCubit>(context)
                            .setCustomerAccuracy(CustomAccuracy.good);
                        break;
                      case _Menu.balance:
                        BlocProvider.of<SettingsCubit>(context)
                            .setCustomerAccuracy(CustomAccuracy.balance);
                        break;
                      case _Menu.lowest:
                        BlocProvider.of<SettingsCubit>(context)
                            .setCustomerAccuracy(CustomAccuracy.lowest);
                        break;
                      case _Menu.otherApi:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const OtherApisPage()));
                        break;
                      case _Menu.forceLocationManager:
                        context
                            .read<SettingsCubit>()
                            .toggleForceLocationManager();
                        break;
                    }
                  },
                  itemBuilder: (_) => <PopupMenuEntry<_Menu>>[
                    CheckedPopupMenuItem<_Menu>(
                      checked: state.accuracy == CustomAccuracy.best,
                      value: _Menu.best,
                      child: const Text('Best Accuracy'),
                    ),
                    CheckedPopupMenuItem<_Menu>(
                      checked: state.accuracy == CustomAccuracy.good,
                      value: _Menu.good,
                      child: const Text('Good Accuracy'),
                    ),
                    CheckedPopupMenuItem<_Menu>(
                      checked: state.accuracy == CustomAccuracy.balance,
                      value: _Menu.balance,
                      child: const Text('Balance Accuracy and Power'),
                    ),
                    CheckedPopupMenuItem<_Menu>(
                      checked: state.accuracy == CustomAccuracy.lowest,
                      value: _Menu.lowest,
                      child: const Text('Lowest Power'),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem<_Menu>(
                      value: _Menu.otherApi,
                      child: ListTile(
                        leading: Icon(Icons.api),
                        title: Text('Other Api...'),
                      ),
                    ),
                    const PopupMenuDivider(),
                    CheckedPopupMenuItem(
                        checked: state.forceLocationManager,
                        value: _Menu.forceLocationManager,
                        child: const Text('Force LocationManager')),
                  ],
                );
              },
            ),
          ],
          bottom: TabBar(tabs: tabs),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            MapView(),
            EventsView(),
          ],
        ),
        bottomNavigationBar: const MyBottomBar(),
      ),
    );
  }

  void _onNotificationAction(String action) {
    Fluttertoast.showToast(msg: 'Notification button($action) clicked.');
  }
}
