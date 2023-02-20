import 'dart:async';

import 'package:flutter/material.dart';


typedef RetryCallback = Future Function();

class RequestRetry extends StatefulWidget {
  final String? message;
  final RetryCallback retryCallback;

  const RequestRetry({Key? key, this.message, required this.retryCallback ,})
      : super(key: key);

  @override
  _RequestRetryState createState() => _RequestRetryState();
}

class _RequestRetryState extends State<RequestRetry> {
  bool isRetrying = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.message != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.message ?? ''),
            )
          else
            Container(),
          Padding(
            padding: Localizations.localeOf(context).languageCode == 'en'
                ? const EdgeInsets.only(left: 32.0)
                : const EdgeInsets.only(right: 24.0),
            child: SizedBox(
              width: 144,
              child: Row(
                children: <Widget>[
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: !isRetrying
                        ? () {
                            setState(() {
                              isRetrying = true;
                            });
                            widget.retryCallback().then((_) {
                              if (mounted) {
                                setState(() {
                                  isRetrying = false;
                                });
                              }
                            });
                          }
                        : null,
                    textColor: Colors.white,
                    child: const Text('Retry'),
                  ),
                  if (isRetrying)
                    const SizedBox(
                      height: 30,
                      width: 30,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
