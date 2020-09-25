import 'dart:async';

import 'package:flutter_unit_test_acazia/api/api.dart';
import 'package:flutter_unit_test_acazia/models/model_user.dart';
import 'package:flutter_unit_test_acazia/state/state_user.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

class BlocUser extends BlocBase {

  BlocUser() {
    //_nextPageController.stream.listen(fetchNextPage);
    init();
  }

  UserPopulated userPopulated = UserPopulated([]);
  var _streamController = BehaviorSubject<UserState>();

  void init() {
    print('Initialising bloc');
    fetchNextPage();
  }

  fetchNextPage([event]) {
    _streamController.addStream(fetchUserFromAPI());
  }

  Stream<UserState> get stream {
    if (_streamController.isClosed) {
      print('Stream closed, resetting it');
      _streamController = BehaviorSubject<UserState>();
    }
    return _streamController.stream;
  }

  final _nextPageController = StreamController();
  Sink get nextPage => _nextPageController.sink;


  Stream<UserState> fetchUserFromAPI() async* {
    if (_hasNoExistingData()) {
      yield UserLoading();
    }
    try {
      final result = await getApiCall();
      if (result.isEmpty && _hasNoExistingData()) {
        yield UserEmpty();
      } else {
        yield userPopulated.update(newListUser: result.results);
      }
    } catch (e) {
      print('Error $e');
      yield UserError(e.toString());
    }
  }

  bool _hasNoExistingData() => userPopulated.listUser?.isEmpty ?? true;

  Future<ListUser> getApiCall() async {
    Future<ListUser> apiCall = API.instance.getDataUser();
    return apiCall;
  }

  @override
  void dispose() {
    print("close streamController");
    _streamController.close();
  }
}


void main() {
  BlocUser().getApiCall().then((listUser) {
    listUser.results.forEach((element) {print(element.email);});
  });
}