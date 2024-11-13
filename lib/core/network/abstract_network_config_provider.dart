abstract class AbstractNetworkConfigProvider {
  Future<Map<String, Object>> getHeaders();
  int getTimeOut();
}
