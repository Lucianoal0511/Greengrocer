import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //E-mail
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.email,
            icon: Icons.email,
            label: 'E-mail',
          ),
          //Nome
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.name,
            icon: Icons.person,
            label: 'Nome',
          ),
          //Celular
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.phone,
            icon: Icons.phone,
            label: 'Celular',
          ),
          //CPF
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
          ),
          //Botão para atualizar a senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text('Atualizar Senha'),
            ),
          ),
        ],
      ),
    );
  }

  //Criando uma função para o Alert Dialog
  Future<bool?> updatePassword() {
    final currentPasswordController = TextEditingController();
    final newPasswordController =
        TextEditingController(); // Criando um controller
    final _formKey = GlobalKey<FormState>(); // Criando uma chave global

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Título
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Atualização de Senha',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Senha Atual
                        CustomTextField(
                          controller: currentPasswordController,
                          isSecret: true,
                          icon: Icons.lock,
                          label: 'Senha Atual',
                          validator: passwordValidator,
                        ),
                        //Nova Senha
                        CustomTextField(
                          controller: newPasswordController,
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: 'Nova Senha',
                          validator: passwordValidator,
                        ),
                        //Confirmação da Nova Senha
                        CustomTextField(
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: 'Confirmar Nova Senha',
                          validator: (password) {
                            final result = passwordValidator(password);

                            if (result != null) {
                              return result;
                            }

                            if (password != newPasswordController.text) {
                              return 'As senhas não são equivalentes';
                            }

                            return null;
                          },
                        ),
                        //Botão de Confirmação
                        SizedBox(
                          height: 45,
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        authController.changePassword(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                        );
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text('Atualizar'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
