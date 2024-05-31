import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AlertApp {
  final showToast = FToast();
  int? milliseconds;
  AlertApp({
    this.milliseconds,
  }) {
    init();
  }

  ///
  /// Init toast.
  ///
  void init() {
    showToast.init(Get.context!);
  }
}
