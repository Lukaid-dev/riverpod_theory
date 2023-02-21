import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/model/shopping_item_model.dart';

final shoppingListNotifierProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>(
  (ref) => ShoppingListNotifier(),
);

// StateNotifierProvider 는 말 그대로 상태를 알려주는 provider임.

// 얘는 상태를 관리하는 클래스를 만들어서 사용함. (Notifier, StateNotifier를 상속하여 사용함)

// Notifier는 반드시 super()를 호출해서 상태를 초기화해줘야함.

// 이때 상태(state)는 StateNotifier의 타입임.

// Notifier를 만들었으면, 이를 이용하여 provider를 선언함

// StateNotifierProvider : StateNotifier를 상속받는 class를 provider로 만듬

// StateNotifier : StateNotifierProvider에 제공이 될 class가 상속
class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  ShoppingListNotifier()
      : super(
          [
            const ShoppingItemModel(
              name: '김치',
              quantity: 3,
              hasBought: false,
              isSpicy: true,
            ),
            const ShoppingItemModel(
              name: '라면',
              quantity: 5,
              hasBought: false,
              isSpicy: true,
            ),
            const ShoppingItemModel(
              name: '불닭소스',
              quantity: 1,
              hasBought: false,
              isSpicy: true,
            ),
            const ShoppingItemModel(
              name: '삼겹살',
              quantity: 10,
              hasBought: false,
              isSpicy: false,
            ),
            const ShoppingItemModel(
              name: '수박',
              quantity: 2,
              hasBought: false,
              isSpicy: false,
            ),
            const ShoppingItemModel(
              name: '카스테라',
              quantity: 5,
              hasBought: false,
              isSpicy: false,
            ),
          ],
        );

  void toggleHasBought({required String name}) {
    state = state
        .map(
          (e) => e.name == name ? e.copyWith(hasBought: !e.hasBought) : e,
        )
        .toList();
  }
}
