import 'package:auth_module/main.dart';
import 'package:auth_module/src/core/services/local_storage/cache_service.dart';
import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

final networkProvider = Provider(
  (ref) {
    return RestClient(
      baseUrl: API.base,
      tokenCallBack: () async {
        return CacheService.instance.retrieveBearerToken();
      },
      onUnAuthorizedError: logoutOnUnauthorizedError,
    );
  },
);
