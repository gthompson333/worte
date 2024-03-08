import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_bloc/flutter_bloc.dart';

/// [BlocObserver] for the application which
/// observes all state changes.
class BlocMonitor extends BlocObserver {
  /// {@macro app_bloc_observer}
  const BlocMonitor();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    foundation.debugPrint('${bloc.runtimeType} $change');
  }
}
