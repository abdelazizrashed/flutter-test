import 'package:evaluation_project/logic/repositories/home/home_repository.dart';
import 'package:evaluation_project/logic/repositories/home/home_repository_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<HomeRepository>(HomeRepositoryImplementation());
}
