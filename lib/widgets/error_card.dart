import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class ErrorCard extends StatelessWidget {
  final String? message;
  final void Function()? onPressed;
  const ErrorCard({
    super.key,
    this.message,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 100,
            color: Colors.redAccent,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            message ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(
            height: 24,
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.redAccent,
              ),
              onPressed: onPressed,
              child: Text(
                S.current.refresh,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w400,
                    ),
              ))
        ],
      ),
    );
  }
}
