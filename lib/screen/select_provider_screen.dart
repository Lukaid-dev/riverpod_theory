import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
특정 속성이 변경되었을 때만 반응하는 Provider
최적화의 영역

provider.select : Provider를 생성할 때, 특정 속성만 listen하도록 설정할 수 있다.
''';

    // final name = ref.watch(selectProvider.select((value) => value.name));
    // final isSpicy = ref.watch(selectProvider.select((value) => value.isSpicy));
    // // listen 또한 select 할 수 있음.
    // ref.listen<String>(
    //     selectProvider.select((value) => value.name), (previous, next) {});

    // ref.listen<bool>(
    //     selectProvider.select((value) => value.isSpicy), (previous, next) {});

    final nameAndIsSpicy = ref.watch(selectProvider.select((value) {
      return [value.name, value.isSpicy];
    }));

    ref.listen<List>(selectProvider.select((value) {
      return [value.name, value.isSpicy];
    }), (previous, next) {});

    return DefaultLayout(
      title: 'SelectProvider',
      description: description,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'name: ${nameAndIsSpicy[0]}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 16.0),
              Text(
                'isSpicy: ${nameAndIsSpicy[1]}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(selectProvider.notifier).toggleItemName();
                  },
                  child: const Text('ToggleName'),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(selectProvider.notifier).toggleIsSpicy();
                  },
                  child: const Text('ToggleSpicy'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
