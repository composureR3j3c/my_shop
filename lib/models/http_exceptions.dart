class HttpExceptions {
  final String message;
  HttpExceptions(this.message);

  @override
  String toString() {
    return message;
    // return super.toString();
  }
}
