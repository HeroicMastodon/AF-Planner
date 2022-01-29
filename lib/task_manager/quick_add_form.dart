import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

typedef OnQuickAdd = void Function(String name, String description);

class QuickAddForm extends HookWidget {
  const QuickAddForm({Key? key, required this.onQuickAdd}) : super(key: key);

  final OnQuickAdd onQuickAdd;

  @override
  Widget build(BuildContext context) {
    final name = useState("");
    final description = useState("");
    final shouldClose = useState(true);

    return WillPopScope(
      onWillPop: () async {
        if (!shouldClose.value) {
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: const Text(
                        "Are you sure you want to close? Unsaved data will be lost."),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            shouldClose.value = true;
                          },
                          child: const Text("Close"))
                    ],
                  ));
        }

        return shouldClose.value;
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      name.value = value;
                      shouldClose.value = false;
                    },
                  )),
                  IconButton(
                      onPressed: () {
                        onQuickAdd(name.value, description.value);
                        shouldClose.value = true;
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      splashRadius: 20,
                  )
                ],
              ),
              TextFormField(
                minLines: 2,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontWeight: FontWeight.w200),
                decoration: const InputDecoration(
                    hintText: "Description", border: InputBorder.none),
                onChanged: (value) {
                  description.value = value;
                  shouldClose.value = false;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

showQuickAdd({required BuildContext context, required OnQuickAdd onQuickAdd}) {
  showMaterialModalBottomSheet(
      context: context,
      builder: (context) => QuickAddForm(onQuickAdd: onQuickAdd),
      expand: false,
      duration: const Duration(milliseconds: 300),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))));
}
