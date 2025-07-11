import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:get/get.dart';

class NotificationDataController extends GetxController {
  
  List _notification = [];
  String _errorMessage = "";
  bool _isLoading = true;

  List get notification => _notification;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  getNotifications() async {
    _isLoading = true;
    BaseResponse response = await ApiMethods.getNotifications();
    if (response is SuccessResponse) {
      _notification = response.data;
    } else if (response is ErrorResponse) {
      _errorMessage = response.message ?? "Something went wrong";
    }
    _isLoading = false;
    update();
  }
}
