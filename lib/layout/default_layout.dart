import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final String? description;

  const DefaultLayout({
    required this.title,
    required this.body,
    this.actions,
    Key? key,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: Column(
        children: [
          _ExplainBox(description: description),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExplainBox extends StatelessWidget {
  final String? description;
  const _ExplainBox({
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (description == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[300],
        ),
        constraints: BoxConstraints(
          minHeight: 100.0,
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: description!,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
