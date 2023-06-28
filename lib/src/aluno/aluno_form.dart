import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/aluno/aluno_page.dart';
import 'package:gerenciador_turma/src/aluno/entity_aluno.dart';

import 'package:gerenciador_turma/src/database/database_helper_aluno.dart';

class AlunoForm extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey();
  final bool _validate = false;
  late String nome, curso;
  final dbHelper = DatabaseHelperAluno.instance;
  Aluno? aluno;

  AlunoForm({super.key});

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      aluno = ModalRoute.of(context)!.settings.arguments as Aluno;
    }
    //var _back = LoginBack(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Aluno'),
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
    var nomeController = TextEditingController();
    var cursoController = TextEditingController();

    if (ModalRoute.of(context)!.settings.arguments != null) {
      aluno = ModalRoute.of(context)!.settings.arguments as Aluno;
    }

    if (aluno == null) {
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
          //controller: nomeController,
          decoration: const InputDecoration(hintText: 'Nome'),
          maxLength: 100,
          onSaved: (String? val) {
            nome = val!;
          },
          initialValue: aluno?.nome_aluno,
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          //controller: cursoController,
          decoration: const InputDecoration(hintText: 'Curso'),
          onSaved: (String? val) {
            curso = val!;
          },
          initialValue: aluno?.curso,
        ),
        const SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () async {
            var teste = await _sendForm();
            if (teste == true) {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AlunoPage()));
            }
          },
          child: const Text('Cadastrar'),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () {
              nomeController.clear();
              cursoController.clear();
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

      Aluno alunoBanco =
          Aluno(cod_aluno: aluno?.cod_aluno, nome_aluno: nome, curso: curso);

      var response = await dbHelper.salvar(alunoBanco);

      return true;
    } else {
      //  _validate = true;
      print('erro de validação');
      return false;
    }
  }
}
