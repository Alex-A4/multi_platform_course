import 'package:get_it/get_it.dart';
import 'package:multi_platform_course/app/widgets/employee_page/bloc/basic_page/bloc.dart';
import 'package:multi_platform_course/app/widgets/employee_page/bloc/filter_page/bloc.dart';
import 'package:multi_platform_course/app/widgets/main_page/bloc/bloc.dart';
import 'package:multi_platform_course/app/widgets/position_page/bloc/position_bloc/bloc.dart';
import 'package:multi_platform_course/data/database/company_database_impl.dart';
import 'package:multi_platform_course/data/providers/path_provider_impl.dart';
import 'package:multi_platform_course/data/repositories/company_repository_impl.dart';
import 'package:multi_platform_course/data/repositories/entity_converters/employee_json_converter.dart';
import 'package:multi_platform_course/data/repositories/entity_converters/position_json_converter.dart';
import 'package:multi_platform_course/domain/database/company_database.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/entities/position.dart';
import 'package:multi_platform_course/domain/providers/path_provider.dart';
import 'package:multi_platform_course/domain/repositories/company_repository.dart';
import 'package:multi_platform_course/domain/repositories/entity_encoder.dart';

GetIt sl = GetIt.instance;

void initServiceLocator() {
  /// Basic
  sl.registerFactory<PathProvider>(() => PathProviderImpl());
  sl.registerFactory<EntityConverter<Employee>>(() => EmployeeJsonConverter());
  sl.registerFactory<EntityConverter<PositionRequirements>>(
      () => PositionRequirementsJsonConverter());
  sl.registerFactory<EntityConverter<Position>>(
      () => PositionJsonConverter(sl<EntityConverter<PositionRequirements>>()));

  /// Database
  sl.registerSingleton<CompanyDatabase>(CompanyDatabaseImpl(sl(), sl(), sl()));

  /// Repositories
  sl.registerFactory<CompanyRepository>(() => CompanyRepositoryImpl(sl()));

  /// Bloc
  sl.registerFactory<MainBloc>(() => MainBloc());
  sl.registerFactory<SimpleEmployeeBloc>(() => SimpleEmployeeBloc(sl()));
  sl.registerFactory<EmployeeFilterBloc>(() => EmployeeFilterBloc(sl()));
  sl.registerFactory<PositionBloc>(() => PositionBloc(sl()));
}
