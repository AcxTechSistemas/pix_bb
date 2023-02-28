part of 'pix.dart';

///A class representing a Payer.
///The Payer can be identified by either CPF or CNPJ and has a name.
class Pagador {
  /// The CPF of the payer. Can be null if identified by CNPJ.
  String? cpf;

  /// The name of the payer.
  final String nome;

  /// The CNPJ of the payer. Can be null if identified by CPF.
  String? cnpj;

  ///Create a new instance of [Pagador].
  ///[cpf] and [cnpj] should not be both null.
  Pagador({
    this.cpf,
    required this.nome,
    this.cnpj,
  });

  ///Create a new instance of [Pagador] from a [Map].
  factory Pagador.fromJson(Map<String, dynamic> json) {
    return Pagador(
      cpf: json['cpf'],
      nome: json['nome'],
      cnpj: json['cnpj'],
    );
  }

  ///Convert this [Pagador] instance to a [Map].
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpf'] = cpf;
    data['nome'] = nome;
    data['cnpj'] = cnpj;
    return data;
  }
}
