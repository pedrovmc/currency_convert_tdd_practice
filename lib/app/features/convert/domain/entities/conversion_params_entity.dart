import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/exceptions.dart';

abstract class ConversionParamsEntity {
  final String from;
  final String to;
  final double amount;

  ConversionParamsEntity({
    required this.from,
    required this.to,
    required this.amount,
  });

  void validate() {
    if (from.length != 3 || to.length != 3) {
      throw InvalidCurrencyCodeException();
    }
    if (amount == 0) {
      throw ZeroConversionAmountException();
    }
  }
}
