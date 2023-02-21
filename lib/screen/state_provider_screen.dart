import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_elevated_button.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/state_provider.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
가장 기본이 되는 Provider : StateProvider

Riverpod에서는 Provider를 쓰려면 main.dart에서 MaterialApp을 ProviderScope로 감싸줘야 한다.

statelessWidget -> ConsumerWidget (statelessWidget과 99% 일치)

- ref.watch 
    - 특정 provider를 바라보고 있다가, 그 provider의 state가 변경되면, 해당 widget을 rebuild한다. build() 메소드 안에서 사용
    - 반환값의 업데이트가 있을때, 지속적으로 build 함수를 다시 실행함
    - 필수적으로 UI관련 코드에만 사용함

- ref.read 
    - 특정 provider의 state를 읽어옴
    - 실행되는 순간 단 한번만 provider의 값을 가져옴
    - onPressed callback 처럼 특정 액션 뒤에 실행되는 함수 내부에서 사용됨

numberProvider.notifier : numberProvider의 값을 바꾸고 싶을 때 사용함
''';

    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'Basic Provider',
      description: description,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            provider.toString(),
            textAlign: TextAlign.center,
          ),
          DefaultElevatedButton(
            onPressed: () {
              ref.read(numberProvider.notifier).state =
                  ref.read(numberProvider.notifier).state + 1;
            },
            child: const Text('UP'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              ref.read(numberProvider.notifier).update((state) => state - 1);
            },
            child: const Text('DWON'),
          ),
        ],
      ),
    );
  }
}
