class AppSettings {
  final String address;
  final int port;

  const AppSettings(this.address, this.port);

  @override
  String toString() {
    return '$AppSettings(address: $address, port: $port)';
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'port': port,
    };
  }
}
