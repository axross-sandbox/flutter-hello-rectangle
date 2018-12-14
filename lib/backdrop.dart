import 'dart:math' show max, min;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import './category.dart';

class Backdrop extends StatefulWidget {
  final Category category;
  final Widget frontPanel;
  final Widget backPanel;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.category,
    @required this.frontPanel,
    @required this.backPanel,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(category != null),
        assert(frontPanel != null),
        assert(backPanel != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.category != oldWidget.category) {
      setState(() {
        _controller.fling(velocity: _backdropPanelVisible ? 2.0 : 2.0);
      });
    } else if (!_backdropPanelVisible) {
      setState(() {
        _controller.fling(velocity: 2.0);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: widget.category.color,
          elevation: 0.0,
          leading: IconButton(
            onPressed: _toggleBackdropPanelVisibility,
            icon: AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _controller.view,
            ),
          ),
          title: _BackdropTitle(
            listenable: _controller.view,
            frontTitle: widget.frontTitle,
            backTitle: widget.backTitle,
          ),
        ),
        body: LayoutBuilder(
          builder: _buildStack,
        ),
      );

  bool get _backdropPanelVisible {
    final status = _controller.status;

    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const panelTitleHeight = 48.0;
    final panelSize = constraints.biggest;
    final panelTop = panelSize.height - panelTitleHeight;

    var panelAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, panelTop, 0, panelTop - panelSize.height),
      end: RelativeRect.fromLTRB(0, 0, 0, 0),
    ).animate(_controller.view);

    return Container(
      key: _backdropKey,
      color: widget.category.color,
      child: Stack(
        children: [
          widget.backPanel,
          PositionedTransition(
            rect: panelAnimation,
            child: _BackdropPanel(
              onTap: _toggleBackdropPanelVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              title: Text(widget.category.name),
              child: widget.frontPanel,
            ),
          ),
        ],
      ),
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    _controller.value -= details.primaryDelta / _backdropHeight;
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();

    return renderBox.size.height;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;

    if (flingVelocity < 0) {
      _controller.fling(velocity: max(2.0, -flingVelocity));
    } else if (flingVelocity > 0) {
      _controller.fling(velocity: min(-2.0, -flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
    }
  }
}

class _BackdropTitle extends AnimatedWidget {
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    @required Animation<double> listenable,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final animation = listenable;

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Stack(
        children: [
          Opacity(
            opacity: CurvedAnimation(
              parent: ReverseAnimation(listenable),
              curve: Interval(0.5, 1.0),
            ).value,
            child: backTitle,
          ),
          Opacity(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Interval(0.5, 1.0),
            ).value,
            child: frontTitle,
          ),
        ],
      ),
    );
  }
}

class _BackdropPanel extends StatelessWidget {
  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;

  const _BackdropPanel({
    Key key,
    @required this.onTap,
    @required this.onVerticalDragUpdate,
    @required this.onVerticalDragEnd,
    @required this.title,
    @required this.child,
  })  : assert(onTap != null),
        assert(onVerticalDragUpdate != null),
        assert(onVerticalDragEnd != null),
        assert(title != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        elevation: 2.0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: onVerticalDragUpdate,
              onVerticalDragEnd: onVerticalDragEnd,
              onTap: onTap,
              child: Container(
                height: 48.0,
                padding: EdgeInsetsDirectional.only(start: 16.0),
                alignment: AlignmentDirectional.centerStart,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.subhead,
                  child: title,
                ),
              ),
            ),
            Divider(height: 1.0),
            Expanded(child: child),
          ],
        ),
      );
}
