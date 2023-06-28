import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/aluno/entity_aluno.dart';
import 'package:gerenciador_turma/src/database/database_helper_aluno.dart';
import 'package:gerenciador_turma/src/shared/app_scaffold.dart';

class AlunoPage extends StatelessWidget {
  AlunoPage({Key? key}) : super(key: key);
  final dBHelper = DatabaseHelperAluno.instance;
  late Aluno alunoSel;
  Future<List<Aluno>> criaLista() async {
    return await dBHelper.buscar();
  }

  void _editarAluno(BuildContext context, Aluno aluno) {
    Navigator.of(context).pushNamed('/aluno_form', arguments: aluno);
  }

  void _excluirAluno(BuildContext context, dynamic id) async {
    await dBHelper.excluir(id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AlunoPage()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Aluno>>(
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
          List<Aluno> listaAlunos = snapshot.data!;

          return AppScaffold(
            pageTitle: const Text('Alunos'),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed('/aluno_form');
              },
              child: const Icon(Icons.add),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listaAlunos.length,
              itemBuilder: (context, i) {
                var aluno = listaAlunos[i];
                return ListTile(
                  title: Text(aluno.nome_aluno.toString()),
                  subtitle: Text("Curso: ${aluno.curso}"),
                  trailing: Container(
                    width: 100,
                    child: Row(children: [
                      IconButton(
                        onPressed: () {
                          _editarAluno(context, aluno);
                          print(
                              'Código do aluno Selecionado: ${aluno.cod_aluno}');
                          print('Aluno Selecionado: ${aluno.nome_aluno}');
                          print('Curso do aluno Selecionado: ${aluno.curso}');
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.orange,
                      ),
                      IconButton(
                        onPressed: () {
                          _excluirAluno(context, aluno.cod_aluno);
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
