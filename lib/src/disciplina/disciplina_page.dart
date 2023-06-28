import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/database/database_helper_disc.dart';
import 'package:gerenciador_turma/src/disciplina/entity_disciplina.dart';
import 'package:gerenciador_turma/src/professor/entity_professor.dart';
import 'package:gerenciador_turma/src/shared/app_scaffold.dart';

class DisciplinaPage extends StatelessWidget {
  DisciplinaPage({Key? key}) : super(key: key);
  final dBHelper = DatabaseHelperDisc.instance;
  late Disciplina disciplinaSel;
  var listaProfessores = <Professor>[];
  Future<List<Disciplina>> criaLista() async {
    return await dBHelper.buscar();
  }

  void _editarDisciplina(BuildContext context, Disciplina disciplina) {
    Navigator.of(context).pushNamed('/disciplina_form', arguments: disciplina);
  }

  void _excluirDisciplina(BuildContext context, dynamic id) async {
    await dBHelper.excluir(id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DisciplinaPage()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Disciplina>>(
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
          List<Disciplina> listaDisciplinas = snapshot.data!;

          return AppScaffold(
            pageTitle: const Text('Disciplinas'),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed('/disciplina_form');
              },
              child: const Icon(Icons.add),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listaDisciplinas.length,
              itemBuilder: (context, i) {
                var disciplina = listaDisciplinas[i];
                var professor = Professor(
                  cod_prof: disciplina.fk_cod_prof['cod_prof'],
                  nome_prof: disciplina.fk_cod_prof['nome_prof'],
                );
                listaProfessores.add(professor);
                //var professor = listaProfessores[i];
                return ListTile(
                  title: Text(disciplina.nome_disc.toString()),
                  subtitle: Text("Professor: ${professor.nome_prof}"),
                  trailing: Container(
                    width: 100,
                    child: Row(children: [
                      IconButton(
                        onPressed: () {
                          _editarDisciplina(context, disciplina);
                          print(
                              'Código da disciplina Selecionada: ${disciplina.cod_disc}');
                          print(
                              'Disciplina Selecionada: ${disciplina.nome_disc}');
                          print('Professor: ${disciplina.fk_cod_prof}');
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.orange,
                      ),
                      IconButton(
                        onPressed: () {
                          _excluirDisciplina(context, disciplina.cod_disc);
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
