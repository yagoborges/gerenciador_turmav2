import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/shared/app_scaffold.dart';

class DisciplinaPage extends StatelessWidget {
  const DisciplinaPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final authService = Provider.of<AuthService>(context);
    final listaDisciplinas = [
      {
        'cod_disc': '1',
        'nome_disc': 'Educação Matemática',
        'nome_prof': 'Thiago Porto'
      },
      {
        'cod_disc': '2',
        'nome_disc': 'Desenvolvimento Mobile',
        'nome_prof': 'Laura Beatriz'
      },
      {
        'cod_disc': '3',
        'nome_disc': 'Análise de Sistemas',
        'nome_prof': 'Lacordaire Kermel Cury'
      },
    ];

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
          var disciplinas = listaDisciplinas[i];
          return ListTile(
            title: Text(disciplinas['nome_disc'].toString()),
            subtitle: Text("Professor(a): ${disciplinas['nome_prof']}"),
            trailing: SizedBox(
              width: 80,
              child: Row(children: [
                //IconButton(
                //onPressed: () {},
                //icon: Icon(Icons.remove_red_eye_rounded),
                //color: Colors.grey,
                //),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  color: Colors.orange,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
