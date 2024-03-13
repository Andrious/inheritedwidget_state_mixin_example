import '/src/view.dart';

///
class Controller {
  ///
  Controller([State? state]) {
    _state = state;
  }

  /// State object associated with this Controller object.
  State? get state => _state;
  State? _state;

  /// Used to complete asynchronous operations
  Future<bool> initAsync() async => true;

  /// Call the associated State object to rebuild
  // ignore: INVALID_USE_OF_PROTECTED_MEMBER
  void setState(VoidCallback fn) => _state?.setState(fn);
}
