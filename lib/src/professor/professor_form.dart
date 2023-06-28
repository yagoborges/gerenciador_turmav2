import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/aluno/aluno_page.dart';
import 'package:gerenciador_turma/src/aluno/entity_aluno.dart';

import 'package:gerenciador_turma/src/database/database_helper_aluno.dart';
import 'package:gerenciador_turma/src/professor/entity_professor.dart';
import 'package:gerenciador_turma/src/professor/professor_page.dart';

class ProfessorForm extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey();
  final bool _validate = false;
  late String nome;
  final dbHelper = DatabaseHelperAluno.instance;
  Professor? professor;

  ProfessorForm({super.key});

  @override
  Widget build(BuildContext context) {
    //var _back = LoginBack(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Aluno'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Form(
            key: _key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // child: _formUI(context, _back),
            child: _formUI(context),
          ),
        ),
      ),
    );
  }

  //Widget _formUI(BuildContext context, LoginBack _back) {
  Widget _formUI(BuildContext context) {
    var loginController = TextEditingController();
    var loginController2 = TextEditingController();

    if (ModalRoute.of(context)!.settings.arguments != null) {
      professor = ModalRoute.of(context)!.settings.arguments as Professor;
    }

    if (professor == null) {
      print('aluno nulo');
    } else {
      //_loginController.text = _back.usuario.email!;
      // _loginController2.text = _back.usuario.password!;
    }

    return Column(
      children: <Widget>[
        const SizedBox(
          height: 100,
        ),
        TextFormField(
          controller: loginController,
          decoration: const InputDecoration(hintText: 'Nome'),
          maxLength: 100,
          //validator: _validarEmail,
          onSaved: (String? val) {
            nome = val!;
            //(newValue) => _back.contato.nome = newValue;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        const SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () async {
            var teste = await _sendForm();
            if (teste == true) {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfessorPage()));
            }
          },
          child: const Text('Cadastrar'),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () {
              loginController.clear();
              loginController2.clear();
            },
            child: const Text('Limpar'))
      ],
    );
  }

//TO DO: login enviar para o back
//conferir como usar o jwt
  //_sendForm(BuildContext context) async{
  Future<bool> _sendForm() async {
    if (_key.currentState!.validate()) {
      // Sem erros na validação
      _key.currentState!.save();

      Professor professorBanco =
          Professor(cod_prof: professor?.cod_prof, nome_prof: nome);

      var response = await dbHelper.salvar(professorBanco);

      return true;
    } else {
      //  _validate = true;
      print('erro de validação');
      return false;
    }
  }
}
