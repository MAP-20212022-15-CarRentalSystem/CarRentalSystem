import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class NoRecordWidget extends StatelessWidget {
  const NoRecordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Record Found'),
    );
  }
}

class ErrorHandleWidget extends StatelessWidget {
  const ErrorHandleWidget({Key? key, required this.error}) : super(key: key);
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.msg}) : super(key: key);
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msg),
    );
  }
}
