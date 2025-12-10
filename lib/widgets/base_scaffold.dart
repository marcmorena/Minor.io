import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const BaseScaffold({super.key, this.appBar, required this.body});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: appBar != null
          ? AppBar(
              title: appBar!.preferredSize.height > 0 ? (appBar as AppBar).title : null,
              actions: (appBar as AppBar?)?.actions,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [Color(0xFF2D4B73), Color(0xFF1C314F)]
                        : [Color(0xFF3B5BA9), Color(0xFF9DB6E3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            )
          : null,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [Color(0xFF2D4B73), Color(0xFF1C314F)]
                    : [Color(0xFF3B5BA9), Color(0xFF9DB6E3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
