//
import '/src/view.dart';

///
class FirstPage extends StatefulWidget {
  ///
  const FirstPage({super.key, required this.title});

  ///
  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with InheritedWidgetStateMixin {
  //
  int _counter = 0;

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

  /// Determine if the dependencies should be updated.
  /// Place a breakpoint here to watch the magic.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  /// Simply overridden for your to place a breakpoint and wathch
  /// how the InheritedWidget Mixin works.
  @override
  // ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);

  @override
  Widget buildIn(BuildContext context) {
    final theme = Theme.of(context);
    final homeState = context.findAncestorStateOfType<HomePageState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
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
            stateSet((_) {
              return Text('$_counter', style: theme.textTheme.headlineMedium);
            }),
            const SizedBox(height: 30),
            stateSet<HomePageState>((_) {
              final counter = homeState?.counter++;
              return Text('$counter', style: theme.textTheme.headlineMedium);
            }),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: FloatingActionButton(
                  heroTag:
                      null, // Fixes 'multiple heroes that share the same tag' error
                  onPressed: () => homeState?.setState(() {}),
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
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
