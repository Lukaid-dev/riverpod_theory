import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
1) 어떤 프로바이더를 사용할지 고민 할 필요 없도록
ex) provider, futureProvider, streamProvider(?)
ex) stateNotifierProvider
2) provider에 parameter를 넘겨줄 때, provider의 family를 사용하는데 이떄는 한번에 여러개의 parameter를 넘겨줄 수 없다.
- 이를 해결하기 위해, code generation을 사용한다.
''';
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(
      number1: 10,
      number2: 20,
    ));
    // final state5 = ref.watch(gStateNotifierProvider);

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      description: description,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('state1: $state1'),
          const SizedBox(height: 8),
          state2.when(
            data: (data) => Text(
              'state2: ${data.toString()}',
              textAlign: TextAlign.center,
            ),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 8),
          state3.when(
            data: (data) => Text(
              'state3: ${data.toString()}',
              textAlign: TextAlign.center,
            ),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 8),
          Text('state4: $state4'),
          const SizedBox(height: 8),
          // Text('state5: $state5'),
          // _StateFiveWidget(),
          Consumer(
            // Consumer 위젯은, build가 따로 호출됨
            builder: (context, ref, child) {
              final state5 = ref.watch(gStateNotifierProvider);
              return Row(
                children: [
                  Text('state5: $state5'),
                  const SizedBox(width: 8),
                  if (child != null) child,
                ],
              );
            },
            // 한술 더 떠서, Consumer 위젯안에서도 rebuild하기 싫은 애들은 이렇게 child로 넘겨줄 수 있다.
            child: const Text('consumer widget의 child parameter'),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () =>
                    ref.read(gStateNotifierProvider.notifier).decrement(),
                child: const Text('Decrement'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () =>
                    ref.read(gStateNotifierProvider.notifier).increment(),
                child: const Text('Increment'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // invalidate() -> 유효하지 않은 상태로 만들어준다. (초기화 해줌)
          ElevatedButton(
            onPressed: () {
              ref.invalidate(gStateNotifierProvider);
            },
            child: const Text('Invalidate'),
          )
        ],
      ),
    );
  }
}

// state5만 rebuild 하고 싶다면? -> ConsumerWidget을 사용하면 된다. 근데 이건 비효율적임
// 그래서 Consumer()를 제공
class _StateFiveWidget extends ConsumerWidget {
  const _StateFiveWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state5 = ref.watch(gStateNotifierProvider);
    return Text('state5: $state5');
  }
}
