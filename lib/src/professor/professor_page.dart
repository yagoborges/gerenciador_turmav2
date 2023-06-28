import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/database/database_helper_professor.dart';
import 'package:gerenciador_turma/src/professor/entity_professor.dart';
import 'package:gerenciador_turma/src/shared/app_scaffold.dart';

class ProfessorPage extends StatelessWidget {
  ProfessorPage({Key? key}) : super(key: key);
  final dBHelper = DatabaseHelperProfessor.instance;
  late Professor alunoSel;
  Future<List<Professor>> criaLista() async {
    return await dBHelper.buscar();
  }

  void _editarProfessor(BuildContext context, Professor professor) {
    Navigator.of(context).pushNamed('/aluno_form', arguments: professor);
  }

  void _excluirProfessor(BuildContext context, dynamic id) async {
    await dBHelper.excluir(id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfessorPage()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Professor>>(
      future: criaLista(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Exibir um indicador de carregamento enquanto os dados estão sendo buscados
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Exibir uma mensagem de erro caso ocorra algum erro durante a busca dos dados
          return Text('Erro: ${snapshot.error}');
        } else {
          // Os dados foram carregados com sucesso, podemos construir a interface
          List<Professor> listaProfessores = snapshot.data!;

          return AppScaffold(
            pageTitle: const Text('Professores'),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed('/professor_form');
              },
              child: const Icon(Icons.add),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listaProfessores.length,
              itemBuilder: (context, i) {
                var professor = listaProfessores[i];
                return ListTile(
                  title: Text(professor.nome_prof.toString()),
                  subtitle: Text("Código: ${professor.cod_prof}"),
                  trailing: Container(
                    width: 100,
                    child: Row(children: [
                      IconButton(
                        onPressed: () {
                          _editarProfessor(context, professor);
                          print(
                              'Código do prof Selecionado: ${professor.cod_prof}');
                          print(
                              'Professor Selecionado: ${professor.nome_prof}');
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.orange,
                      ),
                      IconButton(
                        onPressed: () {
                          _excluirProfessor(context, professor.cod_prof);
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ]),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
