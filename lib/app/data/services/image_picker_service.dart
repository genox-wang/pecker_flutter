import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService extends GetxService {
  static ImagePickerService get to => Get.find();

  late final ImagePicker _picker;

  @override
  void onInit() {
    _picker = ImagePicker();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<PickedFile?> getImage(bool isCamera) {
    return _picker.getImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
  }
}
