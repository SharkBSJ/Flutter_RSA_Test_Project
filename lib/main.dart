import 'package:fast_rsa/rsa.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Encryption Demo',
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  TestScreen createState() => TestScreen();
}

class TestScreen extends State<TestPage> {
  String publicKey = '';
  String privateKey = '';
  String challenge = '';

  _generateKey() async {
    var helper = RsaKeyHelper();
    var keyPair = await helper.computeRSAKeyPair(helper.getSecureRandom());
    publicKey = helper.encodePublicKeyToPemPKCS1(keyPair.publicKey as RSAPublicKey);
    privateKey = helper.encodePrivateKeyToPemPKCS1(keyPair.privateKey as RSAPrivateKey);

    var result = await RSA.generate(2048);
    var result2 = await RSA.convertPublicKeyToPKCS1(result.publicKey);
    privateKey = result.privateKey;
    publicKey = result2;
    publicKey = publicKey.replaceAll('-----BEGIN PUBLIC KEY-----', '');
    publicKey = publicKey.replaceAll('\r', '');
    publicKey = publicKey.replaceAll('\n', '');
    publicKey = publicKey.replaceAll('-----END PUBLIC KEY-----', '');

    print(publicKey);
  }

  // fast_rsa: ^3.0.0
  _decrypt() async {
    //var helper = RsaKeyHelper();
    //RSAPrivateKey pk = helper.parsePrivateKeyFromPem(privateKey);
    
    //print(decrypt(challenge, pk));

    var result = await RSA.decryptPKCS1v15(challenge, privateKey);
    print(result);
  }

  @override
  initState() {
    super.initState();
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            ElevatedButton(
              onPressed: () => _generateKey(), child: Text('생 성')
            ), 
            TextField(
              onChanged: (value) {
                setState(() {
                  challenge = value;
                });
              },
            ), 
            ElevatedButton(
              onPressed: () => _decrypt(), child: Text('복호화')
            ),
          ],)
        )
      )
    );
  }
}