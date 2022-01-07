import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

class ListItem extends HookWidget {
  ListItem(
      {Key? key,
      this.content,
      this.left,
      this.right,
      this.divider = false,
      this.children = const [],
      this.onTap,
      this.collapsable = true})
      : super(key: key);

  Widget? content;
  Widget? left;
  Widget? right;
  List<Widget> children;
  bool divider;
  GestureTapCallback? onTap;
  bool collapsable;

  @override
  Widget build(BuildContext context) {
    var collapsed = useState(false);
    var indicatorController = useAnimationController(
        duration: Duration(milliseconds: 200), upperBound: .5);
    var expandController = useAnimationController(
        duration: Duration(milliseconds: 200), initialValue: 1);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (left != null) left!,
            if (content != null)
              Expanded(
                  child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: onTap,
                          behavior: HitTestBehavior.opaque,
                          child: content))),
            if (right != null) right!,
            if (collapsable && children.isNotEmpty)
              RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(indicatorController),
                  child: IconButton(
                      splashRadius: 16,
                      onPressed: () {
                        if (collapsed.value) {
                          indicatorController.reverse(from: .5);
                          expandController.forward();
                        } else {
                          indicatorController.forward(from: 0);
                          expandController.reverse();
                        }
                        collapsed.value = !collapsed.value;
                      },
                      icon: const Icon(Icons.expand_less)))
          ],
        ),
        if (divider)
          const Divider(
            height: 1,
          ),
        SizeTransition(
          sizeFactor:
              CurvedAnimation(parent: expandController, curve: Curves.ease),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: children,
            ),
          ),
        )
      ],
    );
  }
}
