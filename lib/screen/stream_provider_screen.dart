import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/stream_provider.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
똑같이 state를 watch하고, state.when을 통해 상태에 따라 다른 UI를 보여준다.
stream에 따라 state가 변하고 이때마다 UI를 rebuild한다.
''';
    final AsyncValue<List<int>> stream = ref.watch(multiplesStreamProvider);

    return DefaultLayout(
      title: 'StreamProvider',
      description: description,
      body: Center(
        child: stream.when(
          data: (data) => Text(data.toString()),
          error: (error, stack) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
