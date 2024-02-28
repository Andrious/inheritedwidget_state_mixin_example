//
import '/src/view.dart';

///
class MyHomePage extends StatefulWidget {
  ///
  const MyHomePage({super.key, required this.title});

  ///
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with InheritedWidgetStateMixin {
  //
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();

    /// With the mixin, setState() will not rebuild the whole interface again!
    wordPairsWidget = WordPairs(seconds: 3, state: this);
  }

  late WordPairs wordPairsWidget;

  /// Ensure to also 'deactivate' the word pairs package
  @override
  void deactivate() {
    wordPairsWidget.deactivate();
    super.deactivate();
  }

  @override
  Widget buildIn(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            wordPairsWidget,
            const Text(
              'You have pushed the button this many times:',
            ),
            stateSet(
              (context) {
                return Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () async {
            wordPairsWidget.deactivate(); // Turn off the Timer
            await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const GridPage(),
              ),
            );
            wordPairsWidget.activate();
          },
          child: const Text('GridView App'),
        ),
      ],
    );
  }
}
