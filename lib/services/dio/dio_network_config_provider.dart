import '../../../core/network/abstract_network_config_provider.dart';

class DioNetworkConfigProvider extends AbstractNetworkConfigProvider {

  DioNetworkConfigProvider(
  );

  @override
  Future<Map<String, Object>> getHeaders() async {

    return {
      'Accept': 'application/json',
      'X-app-name': 'Weather App',
      'X-bundle-id': 'app.flaconi.weather',
    };
  }

  @override
  int getTimeOut() {
    return 120;
  }
}
