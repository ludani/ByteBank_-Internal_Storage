import 'dart:convert';

import 'package:bankbyte/http/interceptors/loggind_interceptor.dart';
import 'package:bankbyte/models/contact.dart';
import 'package:bankbyte/screen/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client cliente = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);
const String baseUrl = 'http://localhost:8080/transactions';
