import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/model/shopping_item_model.dart';
import 'package:riverpod_theory/riverpod/state_notifier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
가장 많이 사용하게 될 Provider

StateNotifierProvider 는 말 그대로 상태를 알려주는 provider임.

얘는 상태를 관리하는 클래스를 만들어서 사용함. (Notifier, StateNotifier를 상속하여 사용함)

Notifier는 반드시 super()를 호출해서 상태를 초기화해줘야함.

이때 상태(state)는 StateNotifier의 타입임.

Notifier를 만들었으면, 이를 이용하여 provider를 선언함

StateNotifierProvider : StateNotifier를 상속받는 class를 provider로 만듬

StateNotifier : StateNotifierProvider에 제공이 될 class가 상속

-----

여기서는, 

shoppingListNotifierProvider를 선언하기 위해, 

<List<ShoppingItemModel>> 타입의 StateNotifier를 상속받는 ShoppingListNotifier를 만들었음.

얘를 초기화 해주고, StateNotifierProvider를 통해 <ShoppingListNotifier, List<ShoppingItemModel>> 타입의 ShoppingListNotifier() 인스턴스 반환

이게 shoppingListNotifierProvider임

그러니 관리하는 state가 instance이고 로직이 조금 복잡 한 것외에, stateProvider와 크게 다르지 않음.
''';

    List<ShoppingItemModel> items = ref.watch(shoppingListNotifierProvider);

    return DefaultLayout(
      title: 'StateNotifierProvider',
      description: description,
      body: ListView(
        children: items
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
