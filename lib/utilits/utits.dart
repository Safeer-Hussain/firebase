import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void showToast(String? msg) {
    Fluttertoast.showToast(msg: msg!);
  }
}
