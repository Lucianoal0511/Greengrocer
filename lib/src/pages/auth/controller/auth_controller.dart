import 'package:get/get.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    // await Future.delayed(const Duration(seconds: 2));
    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      sucess: (user) {
        this.user = user;

        //Get para para passar para a tela de dentro do app
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
