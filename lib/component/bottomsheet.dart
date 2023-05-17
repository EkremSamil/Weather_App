import 'package:weather_app/export.dart';

class BottomSheetProvider with ChangeNotifier {
  bool _isOpen = false;
  bool get isOpen => _isOpen;

  void openBottomSheet() {
    _isOpen = true;
    notifyListeners();
  }

  void closeBottomSheet() {
    _isOpen = false;
    notifyListeners();
  }
}
