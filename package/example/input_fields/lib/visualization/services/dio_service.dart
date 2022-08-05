import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:sqflite/sqflite.dart';

DbCacheStore? cacheStore;
CacheOptions? options;
DioCacheInterceptor? cacheInterceptor;
Dio? dioInstance;

Future initDio() async {
  // if (cacheStore == null) {
  //   var databasePath = await getDatabasesPath();
  //   cacheStore = DbCacheStore(
  //     databasePath: databasePath,
  //   );
  // }
  // options ??= CacheOptions(
  //     store: cacheStore,
  //     policy: CachePolicy.refreshForceCache,
  //     maxStale: const Duration(days: 30),
  //     priority: CachePriority.normal);
  // cacheInterceptor ??= DioCacheInterceptor(options: options!);

  dioInstance = Dio();
}
