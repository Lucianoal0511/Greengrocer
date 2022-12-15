import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_errors.dart'
    as authErrors;
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  //Método de validação do token
  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.sucess(user);
    } else {
      return AuthResult.error(authErrors.authErrorsString(result['error']));
    }
  }

  //Método de validação do email e senha
  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.signin,
        method: HttpMethods.post,
        body: {"email": email, "password": password});

    if (result['result'] != null) {
      // print('Signin funcionou!');
      // print(result['result']);

      final user = UserModel.fromJson(result['result']);
      return AuthResult.sucess(user);
      // print(user);

    } else {
      return AuthResult.error(authErrors.authErrorsString(result['error']));
      // print('Signin não funcionou!');
      // print(result['error']);
    }
  }
}
