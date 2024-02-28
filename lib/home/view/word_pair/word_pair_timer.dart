//
import 'dart:async';

import '/src/view.dart';

import 'package:english_words/english_words.dart';

class WordPairs extends StatelessWidget {
  /// Only one instance of the class is necessary and desired.
  WordPairs({
    super.key,
    int? seconds,
    required this.state,
  }) : _timer = _WordPairsTimer(
            seconds: seconds,
            // ignore: INVALID_USE_OF_PROTECTED_MEMBER
            callback: () => state.setState(() {}));

  /// This State has a built-in InheritedWidget
  final InheritedWidgetStateMixin state;

  final _WordPairsTimer _timer;

  // Turn on the timer when necessary.
  void activate() => _timer.activate();

  // Turn off the timer if the Stat object is closed.
  void deactivate() => _timer.deactivate();

  @override
  Widget build(BuildContext context) {
    // This widget is rebuilt if the InheritedWidget is called again and again
    state.dependOnInheritedWidget(context);
    return Text(
      _timer.wordPair,
      style: TextStyle(
        color: Colors.red,
        fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
      ),
    );
  }
}

class _WordPairsTimer {
  _WordPairsTimer({
    this.seconds,
    this.callback,
  }) {
    // Initialize the Timer
    _initTimer();
  }

  /// Number of seconds between intervals set by the timer
  final int? seconds;

  /// Called at every interval set by the timer
  final void Function()? callback;

  /// The built-in timer
  Timer? timer;

  // Contains the word-pairs
  final suggestions = <WordPair>[];

  // Retrieve word pair from List
  int index = 0;

  /// Supply the word pair
  String get wordPair => _wordPair;
  String _wordPair = '';

  /// Supply a word pair
  void _getWordPair() {
    //
    try {
      //
      final WordPair twoWords = _generateWordPair();

      /// Alternate approach uses inheritWidget() and setStatesInherited() functions.
      _wordPair = twoWords.asString;
    } catch (ex) {
      /// Stop the timer.
      /// Something is not working. Don't have the timer repeat it over and over.
      timer?.cancel();

      // Rethrow the error so to get processed by the App's error handler.
      rethrow;
    }
  }

  /// Supply a set of word pairs
  /// Generate a certain number of word pairs
  /// and when those are used, generate another set.
  WordPair _generateWordPair() {
    index++;
    if (index >= suggestions.length) {
      index = 0;
      suggestions.clear();
      suggestions.addAll(generateWordPairs().take(100));
    }
    return suggestions[index];
  }

  // initialize the Timer
  void _initTimer() =>
      timer = Timer.periodic(Duration(seconds: seconds ?? 5), (timer) {
        callback?.call();
        _getWordPair();
      });

  /// May need to initialize again
  void activate() => _initTimer();

  /// Cancel the timer.
  void deactivate() {
    timer?.cancel();
    timer = null;
  }
}
