import 'package:get/get.dart';
import 'package:saikai/model/profile.dart';
import 'package:saikai/presentation/screens/pagecontainer.dart';
import 'package:saikai/service/network_service.dart';
import 'package:saikai/service/spref_service.dart';
import 'dart:async';

class AuthController extends GetxController {
  RxBool _isLogin = false.obs;
  RxBool _isLoginSuccess = false.obs;
  RxBool _isLoginLoading = false.obs;
  RxBool _isRegisterLoading = false.obs;
  RxString _email = RxString();
  RxInt _idUser = RxInt();
  Rx<Profile> _profile = Rx<Profile>();
  final SPrefService _sPrefService = SPrefService();
  final NetworkService _networkService = NetworkService();
  //create function to get property
  Rx<Profile> get profile => _profile;
  RxBool get loginStatus => _isLogin;
  RxBool get isLoginLoading => _isLoginLoading;
  RxBool get isLoginSuccess => _isLoginSuccess;
  RxBool get isRegisterLoading => _isRegisterLoading;
  get email => _email;
  get uid => _idUser;
  @override
  void onInit() {
    loadAuthentication();
    super.onInit();
  }

  loadAuthentication() async {
    bool _loginStat = await _sPrefService.getLoginStatus();
    _isLogin.value = _loginStat;
    if (_loginStat) {
      Map _data = await _sPrefService.getLoginDetails();
      print(
        _data['email'],
      );
      try {
        _email.value = _data['email'].toString();
        _idUser.value = _data['idUser'];
        _profile.value = await _networkService.getProfile(_idUser.value);
      } catch (e) {
        printError(
          info: e.toString(),
        );
      }
    } else {
      _email.value = 'none';
      _idUser.value = -1;
      _profile.value = Profile();
    }
  }

  Future login(String email, String password) async {
    _isLoginLoading.value = true;
    var result;
    try {
      result = await _networkService.login(email, password);
    } catch (e) {
      printError(
        info: e.toString(),
      );
    }
    if (result['result'] ?? false) {
      _isLoginSuccess.value = true;
      _sPrefService.saveLoginDetails(
        email,
        int.tryParse(
          result['data']['id_user'],
        ),
      );
    }
    Timer(
      Duration(seconds: 1),
      () {
        loadAuthentication();
        _isLoginSuccess.value = false;
      },
    );
    Get.showSnackbar(
      GetBar(
        duration: Duration(seconds: 2),
        message:
            result['result'] ?? false ? "Login success" : "Login not success",
      ),
    );
    _isLoginLoading.value = false;
  }

  Future register(String email, String password) async {
    _isRegisterLoading.value = true;
    var result;
    try {
      result = await _networkService.register(email, password);
      if (result != null) {
        if (result['result'] ?? false) {
          Timer(
            Duration(milliseconds: 1),
            () {
              Get.offAll(
                PageContainer(),
              );
            },
          );
        }

        Get.showSnackbar(
          GetBar(
            duration: Duration(seconds: 2),
            message: result['message'],
          ),
        );
      }
    } catch (e) {
      printError(
        info: e.toString(),
      );
    }

    _isRegisterLoading.value = false;
  }

  logOut() async {
    
    _sPrefService.removeLoginDetails().then(
          (value) => loadAuthentication(),
        );
        
        
  }
}
