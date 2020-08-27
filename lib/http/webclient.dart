import 'dart:convert';

import 'package:bankbyte/models/contact.dart';
import 'package:bankbyte/screen/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

final Client cliente = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);
const String baseUrl = 'http://localhost:8080/transactions';
Future<List<Transaction>> findAll() async {
  final Response response = await cliente.get(baseUrl).timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {'name': transaction.contact.name, 'accountNumber': transaction.contact.accountNumber}
  };
  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await cliente.post(baseUrl,
      headers: {
        'Contect-type': 'application/json',
        'password': '1000',
      },
      body: transactionJson);

  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(
    json['name'],
    Contact(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
}
