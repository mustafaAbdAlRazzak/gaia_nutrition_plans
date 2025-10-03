import 'package:get/get.dart';
import 'package:http/http.dart';

class HttpClientServicesProvider extends GetxService {
  late final Client client;

  Future<HttpClientServicesProvider> init() async {
    client = Client();
    return this;
  }
}
