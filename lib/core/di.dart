// ignore_for_file: cascade_invocations

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:your_sales/core/networking/dio_factory.dart';
import 'package:your_sales/features/my_app/controller/cubit/localization_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt
    ..registerLazySingleton<DioFactory>(() {
      return DioFactory();
    })
    ..registerLazySingleton<Dio>(() => getIt<DioFactory>().createDio());
  getIt.registerLazySingleton<LocalizationCubit>(LocalizationCubit.new);
  // getIt.registerLazySingleton<ChatRemoteDataSource>(
  //   () => ChatRemoteDataSourceImpl(dio: getIt()),
  // );
  // getIt.registerLazySingleton<ChatRepository>(
  //   () => ChatRepositoryImpl(remote: getIt()),
  // );
  // getIt.registerFactory<ChatBloc>(() => ChatBloc(repository: getIt()));
}
