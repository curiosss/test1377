class KError {
  final String message;
  KError(this.message);
}

class NoInternet extends KError {
  NoInternet({String? message})
      : super(message ?? 'The application requires access to the network');
}
