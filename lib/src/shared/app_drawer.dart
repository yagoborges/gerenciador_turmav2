import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    //final authService = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  child: Text('Usuário'
                      //authService.user?.name[0] ?? '-',
                      ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text('Usuário'
                    //StringHelpers.truncateWithEllipsis(
                    //15,
                    //authService.user?.name ?? '-',
                    //),
                    ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Turmas'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/turma_page');
            },
          ),
          ListTile(
            title: const Text('Professores'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/professor_page');
            },
          ),
          ListTile(
            title: const Text('Disciplinas'),
            onTap: () {
              Navigator.pushNamed(context, '/disciplina_page');
            },
          ),
          ListTile(
            title: const Text('Alunos'),
            onTap: () {
              Navigator.pushNamed(context, '/aluno_page');
            },
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () {
              //authService.logout().then((value) => value);
              ///Navigator.pop(context);
              //Navigator.popAndPushNamed(context, '/auth/login');
            },
          ),
        ],
      ),
    );
  }
}
