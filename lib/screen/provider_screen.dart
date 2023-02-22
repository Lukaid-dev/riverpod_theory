import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/provider.dart';
import 'package:riverpod_theory/riverpod/state_notifier_provider.dart';

class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
Proxy Provider를 학습하기 위한 페이지, provider안의 provider
provider안에서 ref.watch를 하면 widget에서와 마찬가지로 동작하며,
ref.read를 하면 해당 provider의 state를 읽을 수 있다.
''';
    final filteredItems = ref.watch(filteredShoppingListProvider);

    return DefaultLayout(
      title: 'Provider',
      description: description,
      actions: [
        PopupMenuButton<FilterState>(
          itemBuilder: (_) {
            return FilterState.values
                .map(
                  (e) => PopupMenuItem<FilterState>(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList();
          },
          onSelected: (value) {
            ref.read(filterProvider.notifier).update((state) => value);
          },
        ),
      ],
      body: ListView(
        children: filteredItems
            .map(
              (e) => CheckboxListTile(
                value: e.hasBought,
                title: Text('${e.name}(${e.quantity})'),
                onChanged: (value) {
                  ref
                      .read(shoppingListNotifierProvider.notifier)
                      .toggleHasBought(
                        name: e.name,
                      );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
