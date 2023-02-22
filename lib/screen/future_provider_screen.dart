import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
똑같이 state를 watch하고, state.when을 통해 상태에 따라 다른 UI를 보여준다.
''';

    final AsyncValue<List<int>> numbers = ref.watch(multiplesFutureProvider);

    return DefaultLayout(
      title: 'FutureProvider',
      description: description,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          numbers.when(
            data: (data) => Text(
              data.toString(),
              textAlign: TextAlign.center,
            ),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
