import 'package:avengers/core/enums/viewstate.dart';
import 'package:avengers/core/models/avenger.dart';
import 'package:avengers/core/services/avenger_service.dart';
import 'package:avengers/core/viewmodels/base_model.dart';
import 'package:avengers/locator.dart';

class HomeModel extends BaseModel {
  final AvengerService _avengerService = locator<AvengerService>();

  List<Avenger> avengers;
  Avenger selectedAvenger;

  String errorMessage;

  Future getAvengers() async {
    setState(ViewState.Busy);

    avengers = await _avengerService.getAll();
    selectedAvenger = avengers[0];
    // Handle potential error here.
    // errorMessage = 'some error';

    setState(ViewState.Idle);
  }

  selectAvenger(Avenger avenger) {
    selectedAvenger = avenger;
    notifyListeners();
  }
}