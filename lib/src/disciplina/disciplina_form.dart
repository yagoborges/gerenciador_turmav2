import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/database/database_helper_disc.dart';
import 'package:gerenciador_turma/src/disciplina/disciplina_page.dart';
import 'package:gerenciador_turma/src/disciplina/entity_disciplina.dart';
import 'package:gerenciador_turma/src/professor/entity_professor.dart';

class DisciplinaForm extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey();
  final bool _validate = false;
  late String nome;
  final dbHelper = DatabaseHelperDisc.instance;
  Disciplina? disciplina;
  Professor? professor;

  DisciplinaForm({super.key});

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      disciplina = ModalRoute.of(context)!.settings.arguments as Disciplina;
      professor = ModalRoute.of(context)!.settings.arguments as Professor;
    }
    //var _back = LoginBack(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Disciplina'),
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
    var disciplinaController = TextEditingController();
    var professorController = TextEditingController();

    if (ModalRoute.of(context)!.settings.arguments != null) {
      disciplina = ModalRoute.of(context)!.settings.arguments as Disciplina;
      professor = ModalRoute.of(context)!.settings.arguments as Professor;
    }

    if (disciplina == null) {
      print('disciplina nula');
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
          decoration: const InputDecoration(hintText: 'Nome Disciplina'),
          maxLength: 100,
          onSaved: (String? val) {
            nome = val!;
          },
          initialValue: disciplina?.nome_disc,
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          //controller: cursoController,
          decoration: const InputDecoration(hintText: 'Curso'),
          onSaved: (String? val) {
            //curso = val!;
          },
          initialValue: professor?.cod_prof,
        ),
        const SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () async {
            var teste = await _sendForm();
            if (teste == true) {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DisciplinaPage()));
            }
          },
          child: const Text('Cadastrar'),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () {
              disciplinaController.clear();
              professorController.clear();
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

      Disciplina disciplinaBanco = Disciplina(
          cod_disc: disciplina?.cod_disc,
          nome_disc: nome,
          fk_cod_prof: professor
              ?.cod_prof); //tem que colocar esse campo professor.cod_prof

      var response = await dbHelper.salvar(disciplinaBanco);

      return true;
    } else {
      //  _validate = true;
      print('erro de validação');
      return false;
    }
  }
}
