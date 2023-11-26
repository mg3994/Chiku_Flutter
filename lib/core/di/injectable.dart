import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


// import '../repo/counter_repository.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  // initializerName: 'init', //this name will be hint: 1
  preferRelativeImports: true,
  asExtension: false,
)
void configureAppEnv({required String appEnvironment}) => $initGetIt(getIt,
    environment: appEnvironment); //name will be same as mentioned abov
// void configureDependencies({required GetIt instance}) =>
//     init(instance); // this name will be hint: 1



// void main() {
//   getIt<CounterRepository>();
// }
