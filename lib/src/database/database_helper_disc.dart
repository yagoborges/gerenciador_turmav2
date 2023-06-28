import 'dart:convert';

import 'package:gerenciador_turma/src/disciplina/entity_disciplina.dart';
import 'package:gerenciador_turma/src/professor/entity_professor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DatabaseHelperDisc {
  DatabaseHelperDisc._privateConstructor();
  static final DatabaseHelperDisc instance =
      DatabaseHelperDisc._privateConstructor();
  //despois recupera
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  var uriREST = Uri.parse('http://192.168.0.139:8080/disciplinas');

  //grava os dados no banco
  salvar(Disciplina disciplina, Professor professor) async {
    var testeToken = await getToken();
    print('O toke resgatado pelo SharedPreferences é: $testeToken');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $testeToken'
    };
    print('O cabeçalho é: $headers');

    var statusCode = 0;
    http.Response resposta;
    //comparação com id de aluno
    if (disciplina.nome_disc == null) {
      print('Código do aluno Nulo');
      //fazer as alterações para os campos de alunos

      //Criando um Map para converter em JSON
      Map<String, dynamic> mapJson = {
        'nome_disc': disciplina.nome_disc,
        'fk_cod_prof': {
          'cod_prof': professor.cod_prof,
        },
      };

      var disciplinaJson = jsonEncode(mapJson);
      print('JSON DISC: $disciplinaJson');
      resposta =
          await http.post(uriREST, headers: headers, body: disciplinaJson);
    } else {
      //Criando um Map para converter em JSON
      Map<String, dynamic> mapJson = {
        'cod_disc': disciplina.cod_disc,
        'nome_disc': disciplina.nome_disc,
        'fk_cod_prof': {
          'cod_prof': professor.cod_prof,
        },
      };
      var disciplinaJson = jsonEncode(mapJson);
      resposta =
          await http.put(uriREST, headers: headers, body: disciplinaJson);
    }
    statusCode = resposta.statusCode;
    if (statusCode != 200) throw Exception('Erro de REST API.');
  }

  //lista todos os alunos do banco
  Future<List<Disciplina>> buscar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var uriREST2 = Uri.parse('http://192.168.0.139:8080/disciplinas');
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(uriREST2, headers: header);
    //var response = await http.get(uriREST);

    if (response.statusCode != 200) throw Exception('Erro de REST API.');
    print('Response.body: ');
    print(response.body.toString());

    //Convertendo o JSON para UTF8
    var responseBodyBytes = response.bodyBytes;
    var responseBodyString = utf8.decode(responseBodyBytes);

    Iterable listaDart = jsonDecode(responseBodyString);
    var listaDisciplinas = <Disciplina>[];
    //print(listaDart.toString());
    for (Map<String, dynamic> item in listaDart) {
      //pegar o item, converte para Aluno
      var disciplina = Disciplina(
          cod_disc: item['cod_disc'],
          nome_disc: item['nome_disc'],
          fk_cod_prof: item['fk_cod_prof']);

      listaDisciplinas.add(disciplina);
    }
    for (var c in listaDisciplinas) {
      print(c.nome_disc);
      print('Chave estrangeira cod_prof: ${c.fk_cod_prof}');
    }
    return listaDisciplinas;
  }

  //exclui um registro no banco com base no id
  excluir(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var uriREST3 = Uri.parse('http://192.168.0.139:8080/disciplinas/$id');
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.delete(uriREST3, headers: header);
    var statusCode = response.statusCode;
    if (statusCode != 200) throw Exception('Erro de REST API.');
  }
}
