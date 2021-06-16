

import 'package:crypto_demo/models/crypto.dart';
import 'package:flutter/cupertino.dart';

class CryptoFavorites extends ChangeNotifier{
  final List<CryptoModel> faves = [];

  int get count => faves.length;

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(CryptoModel item) {
    faves.add(item);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(CryptoModel item) {
    faves.remove(item);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}
