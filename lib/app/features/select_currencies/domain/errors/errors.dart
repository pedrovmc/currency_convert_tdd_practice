import 'package:currency_convert_tdd_practice/app/core/errors/errors.dart';

class ConnectionFailure extends Failure {
  @override
  final String message;

  ConnectionFailure(this.message);
}

class EmptyCurrenciesFailure extends Failure {
  @override
  final String message;

  EmptyCurrenciesFailure(this.message);
}
