# riverpod_theory

제가 Riverpod에 대해 공부하면서 정리한 내용입니다. 다음의 강의와 문서를 참고했습니다. Repo의 Code들은 Codefactory님의 강의를 기반으로 이해를 돕기위해 추가된 내용들을 포함하고 있습니다.

- [Codefactory 강의 링크](https://www.inflearn.com/course/%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%8B%A4%EC%A0%84/dashboard)
- [Riverpod 공식 문서](https://docs-v2.riverpod.dev/)
- [Riverpod for Provider users](https://docs-v2.riverpod.dev/docs/riverpod_for_provider_users)


<details>
<summary>Provider사용자를 위한 Riverpod 가이드 _ 번역</summary>
<div>

## The relationship between Riverpod and Provider

Riverpod는 Provider의 다음 버전으로, Provider의 모든 기능을 포함하고 있습니다. (Riverpod는 Provider의 정신적 계승자로 설계되었으며, 그 이름도 Provider의 애너그램입니다.)

당연하겠지만, Riverpod는 Provider의 여러 기술적 한계를 해결하기 위해 탄생하였습니다. 원래는 Provider의 메이저 업데이트의 일환으로 Riverpod을 출시 할 계획이었지만, 바뀐것도 많고 Provider도 워낙 많이 사용하는 패키지이기 때문에, Riverpod을 새로운 패키지로 출시하였습니다.

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

## Reading providers: BuildContext

Provider에서 providers를 읽어오는 방법은 widget의 BuildContext를 이용하는 것이 유일합니다.

예를들어 다음과 같이 정의된 provider는

```dart
Provider<Model>(...);
```

다음과 같이 읽어옵니다.

```dart
class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Model model = context.watch<Model>();

  }
}
```

하지만, Riverpod에서는 다음과 같이 읽어옵니다.

```dart
final modelProvider = Provider<Model>(...);

class Example extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Model model = ref.watch(modelProvider);

  }
}
```

차이점이 보이시나요? 다음에 주목해보세요!

- Riverpod의 경우 StatelessWidget 대신 ConsumerWidget을 extends합니다. 그리고 build함수 안에 WidgetRef type의 매개변수가 추가됩니다.
- Provider에서는 BuildContext.watch를 사용했지만 Riverpod의 경우 ConsumerWidget에 포함된 WidgetRef를 이용하여 WidgetRef.watch를 사용합니다.
- Riverpod는 Provider와 다르게, generic types에 의존하지 않습니다(타입으로 유추하지 않음). 대신에 provider에서 정의한 변수에 의존하죠. 그래서 위에서 정의한 modelProvider를 이용하여 ref.watch를 사용합니다. 이렇게 하면 generic type을 사용하지 않아도 되기 때문에 코드가 더 간결해집니다. 

Riverpod나 Provider에서 둘 다 watch keyword를 “해당 값이 변경되었을 때 이 위젯은 리빌드 되어야해!”하고 알려주는 용도로 사용합니다.

### read vs watch

이 문제는 Provider에서와 마찬가지로 작용합니다. 

- BuildContext.watch -> WidgetRef.watch
- BuildContext.read -> WidgetRef.read

build 메서드 내에서는 watch를 사용하고, 클릭 핸들러 및 기타 이벤트 내부에서는 read를 사용합니다. (쉽게, UI를 업데이트하는 경우 watch를 사용하고, UI를 업데이트하지 않는 경우 read를 사용합니다.)


## Reading providers: Consumer

Provider는 선택적으로 Consumer라는 이름의 위젯(및 Consumer2와 같은 변형)과 함께 providers를 읽어오기 위한 위젯을 제공합니다. 이는 필수가 아니지만, Consumer는 위젯 트리를 보다 세밀하게 재구성하여 상태가 변경될 때 해당 위젯만 업데이트할 수 있으므로 성능 최적화에 유리합니다. (실제로 저는 Provider를 사용한 프로젝트에서 Consumer를 거의 사용하지 않았습니다.)

따라서 provider가 다음과 같이 정의되면,

```dart
Provider<Model>(...); 
```

Consumer를 사용하여 해당 provider를 다음과 같이 읽을 수 있습니다.

```dart
Consumer<Model>(
  builder: (BuildContext context, Model model, Widget? child) {

  }
)
```

Riverpod도 같은 원리를 가지고 있고, Riverpod에도 정확히 똑같은 용도의 Consumer라는 위젯이 있습니다. (Riverpod 2.0에서 업데이트 되었습니다.)

provider를 다음과 같이 정의했다면,

```dart
final modelProvider = Provider<Model>(...);
```

다음과 같이 Consumer를 사용할 수 있습니다.

```dart
Consumer<Model>(
  builder: (BuildContext context, WidgetRef ref, Widget? child) {
    Model model = ref.watch(modelProvider);

  }
)
```

Consumer가 어떻게 WidgetRef 객체를 제공하는지 주목해보면, 이전 파트에서 ConsumerWidget과 관련된 것과 동일한 것을 알 수 있습니다. 이렇게 하면, 위젯 내에서 내가 원하는 부분만 rebuild 할 수 있습니다. 심지어, Consumer위젯 내에서 child parameter를 제공하는데, rebuild시 이 child는 재사용되며, rebuild되지 않습니다. 이는 성능 최적화에 유리합니다.

## Combining providers: ProxyProvider with stateless objects

Provider를 사용할 때 providers를 결합하는 공식적인 방법은 ProxyProvider 위젯(또는 ProxyProvider2와 같은 변형)을 사용하는 것입니다. (상당히 복잡하고 어렵습니다... 제가 Provider를 사용하면서 가장 불만을 크게 느낀 부분입니다.)

예를들어 다음과 같이 정의했다면,

```dart
class UserIdNotifier extends ChangeNotifier {
  String? userId;
}

// ...

ChangeNotifierProvider<UserIdNotifier>(create: (context) => UserIdNotifier()),
```

provider를 proxy하는 두가지 방법이 있는데, 첫번쨰는 다음과 같습니다. (StatelessWidget)

새로운 "stateless" provider를 생성하기 위해 UserIdNotifier를 결합할 수 있습니다. 

```dart
ProxyProvider<UserIdNotifier, String>(
  update: (context, userIdNotifier, _) {
    return 'The user ID of the the user is ${userIdNotifier.userId}';
  }
)
```

이 provider는 UserIdNotifier.userId가 변경될 때마다 자동으로 새 String을 반환합니다.

Riverpod에서도 비슷한 작업을 수행할 수 있지만 문법이 다릅니다. 먼저, Riverpod에서는 UserIdNotifier를 다음과 같이 정의합니다.

```dart
class UserIdNotifier extends ChangeNotifier {
  String? userId;
}

// ...

final userIdNotifierProvider = ChangeNotifierProvider<UserIdNotifier>(
  (ref) => UserIdNotifier(),
),
```

이렇게해서 사용자 아이디로 문자열을 생성할 수 있습니다.

```dart
final labelProvider = Provider<String>((ref) {
  UserIdNotifier userIdNotifier = ref.watch(userIdNotifierProvider);
  return 'The user ID of the the user is ${userIdNotifier.userId}';
});
```

riverpod에서는 ProxyProvider와 같은 위젯이 없습니다. 대신에, 위젯 내에서 다른 providers를 읽을 수 있습니다. 위의 예제에서 `ref.watch(userIdNotifierProvider)`가 있는 라인을 주목해보세요.

해당 라인은 Riverpod에게 userIdNotifierProvider의 내용을 가져오고 해당 값이 변경될 때마다 labelProvider도 다시 계산되도록 지시합니다. 따라서 labelProvider가 내보내는 문자열은 userId가 변경될 때마다 자동으로 업데이트되죠.

ref.watch를 포함한 라인에서 익숙한 느낌을 받았을 수 있습니다. riverpod에서 일반적으로 ref.watch를 사용하여 provider를 읽어오듯, provider안에서 다른 provider의 값을 참조할 때도, 마찬가지로 ref.watch를 사용하면 됩니다!! (proxyProvider 완성!)


## Combining providers: ProxyProvider with stateful objects

provider를 proxy하는 두번째 방법 ChangeNotifier instance와 같은 StatefulWidget을 사용하는 것입니다. Provider에서는 ChangeNotifierProxyProvider(또는 ChangeNotifierProxyProvider2와 같은 변형)를 사용할 수 있습니다.

예를들면:

```dart
class UserIdNotifier extends ChangeNotifier {
  String? userId;
}

// ...

ChangeNotifierProvider<UserIdNotifier>(create: (context) => UserIdNotifier()),
```

이렇게 선언하고, UserIdNotifier.userId를 구독하는 알림을 만들 수 있습니다.

```dart
class UserNotifier extends ChangeNotifier {
  String? _userId;

  void setUserId(String? userId) {
    if (userId != _userId) {
      print('The user ID changed from $_userId to $userId');
      _userId = userId;
    }
  }
}

// ...

ChangeNotifierProxyProvider<UserIdNotifier, UserNotifier>(
  create: (context) => UserNotifier(),
  update: (context, userIdNotifier, userNotifier) {
    return userNotifier!
      ..setUserId(userIdNotifier.userId);
  },
);
```

이 새 프로바이더(ChangeNotifierProxyProvider)는 UserNotifier의 단일 인스턴스를 생성하고 사용자 ID가 변경될 때마다 문자열을 반환합니다.

riverpod에서는 어떨까요? 우선 `UserIdNotifier`를 다음과 같이 정의합니다.

```dart
class UserIdNotifier extends ChangeNotifier {
  String? userId;
}

// ...

final userIdNotifierProvider = ChangeNotifierProvider<UserIdNotifier>(
  (ref) => UserIdNotifier(),
),
```
이제 Provider에서의 `ChangeNotifierProxyProvider` 역할을 Riverpod에서는 어떻게 할 수 있을까요? Riverpod에서는 `ChangeNotifierProvider`를 사용하여 `UserNotifier`를 정의합니다.


```dart
class UserNotifier extends ChangeNotifier {}

final userNotfierProvider = ChangeNotifierProvider<UserNotifier>((ref) {
  final userNotifier = UserNotifier();
  ref.listen<UserIdNotifier>(
    userIdNotifierProvider,
    (previous, next) {
      if (previous?.userId != next.userId) {
        print('The user ID changed from ${previous?.userId} to ${next.userId}');
      }
    },
  );

  return userNotifier;
});
```

위 예제의 핵심은 `ref.listen`를 포함한 라인입니다. 
이 `ref.listen` 함수는 `userIdNotifierProvider`의 값이 변경될 때마다 callback을 호출합니다. 이 callback은 이전 값과 새로운 값을 인자로 받습니다. 이 예제에서는 이전 값과 새로운 값을 비교하여 사용자 ID가 변경되었는지 확인하고, 변경되었다면 변경된 값을 출력합니다.


</div>
</details>