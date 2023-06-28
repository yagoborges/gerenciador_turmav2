import 'dart:convert';
import 'package:gerenciador_turma/src/professor/entity_professor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DatabaseHelperProfessor {
  DatabaseHelperProfessor._privateConstructor();
  static final DatabaseHelperProfessor instance =
      DatabaseHelperProfessor._privateConstructor();
  //despois recupera
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  var uriREST = Uri.parse('http://192.168.0.139:8080/professores');

  //grava os dados no banco
  salvar(Professor professor) async {
    var testeToken = await getToken();
    print('O toke resgatado pelo SharedPreferences é: $testeToken');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $testeToken'
    };
    print('O cabeçalho é: $headers');

    var statusCode = 0;
    http.Response resposta;
    //comparação com id de professor
    if (professor.cod_prof == null) {
      print('Código do professor Nulo');
      //fazer as alterações para os campos de professores
      var professorJson = jsonEncode({'nome_prof': professor.nome_prof});
      print('JSON PROFESSOR: $professorJson');
      resposta =
          await http.post(uriREST, headers: headers, body: professorJson);
    } else {
      var professorJson = jsonEncode(
          {'cod_prof': professor.cod_prof, 'nome_prof': professor.nome_prof});
      resposta = await http.put(uriREST, headers: headers, body: professorJson);
    }
    statusCode = resposta.statusCode;
    if (statusCode != 200) throw Exception('Erro de REST API.');
  }

  //lista todos os professores do banco
  Future<List<Professor>> buscar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var uriREST2 = Uri.parse('http://192.168.0.139:8080/professores');
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(uriREST2, headers: header);
    //var response = await http.get(uriREST);

    if (response.statusCode != 200) throw Exception('Erro de REST API.');

    Iterable listaDart = jsonDecode(response.body);
    var listaProfessores = <Professor>[];

    for (Map<String, dynamic> item in listaDart) {
      //pegar o item, converte para Professor
      var professor =
          Professor(cod_prof: item['cod_prof'], nome_prof: item['nome_prof']);

      listaProfessores.add(professor);
    }
    for (var c in listaProfessores) {
      print(c.nome_prof);
    }
    return listaProfessores;
  }

  //exclui um registro no banco com base no id
  excluir(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var uriREST3 = Uri.parse('http://192.168.0.139:8080/professores/$id');
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.delete(uriREST3, headers: header);
    var statusCode = response.statusCode;
    if (statusCode != 200) throw Exception('Erro de REST API.');
  }
}
