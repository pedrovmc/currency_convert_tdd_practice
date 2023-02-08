import 'package:currency_convert_tdd_practice/app/core/consts.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client_exception.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client_response.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/external/currency_datasource_impl.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/currency_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RestClientMock extends Mock implements RestClient {}

void main() {
  late CurrencyDatasourceImpl sut;
  late RestClient restClient;
  setUp(() {
    restClient = RestClientMock();
    sut = CurrencyDatasourceImpl(restClient: restClient);
  });

  group("Currency datasource", () {
    test("Should call rest client get method with the correct url", () async {
      //arrange
      when(() => restClient.get("$baseUrl/codes")).thenAnswer((_) async =>
          RestClientResponse(data: mockedResponse, statusCode: 200));
      //act
      await sut.getCurrencies();

      //assert
      verify(() => restClient.get("$baseUrl/codes")).called(1);
    });

    test("Should throw a restclient exception if request fails", () async {
      //arrange
      when(() => restClient.get("$baseUrl/codes"))
          .thenThrow(RestClientException(error: ""));

      //act
      final result = sut.getCurrencies();

      //assert
      expect(result, throwsA(isA<RestClientException>()));
    });
    test("Should return a list of currency model if request is successful",
        () async {
      //arrange
      when(() => restClient.get("$baseUrl/codes")).thenAnswer((_) async =>
          RestClientResponse(data: mockedResponse, statusCode: 200));

      //act
      final result = await sut.getCurrencies();

      //assert
      expect(result, isA<List<CurrencyModel>>());
      expect(result.first.code, "AED");
      expect(result.first.name, "UAE Dirham");
      expect(result.last.code, "BBD");
      expect(result.last.name, "Barbados Dollar");
    });
  });
}

final Map<String, dynamic> mockedResponse = {
  "result": "success",
  "documentation": "https://www.exchangerate-api.com/docs",
  "terms_of_use": "https://www.exchangerate-api.com/terms",
  "supported_codes": [
    ["AED", "UAE Dirham"],
    ["AFN", "Afghan Afghani"],
    ["ALL", "Albanian Lek"],
    ["AMD", "Armenian Dram"],
    ["ANG", "Netherlands Antillian Guilder"],
    ["AOA", "Angolan Kwanza"],
    ["ARS", "Argentine Peso"],
    ["AUD", "Australian Dollar"],
    ["AWG", "Aruban Florin"],
    ["AZN", "Azerbaijani Manat"],
    ["BAM", "Bosnia and Herzegovina Convertible Mark"],
    ["BBD", "Barbados Dollar"]
  ]
};
