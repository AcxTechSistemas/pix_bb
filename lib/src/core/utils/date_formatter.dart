import 'package:intl/intl.dart';

/// Utility class for formatting dates for the Banco do Brasil's API.
class BbDateFormatter {
  /// Formats a [DateTime] object to ISO 8601 format with the fixed time zone offset -03:00.
  ///
  /// Example: 2023-10-27T10:00:00.00-03:00
  static String formatToIso8601WithOffset(DateTime date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss-03:00").format(date);
  }
}
