import 'package:blgym/exercise/pages/exercise_list_page.dart';
import 'package:blgym/shared/page/panel_page.dart';
import 'package:blgym/train/pages/train_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: <Widget>[
        const PanelPage(),
        const ExerciseListPage(),
        const TrainPage(),
      ][_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.accessibility),
            label: 'Exercises',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_alarm),
            label: 'Train',
          ),
        ],
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
