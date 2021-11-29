// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({required this.nombre, required this.apellido});

  String nombre;
  String apellido;

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      Usuario(nombre: json["nombre"], apellido: json["apellido"]);

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
      };
}
