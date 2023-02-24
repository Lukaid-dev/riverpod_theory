// riverpod code generation

// 1) 어떤 프로바이더를 사용할지 고민 할 필요 없도록
// ex) provider, futureProvider, streamProvider(?)
// ex) stateNotifierProvider
// 2) provider에 parameter를 넘겨줄 때, provider의 family를 사용하는데 이떄는 한번에 여러개의 parameter를 넘겨줄 수 없다.
// - 이를 해결하기 위해, code generation을 사용한다.

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1)

// final _testProvider = Provider<String>((ref) => 'Hello Code Generation');
// 원래는 위와 같이 선언해야 했지만, code generation을 사용하면 아래와 같이 일반 함수로 작성하여 Provider를 선언할 수 있다.

@riverpod
String gState(GStateRef ref) {
  return 'Hello Code Generation';
}

// and `flutter pub run build_runner build` in terminal
// 마찬가지로 생성된 파일의 Provider를 사용하면 됨

// future를 넣으면?
@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(const Duration(seconds: 3));
  return 10;
}

// parameter를 안받으면 riverpod, 받으면 Riverpod()
@Riverpod(
  keepAlive: true,
)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(const Duration(seconds: 3));
  return 10;
}

// 2) as-is
// class _testParameter {
//   final int number1;
//   final int number2;

//   _testParameter({
//     required this.number1,
//     required this.number2,
//   });
// }

// final _testFamilyProvider = FutureProvider.family<int, _testParameter>(
//   (ref, parameter) => parameter.number1 * parameter.number2,
// );

// to-be
@riverpod
Future<int> gStateMultiply(
  GStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) async {
  return number1 * number2;
}

// stateNotifierProvider
@riverpod
class GStateNotifier extends _$GStateNotifier {
  // initial state, have to override build method
  @override
  int build() {
    return 0;
  }

  increment() {
    state++;
  }

  decrement() {
    state--;
  }
}
