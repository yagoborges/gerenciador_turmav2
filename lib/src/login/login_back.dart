import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/usuario/usuario.dart';

class LoginBack {
  late Usuario usuario;

  LoginBack(BuildContext context) {
    var parameter = ModalRoute.of(context)?.settings.arguments;
    if ((parameter == null)) {
      usuario = Usuario();
    } else {
      usuario = parameter as Usuario;
    }
  }
}
