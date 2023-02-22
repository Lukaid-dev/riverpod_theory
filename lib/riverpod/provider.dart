import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/model/shopping_item_model.dart';
import 'package:riverpod_theory/riverpod/state_notifier_provider.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>((ref) {
  final sProvider = ref.watch(shoppingListNotifierProvider);
  final fProvider = ref.watch(filterProvider);

  if (fProvider == FilterState.all) {
    return sProvider;
  }

  return fProvider == FilterState.spicy
      ? sProvider.where((element) => element.isSpicy).toList()
      : sProvider.where((element) => !element.isSpicy).toList();
});

enum FilterState {
  notSpicy,
  spicy,
  all,
}

final filterProvider = StateProvider((ref) => FilterState.all);
