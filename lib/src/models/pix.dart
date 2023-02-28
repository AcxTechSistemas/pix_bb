part 'pagador.g.dart';

class Pix {
  final String? endToEndId;
  final String valor;
  final String horario;
  final Pagador pagador;
  final String infoPagador;
  final String? txid;

  Pix({
    this.endToEndId,
    required this.valor,
    required this.horario,
    required this.pagador,
    required this.infoPagador,
    this.txid,
  });

  factory Pix.fromJson(Map<String, dynamic> json) {
    return Pix(
      endToEndId: json['endToEndId'],
      valor: json['valor'],
      horario: json['horario'],
      pagador: Pagador.fromJson(json['pagador']),
      infoPagador: json['infoPagador'],
      txid: json['txid'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['endToEndId'] = endToEndId;
    data['valor'] = valor;
    data['horario'] = horario;
    data['pagador'] = pagador.toJson();
    data['infoPagador'] = infoPagador;
    data['txid'] = txid;
    return data;
  }
}
