import 'package:flutter/material.dart';
import 'package:gerenciador_turma/src/shared/app_scaffold.dart';

class ProfessorPage extends StatelessWidget {
  const ProfessorPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final authService = Provider.of<AuthService>(context);
    final listaProfessores = [
      {'cod_prof': '1', 'nome_prof': 'Thiago Porto'},
      {'cod_prof': '2', 'nome_prof': 'Laura Beatriz'},
      {'cod_prof': '3', 'nome_prof': 'Lacordaire Kermel Cury'},
    ];

    return AppScaffold(
      pageTitle: const Text('Professores'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listaProfessores.length,
        itemBuilder: (context, i) {
          var professores = listaProfessores[i];
          return ListTile(
            title: Text(professores['nome_prof'].toString()),
            subtitle: Text("Código: ${professores['cod_prof']}"),
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
