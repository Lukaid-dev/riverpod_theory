import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/auto_dispose_provider.dart';

class AutoDisposeScreen extends ConsumerWidget {
  const AutoDisposeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
Modifier : AutoDispose - 어떤 Provider에도 사용가능
provider.autoDispose<T>(create: (ref) => T) : T를 반환하는 Provider
다만, 해당 위젯이 dispose될 때, Provider도 dispose된다.
데이터가 캐싱되지 않고, 새로운 위젯이 생성될 때마다 Provider가 새로 생성된다.
''';
    final AsyncValue<List<int>> result = ref.watch(autoDisposeProvider);

    return DefaultLayout(
      title: 'AutoDispose',
      description: description,
      body: Center(
        child: result.when(
          data: (data) => Text(data.toString()),
          error: (err, stack) => Text('Error : $err'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
