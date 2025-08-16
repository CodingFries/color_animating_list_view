import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ColorAnimatingListView extends StatefulWidget {
  /// Creates a ListView which changes background color based on the widget or widgets visible.
  ///
  /// children.length should be equal to colors.length.

  ColorAnimatingListView({
    required this.children,
    required this.colors,
    this.animationDuration = const Duration(seconds: 1),
  });
  final List<Widget> children;
  final List<Color> colors;
  final Duration animationDuration;

  @override
  _ColorAnimatingListViewState createState() {
    assert(children.length == colors.length);
    return _ColorAnimatingListViewState();
  }
}

class _ColorAnimatingListViewState extends State<ColorAnimatingListView> {
  //Current Background Color - Transparent if there are no children.
  late Color _color = widget.colors.isNotEmpty
      ? widget.colors[0]
      : Colors.transparent;

  //List to store the visibility values of widgets on the screen.
  late List<double> _visibility = List.generate(
    widget.colors.length,
    (index) => 0.0,
  );
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //Add Listener to scrollController that will update the color value on every scroll.
    _scrollController.addListener(() {
      VisibilityDetectorController.instance.notifyNow();
      changeColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: _color,
      duration: widget.animationDuration,
      child: ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return FadeIn(
            child: VisibilityDetector(
              onVisibilityChanged: (VisibilityInfo info) {
                _visibility[index] = info.visibleFraction;
              },
              key: Key('Widget-$index'),
              child: widget.children[index],
            ),
            duration: widget.animationDuration,
          );
        },
        itemCount: widget.children.length,
      ),
    );
  }

  void changeColor() {
    //Function to update the background Color on the basis of height a widget occupies in the ListView
    final double sum = _visibility.fold(0, (p, c) => p + c);
    for (int i = 0; i < _visibility.length; i++) {
      if (_visibility[i] > 1) {
        _visibility[i] /= sum;
      }
    }

    Color _result = Colors.transparent;
    for (int i = 0; i < widget.colors.length; i++) {
      _result = _result.mix(widget.colors[i], _visibility[i])!;
    }
    setState(() {
      _color = _result;
    });
  }
}
