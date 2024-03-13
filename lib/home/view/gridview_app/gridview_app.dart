//
import 'package:flutter/material.dart';

import '/src/controller.dart';

import '/src/view.dart';

///
class GridPage extends StatefulWidget {
  ///
  const GridPage({super.key});
  @override
  State createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  void initState() {
    super.initState();
    con = HomeController(this);
  }

  late HomeController con;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('InheritedWidget Example App'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: InheritBird(
          child: InheritCat(
            child: InheritDog(
              child: InheritFox(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: con.children,
                ),
              ),
            ),
          ),
        ),
        persistentFooterButtons: [
          OverflowBar(
            children: [
              TextButton(
                onPressed: () => con.newDogs(),
                child: const Text('New Dogs'),
              ),
              TextButton(
                onPressed: () => con.newCats(),
                child: const Text('New Cats'),
              ),
              TextButton(
                onPressed: () => con.newFoxes(),
                child: const Text('New Foxes'),
              ),
              TextButton(
                onPressed: () => con.newBirds(),
                child: const Text('New Birds'),
              ),
            ],
          ),
        ],
      );
}
