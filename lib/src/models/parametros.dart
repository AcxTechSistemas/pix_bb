part 'paginacao.g.dart';

class Parametros {
  final String inicio;
  final String fim;
  final Paginacao paginacao;

  Parametros({
    required this.inicio,
    required this.fim,
    required this.paginacao,
  });

  factory Parametros.fromJson(Map<String, dynamic> json) {
    return Parametros(
      inicio: json['inicio'],
      fim: json['fim'],
      paginacao: Paginacao.fromJson(json['paginacao']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inicio'] = inicio;
    data['fim'] = fim;
    data['paginacao'] = paginacao.toJson();
    return data;
  }
}
