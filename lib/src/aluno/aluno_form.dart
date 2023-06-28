import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/aluno/aluno_page.dart';
import 'package:gerenciador_turma/src/aluno/entity_aluno.dart';
import 'package:gerenciador_turma/src/database/database_helper_aluno.dart';

class AlunoForm extends StatefulWidget {
  final Aluno? alunoEdit;

  AlunoForm({Key? key, this.alunoEdit}) : super(key: key);

  @override
  _AlunoFormState createState() => _AlunoFormState();
}

class _AlunoFormState extends State<AlunoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String nome = '';
  late String curso = '';
  final dbHelper = DatabaseHelperAluno.instance;

  @override
  void initState() {
    super.initState();
    if (widget.alunoEdit != null) {
      nome = widget.alunoEdit!.nome_aluno!;
      curso = widget.alunoEdit!.curso;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Aluno'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: _buildFormUI(),
          ),
        ),
      ),
    );
  }

  Widget _buildFormUI() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 100,
        ),
        TextFormField(
          initialValue: nome,
          decoration: const InputDecoration(hintText: 'Nome'),
          maxLength: 100,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira um nome válido.';
            }
            return null;
          },
          onSaved: (value) {
            nome = value!;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          initialValue: curso,
          decoration: const InputDecoration(hintText: 'Curso'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira um curso válido.';
            }
            return null;
          },
          onSaved: (value) {
            curso = value!;
          },
        ),
        const SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () {
            _submitForm();
          },
          child: const Text('Cadastrar'),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: _clearForm,
          child: const Text('Limpar'),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Aluno aluno = Aluno(nome_aluno: nome, curso: curso);

      if (widget.alunoEdit != null) {
        aluno.cod_aluno = widget.alunoEdit!.cod_aluno;
      }

      await dbHelper.salvar(aluno);

      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AlunoPage()),
      );
    }
  }

  void _clearForm() {
    _formKey.currentState!.reset();
  }
}
