import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/family_provider.dart';

class FamilyProviderScreen extends ConsumerWidget {
  const FamilyProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
Modifier : Family, AutoDispose - 어떤 Provider에도 사용가능
provider.family<T, A>(create: (ref, arg) => T) : A를 인자로 받아 T를 반환하는 Provider

Provider를 생성할 때, 원하는 인자를 받아서 Provider안의 로직을 변경 후 생성할 수 있다.
''';
    final AsyncValue<List<int>> numbers = ref.watch(familyProvider(99));

    return DefaultLayout(
      title: 'Family Provider',
      description: description,
      body: Center(
        child: numbers.when(
          data: (data) => Text(data.toString()),
          error: (err, stack) => Text('Error: $err'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
