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
            child: Text('StateProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StateNotifierProviderScreen(),
                ),
              );
            },
            child: Text('StateNotifierProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProviderScreen(),
                ),
              );
            },
            child: Text('ProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FutureProviderScreen(),
                ),
              );
            },
            child: Text('FutureProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StreamProviderScreen(),
                ),
              );
            },
            child: Text('StreamProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FamilyProviderScreen(),
                ),
              );
            },
            child: Text('FamilyProviderScreen'),
          ),
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
                  builder: (_) => AutoDisposeScreen(),
                ),
              );
            },
            child: Text('AutoDisposeScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ListenProviderScreen(),
                ),
              );
            },
            child: Text('ListenProviderScreen'),
          ),
          DefaultElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SelectProviderScreen(),
                ),
              );
            },
            child: Text('SelectProviderScreen'),
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
