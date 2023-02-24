import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_elevated_button.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/screen/async_value_screen.dart';
import 'package:riverpod_theory/screen/auto_dispose_screen.dart';
import 'package:riverpod_theory/screen/listen_provider_screen.dart';
import 'package:riverpod_theory/screen/map_and_when_screen.dart';
import 'package:riverpod_theory/screen/family_provider_screen.dart';
import 'package:riverpod_theory/screen/future_provider_screen.dart';
import 'package:riverpod_theory/screen/provider_screen.dart';
import 'package:riverpod_theory/screen/select_provider_screen.dart';
import 'package:riverpod_theory/screen/state_notifier_provider_screen.dart';
import 'package:riverpod_theory/screen/state_provider_screen.dart';
import 'package:riverpod_theory/screen/stream_provider_screen.dart';
import 'package:riverpod_theory/screen/using_ref_insde_screen.dart';

import 'code_generation_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String description = '''
riverpod에서 모든 provider는 Global하게 선언된다.
''';

    return DefaultLayout(
      title: 'Riverpod Theory',
      description: description,
      body: ListView(
        children: [
          const SizedBox(height: 16.0),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StateProviderScreen(),
                ),
              );
            },
            child: const Text('StateProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StateNotifierProviderScreen(),
                ),
              );
            },
            child: const Text('StateNotifierProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FutureProviderScreen(),
                ),
              );
            },
            child: const Text('FutureProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StreamProviderScreen(),
                ),
              );
            },
            child: const Text('StreamProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FamilyProviderScreen(),
                ),
              );
            },
            child: const Text('FamilyProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AutoDisposeScreen(),
                ),
              );
            },
            child: const Text('AutoDisposeScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ListenProviderScreen(),
                ),
              );
            },
            child: const Text('ListenProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SelectProviderScreen(),
                ),
              );
            },
            child: const Text('SelectProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProviderScreen(),
                ),
              );
            },
            child: const Text('ProviderScreen'),
          ),
          ////////////////////////////////////////////////////////////
          // divider
          const SizedBox(height: 8.0),
          const Divider(
            color: Colors.black,
            height: 1.0,
          ),
          const SizedBox(height: 16.0),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CodeGenerationScreen(),
                ),
              );
            },
            child: const Text('CodeGenerationScreen'),
          ),
          ////////////////////////////////////////////////////////////
          // divider
          const SizedBox(height: 8.0),
          const Divider(
            color: Colors.black,
            height: 1.0,
          ),
          const SizedBox(height: 16.0),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MapAndWhenScreen(),
                ),
              );
            },
            child: Text('MapAndWhenScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AsyncValueScreen(),
                ),
              );
            },
            child: Text('AsyncValueScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => UsingRefInsideScreen(),
                ),
              );
            },
            child: Text('UsingRefInsideScreen'),
          ),
        ],
      ),
    );
  }
}
