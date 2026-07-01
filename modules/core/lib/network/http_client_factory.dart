import 'dart:io';

import 'package:core/constants/app_assets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpClientFactory {
  HttpClientFactory._();

  static Future<http.Client> create() async {
    final context = SecurityContext(withTrustedRoots: false);

    final ByteData cert = await rootBundle.load('packages/core/${AppAssets.certificate}');

    context.setTrustedCertificatesBytes(cert.buffer.asInt8List());

    final httpClient = HttpClient(context: context);

    return IOClient(httpClient);
  }
}
