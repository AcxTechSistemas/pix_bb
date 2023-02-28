part 'pagador.g.dart';

/// A class representing a PIX payment.
///
/// This class contains information about a payment made through PIX.
///
/// The [Pix] class has a constructor that requires the following parameters:
/// - [valor]: the value of the payment.
/// - [horario]: the date and time when the payment was made.
/// - [pagador]: a [Pagador] object representing the payer.
/// - [infoPagador]: additional information about the payer.
///
/// The [endToEndId] and [txid] parameters are optional, and can be set to null.
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

  /// A factory method for creating a [Pix] object from a JSON object.
  ///
  /// This method takes a [Map<String, dynamic>] object and returns a new instance of [Pix] class.
  ///
  /// The following keys must be present in the input JSON object:
  /// - 'valor': the value of the payment.
  /// - 'horario': the date and time when the payment was made.
  /// - 'pagador': a [Map<String, dynamic>] object representing the payer.
  /// - 'infoPagador': additional information about the payer.
  ///
  /// The following key is optional:
  /// - 'endToEndId': a unique identifier for the payment.
  /// - 'txid': a transaction ID for the payment.
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

  /// A method for serializing the [Pix] object to a JSON object.
  ///
  /// This method returns a [Map<String, dynamic>] object representing the [Pix] object.
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
