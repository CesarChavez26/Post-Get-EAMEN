import 'dart:convert';

import 'package:express_examenu3/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Usuario? usuario;

  bool _autenticando = false;
  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future<List<Usuario>> getUser() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3002/users'));
    if (response.statusCode == 200) {
      final List t = json.decode(response.body);
      final List<Usuario> portasAbertasList =
          t.map((item) => Usuario.fromJson(item)).toList();
      return portasAbertasList;
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<bool> login(String nombre, String apellido) async {
    //this.autenticando = true;
    //Payload que mandaremos al backend
    final data = {'nombre': nombre, 'apellido': apellido};
    final uri = Uri.parse('http://10.0.2.2:3002/users');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    //this.autenticando = false;
    print(resp.body);

    //Si la operacion con el servidor es exitosa
    if (resp.statusCode == 200) {
      // final loginResponse = loginResponseFromJson(resp.body);
      // //almacenamos el usuario autenticado
      // this.usuario = loginResponse.usuario;
      return true;
    } else {
      return false;
    }
  }
}
