import 'package:get/get.dart';

import '../../../utils/my_ui.dart';

class MyButtonController {
  final _isLoading = false.obs;
  get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  startLoading() {
    isLoading = true;
    MyUI.showLoading();
  }

  stopLoading() {
    isLoading = false;
    MyUI.hideLoading();
  }
}
