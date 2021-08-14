# rsa_test

RSA로 키생성 및 암복호화 Flutter 예제 프로젝트입니다.  
공개키는 PKCS#1으로 생성이 되어 자바(Spring 등)에서 해당 공개키 사용을 원할시에는 PKCS#8로 바꾸는 것이 좋을 것입니다.  

## 주요 코드
```
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
```

## 참조 라이브러리

아래의 라이브러리를 참조해서 만들었습니다.  

- [fast_rsa 3.0.0](https://pub.dev/packages/fast_rsa)
