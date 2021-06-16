class CryptoModel {
  final int number;
  final String name;
  final double value;

  CryptoModel({required this.number,
    required this.name,
    required this.value
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    dynamic quote = json['quote'];
    // dynamic usdMap = quote[0];
    dynamic usd = quote['USD'];
    dynamic price = usd['price'];

    return CryptoModel(
      number: json['id'],
      name: json['name'],
      value: price //json['quote'][0]['USD'][0]['price'],
    );
  }
}
