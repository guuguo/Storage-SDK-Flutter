part of leancloud_storage;

/// LeanEngine
class LCCloud {
  static bool isProd = true;

  /// Switches the LeanEngine environment.
  /// 
  /// - `true`: the production environment.
  /// - `false`: the staging environment.
  static void setProduction(bool prod) {
    isProd = prod;
  }

  /// Invokes a cloud function named [name] with [params] and receives a `Map` or `List`.
  static Future run(String name, {Map<String, dynamic>? params}) async {
    String path = 'functions/$name';
    Map<String, dynamic> headers = {'X-LC-Prod': isProd ? 1 : 0};
    return await LeanCloud._httpClient
        .post(path, headers: headers, data: params);
  }

  /// Invokes a cloud function named [name] with [params],
  /// and receives a [LCObject], List<[LCObject]>, or Map<String, [LCObject]>.
  static Future rpc(String name, {Map<String, dynamic>? params}) async {
    String path = 'call/$name';
    Map<String, dynamic> headers = {'X-LC-Prod': isProd ? 1 : 0};
    Map? response =
        await (LeanCloud._httpClient.post(path, headers: headers, data: params) as FutureOr<Map<dynamic, dynamic>?>);
    return _LCDecoder.decode(response);
  }
}
