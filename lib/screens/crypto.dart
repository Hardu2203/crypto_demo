import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:crypto_demo/models/crypto-favorites.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_demo/drawer/drawer-template.dart';
import 'package:crypto_demo/models/crypto.dart';
import 'package:flutter/material.dart';

Future<List<CryptoModel>> fetchCryptos() async {
  Map<String, String> requestHeaders = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "X-CMC_PRO_API_KEY": ""
  };

  final response = await http.get(
    Uri.parse(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&convert=usd'),
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseJson = jsonDecode(response.body);
    Iterable I = responseJson['data'];
    return List<CryptoModel>.from(
        I.map((model) => CryptoModel.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class MyCrypto extends StatefulWidget {
  const MyCrypto({Key? key}) : super(key: key);

  @override
  _MyCryptoState createState() => _MyCryptoState();
}

class _MyCryptoState extends State<MyCrypto> {
  late Future<List<CryptoModel>> _futureCryptos;
  late CryptoFavorites _cryptoFavorites;
  // int _count = 0;

  @override
  void initState() {
    super.initState();
    _futureCryptos = fetchCryptos();

  }

  @override
  void didChangeDependencies() {
    _cryptoFavorites = Provider.of<CryptoFavorites>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto"),
        actions: [
          Text("Favorite count: ${_cryptoFavorites.faves.length}")
        ],
      ),
      drawer: DrawerTemplate(),
      body: Center(
        child: FutureBuilder<List<CryptoModel>>(
          future: _futureCryptos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: ExcludeSemantics(
                      child: CircleAvatar(child: Text(i.toString()),),
                    ),
                    title: Text(snapshot.data![i].name),
                    subtitle: Text(snapshot.data![i].value.toInt().toString()),
                    onTap: () {
                      _cryptoFavorites.add(snapshot.data![i]);
                    },
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
