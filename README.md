# riverpod_theory

제가 Riverpod에 대해 공부하면서 정리한 내용입니다. 다음의 강의와 문서를 참고했습니다. Repo의 Code들은 Codefactory님의 강의를 기반으로 이해를 돕기위해 추가된 내용들을 포함하고 있습니다.

- [Codefactory 강의 링크](https://www.inflearn.com/course/%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%8B%A4%EC%A0%84/dashboard)
- [Riverpod 공식 문서](https://docs-v2.riverpod.dev/)
- [Riverpod for Provider users](https://docs-v2.riverpod.dev/docs/riverpod_for_provider_users)


<details>
<summary>Provider사용자를 위한 Riverpod 가이드 _ 번역</summary>
<div>

## The relationship between Riverpod and Provider

Riverpod는 Provider의 다음 버전으로, Provider의 모든 기능을 포함하고 있습니다. (Riverpod은 Provider의 정신적 계승자로 설계되었으며, 그 이름도 Provider의 애너그램입니다.)

당연하겠지만, Riverpod은 Provider의 여러 기술적 한계를 해결하기 위해 탄생하였습니다. 원래는 Provider의 메이저 업데이트의 일환으로 Riverpod을 출시 할 계획이었지만, 바뀐것도 많고 Provider도 워낙 많이 사용하는 패키지이기 때문에, Riverpod을 새로운 패키지로 출시하였습니다.

떄문에, 개념적으로 Riverpod와 Provider는 상당히 유사하고, 두 패키지 모두 아래와 같이 비슷한 역할을 수행합니다.
- 일부 stateful objects를 캐싱(cache)하고 폐기(dispose)함
- 테스트 중에 해당 객체를 모킹(mock)하는 방법을 제공함
- 위젯들이 간단하게 해당하는 객체들을 구독(listen)하는 방법을 제공함

반면에, Riverpod는 다음과 같이 Provider가 가지고 있는 다양한 근본적인 문제를 해결 할 수 있습니다:
1. Provider의 조합을 크게 단순화합니다. 지루하고 오류가 발생하기 쉬운 `ProxyProvider` 대신, Riverpod는 `ref.watch` 및 `ref.listen`과 같은 간단하면서도 강력한 유틸리티를 제공합니다.
2. 여러 Provider가 같은 타입에 노출되는 것을 허용합니다. 이렇게 하면 int나 String같은 primitive type을 사용할 때 따로 class를 정의 할 필요가 없습니다.
   - 부연설명을 하자면, Provider에서는 타입추론으로 어떤 프로바이더를 불러올지 유추했습니다. 그래서 primitive당 Provider를 하나밖에 못썼었는데 Riverpod에서는 해당 문제를 해결하기 위해 클래스를 만들어서 inject했다고 합니다.
3. 테스트 내에서 프로바이더를 다시 정의할 필요가 없습니다. Riverpod에서는 기본적으로 테스트 내부에서 providers를 사용할 수 있습니다.
4. 객체를 dispose하는 대체 방법을 제공(autoDispose)함으로써 객체 처리를 위한 "범위 지정"에 대한 과도한 의존도 감소시켰습니다. Provider의 범위를 지정하는 것은 강력하지만, 고급스럽고 올바르게 수행하기는 매우 어렵습니다.

Riverpod의 유일한 단점이라고 볼 수 있는 점은, 다음과 같이 widget의 유형을 변경해야 한다는 것입니다.
   - Instead of extending `StatelessWidget`, with Riverpod you should extend `ConsumerWidget`.
   - Instead of extending `StatefulWidget`, with Riverpod you should extend `ConsumerStatefulWidget`.

따라서, Riverpod을 사용해야하는지 스스로 물어본다면 그렇다고할 가능성이 높습니다. Riverpod는 Provider에 비해 더 잘 설계되었으며 로직을 대폭 단순화 할 수 있습니다.


## The difference between Provider and Riverpod

Defining providers: 두 패키지의 가장 주요한 차이점은, "providers"가 정의되는 방식있습니다. 

Provider(Package)에서 providers는 ***위젯***이며, 위젯 트리 내부(일반적으로 MultiProvider 내부)에 배치됩니다.

```dart
class Counter extends ChangeNotifier {
 ...
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Counter>(create: (context) => Counter()),
      ],
      child: MyApp(),
    )
  );
}
```

하지만, Riverpod에서 providers는 ***widget이 아닙니다!!!*** 그저 일반 다트 객체 (plain Dart objects)입니다.
그래서 Riverpod에서 providers는 widget tree 밖에 존재하며, 전역 변수(global final variables)로 선언됩니다.
따라서 Riverpod이 작동하려면, 전체 application 위에 ProviderScope 위젯을 추가해야합니다.

```dart
// Providers are now top-level variables
final counterProvider = ChangeNotifierProvider<Counter>((ref) => Counter());

void main() {
  runApp(
    // This widget enables Riverpod for the entire project
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```

Riverpod에서 providers는 plain Dart objects이기 때문에 Flutter없이도 Riverpod을 사용할 수 있다고 합니다! 예를 들면 커맨드 라인 어플리케이션에서도 Riverpod을 사용 할 수 있습니다.


</div>
</details>