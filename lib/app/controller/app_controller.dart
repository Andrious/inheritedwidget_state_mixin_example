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
  //ignore: invalid_use_of_private_members
  void setState(VoidCallback fn) => state?.setState(fn);
}
