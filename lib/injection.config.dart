// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:examen_unidad2/src/data/dataSource/local/SharedPref.dart'
    as _i175;
import 'package:examen_unidad2/src/data/dataSource/remote/service/ReservaService.dart'
    as _i740;
import 'package:examen_unidad2/src/di/AppModule.dart' as _i267;
import 'package:examen_unidad2/src/domain/repository/ReservaRepository.dart'
    as _i637;
import 'package:examen_unidad2/src/domain/useCase/Reserva/ReservaUseCases.dart'
    as _i549;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i175.SharedPref>(() => appModule.sharedPref);
    gh.factory<_i740.ReservaService>(() => appModule.reservaService);
    gh.factory<_i637.ReservaRepository>(() => appModule.reservaRepository);
    gh.factory<_i549.ReservaUseCases>(() => appModule.reservaUseCases);
    return this;
  }
}

class _$AppModule extends _i267.AppModule {}
