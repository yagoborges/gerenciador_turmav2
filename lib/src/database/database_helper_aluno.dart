import 'dart:convert';
import 'package:gerenciador_turma/src/aluno/entity_aluno.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DatabaseHelperAluno {
  DatabaseHelperAluno._privateConstructor();
  static final DatabaseHelperAluno instance =
      DatabaseHelperAluno._privateConstructor();
  //despois recupera
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  var uriREST = Uri.parse('http://192.168.0.139:8080/alunos');

  //grava os dados no banco
  salvar(Aluno aluno) async {
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
    if (aluno.cod_aluno == null) {
      print('Código do aluno Nulo');
      //fazer as alterações para os campos de alunos
      var alunoJson =
          jsonEncode({'nome_aluno': aluno.nome_aluno, 'curso': aluno.curso});
      print('JSON ALUNO: $alunoJson');
      resposta = await http.post(uriREST, headers: headers, body: alunoJson);
    } else {
      var alunoJson = jsonEncode({
        'matricula': aluno.cod_aluno,
        'nome_aluno': aluno.nome_aluno,
        'curso': aluno.curso
      });
      resposta = await http.put(uriREST, headers: headers, body: alunoJson);
    }
    statusCode = resposta.statusCode;
    if (statusCode != 200) throw Exception('Erro de REST API.');
  }

  //lista todos os alunos do banco
  Future<List<Aluno>> buscar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var uriREST2 = Uri.parse('http://192.168.0.139:8080/alunos');
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(uriREST2, headers: header);
    //var response = await http.get(uriREST);

    if (response.statusCode != 200) throw Exception('Erro de REST API.');

    Iterable listaDart = jsonDecode(response.body);
    var listaAlunos = <Aluno>[];

    for (Map<String, dynamic> item in listaDart) {
      //pegar o item, converte para Aluno
      var aluno = Aluno(
          cod_aluno: item['matricula'],
          nome_aluno: item['nome_aluno'],
          curso: item['curso']);

      listaAlunos.add(aluno);
    }
    for (var c in listaAlunos) {
      print(c.nome_aluno);
    }
    return listaAlunos;
  }

  //exclui um registro no banco com base no id
  excluir(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var uriREST3 = Uri.parse('http://192.168.0.139:8080/alunos/$id');
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.delete(uriREST3, headers: header);
    var statusCode = response.statusCode;
    if (statusCode != 200) throw Exception('Erro de REST API.');
  }
}
