part of 'pix.dart';

class Pagador {
  String? cpf;
  final String nome;
  String? cnpj;

  Pagador({
    this.cpf,
    required this.nome,
    this.cnpj,
  });

  factory Pagador.fromJson(Map<String, dynamic> json) {
    return Pagador(
      cpf: json['cpf'],
      nome: json['nome'],
      cnpj: json['cnpj'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpf'] = cpf;
    data['nome'] = nome;
    data['cnpj'] = cnpj;
    return data;
  }
}
