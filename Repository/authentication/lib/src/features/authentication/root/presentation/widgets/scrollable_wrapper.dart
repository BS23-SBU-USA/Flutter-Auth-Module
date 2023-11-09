import 'package:auth_module/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ScrollableWrapper extends StatelessWidget {
  const ScrollableWrapper({
    required this.child,
    this.appBar,
    this.alignment,
    this.dismissKeyboard = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    super.key,
  });

  final Widget child;
  final AppBar? appBar;
  final bool? dismissKeyboard;
  final AlignmentGeometry? alignment;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: UIColors.white,
        appBar: appBar,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: alignment ?? Alignment.bottomCenter,
                child: SingleChildScrollView(
                  keyboardDismissBehavior: (dismissKeyboard ?? true)
                      ? ScrollViewKeyboardDismissBehavior.onDrag
                      : ScrollViewKeyboardDismissBehavior.manual,
                  padding: _buildPadding,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight -
                          (appBar?.preferredSize.height ?? 0) +
                          topPadding +
                          bottomPadding,
                    ),
                    child: IntrinsicHeight(
                      child: child,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }

  static double topPadding = 24;
  static double bottomPadding = 24;
  static double leftPadding = 24;
  static double rightPadding = 24;

  EdgeInsets get _buildPadding {
    return EdgeInsets.only(
      top: topPadding,
      bottom: bottomPadding,
      left: leftPadding,
      right: rightPadding,
    );
  }
}
