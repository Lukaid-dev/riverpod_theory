import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/listen_provider.dart';

class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ListenProviderScreen> createState() =>
      _ListenProviderScreenState();
}

class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 10,
      vsync: this,
      initialIndex: ref.read<int>(listenProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    String description = '''
보통 listen은 initState에서 사용되지만, riverpod에서는 build함수 내에서도 사용가능하다.
ConsumerStatefulWidget은 바로 ref에 접근 할 수 있다.
ref.listen : Provider의 state가 변할 때마다 호출되는 함수
''';
    ref.listen<int>(listenProvider, (previous, next) {
      if (previous != next) {
        tabController.animateTo(
          next,
          duration: const Duration(seconds: 1),
        );
      }
    });

    return DefaultLayout(
      title: 'ListenProvider',
      description: description,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: List.generate(
          10,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('TAB : ${index + 1}', textAlign: TextAlign.center),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(listenProvider.notifier)
                            .update((state) => state == 0 ? 0 : state - 1);
                      },
                      child: const Text('뒤로'),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const _NextScreen(),
                          ),
                        );
                      },
                      child: const Text('다음페이지'),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(listenProvider.notifier)
                            .update((state) => state == 10 ? 10 : state + 1);
                      },
                      child: const Text('다음'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: 'NextScreen',
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 0 ? 0 : state - 1);
                },
                child: const Text('뒤로'),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 10 ? 10 : state + 1);
                },
                child: const Text('다음'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
