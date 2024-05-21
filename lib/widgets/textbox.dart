


import 'package:flutter/material.dart';
import 'package:skill_share_veteran/config/styles.dart';



class Textbox extends StatefulWidget {
  final TextInputType type;
  final dynamic icon;
  final bool hideText;
  final TextEditingController tcontroller;
  final String hinttext;
  const Textbox({
    super.key,
    required this.hideText,
    required this.tcontroller,
    required this.type,
    required this.hinttext,
     this.icon=const SizedBox(),
  });

  @override
  State<Textbox> createState() => _TextboxState();
}

class _TextboxState extends State<Textbox> {
  late bool show = widget.hideText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.075,
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant,
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
      ),
      child: Center(
        child: TextFormField(
          style: Styles.labelText(context),
          cursorColor: colorScheme.onPrimary,
          keyboardType: widget.type,
          controller: widget.tcontroller,
          obscureText: show,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            hintText: widget.hinttext,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            filled: true,
            fillColor: colorScheme.onSurfaceVariant,
            suffixIcon: widget.hideText
                ? IconButton(
                    icon: Icon(
                      show ? Icons.visibility : Icons.visibility_off,
                      color: colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}

class Textbox2 extends StatefulWidget {
  final TextInputType type;
  final dynamic icon;
  final bool hideText;
  final TextEditingController tcontroller;
  final String hinttext;
  const Textbox2({
    super.key,
    required this.hideText,
    required this.tcontroller,
    required this.type,
    required this.hinttext,
    this.icon = const SizedBox(),
  });

  @override
  State<Textbox2> createState() => _Textbox2State();
}

class _Textbox2State extends State<Textbox2> {
  late bool show = widget.hideText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // ignore: deprecated_member_use
    final lineHeight = MediaQuery.of(context).textScaleFactor * 20.0; 
    return Container(
      height: 5 * lineHeight + 16.0, 
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant,
        borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.height * 0.02),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: SingleChildScrollView(
            child: TextFormField(
              style: Styles.labelText(context),
              cursorColor: colorScheme.onPrimary,
              keyboardType: widget.type,
              controller: widget.tcontroller,
              obscureText: show,
              maxLines: 3,
              decoration: InputDecoration(
                prefixIcon: widget.icon,
                hintText: widget.hinttext,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                filled: true,
                fillColor: colorScheme.onSurfaceVariant,
                suffixIcon: widget.hideText
                    ? IconButton(
                        icon: Icon(
                          show ? Icons.visibility : Icons.visibility_off,
                          color: colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
